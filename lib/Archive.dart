import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gap/gap.dart';
import 'dart:io';
import 'package:lostlinker/login.dart';
import 'package:lostlinker/session_controller.dart';

class ArchivePage extends StatefulWidget {
  @override
  _ArchivePageState createState() => _ArchivePageState();
}

class _ArchivePageState extends State<ArchivePage> {
  late DatabaseReference postRef;
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    postRef = FirebaseDatabase.instance.reference().child('posts');

    
    _fetchUserPosts();
  }

  Future<void> _fetchUserPosts() async {
    try {
      
      String userId = SessionController().getUserId();

      
      DatabaseEvent snapshot = await postRef.child(userId).once();

      Map<dynamic, dynamic>? postsData = snapshot.snapshot.value as Map<dynamic, dynamic>?;

      
      if (postsData != null) {
        posts.clear();

        postsData.forEach((key, value) {
          
          Post post = Post(
            postId: key,
            description: value['description'],
            question: value['question'],
            postType: value['postType'],
            imageUrl: value['imageUrl'],
            timestamp: value['timestamp'],
          );

          posts.add(post);
        });

        
        setState(() {});
      } else {
        
        print('No posts found for user: $userId');
      }
    } catch (error) {
      
      print('Error fetching user posts: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archive'),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            
            SizedBox(height: 20),
           
            Expanded(
              child: ListView.builder(
                itemCount: posts.length,
                itemBuilder: (context, index) {
                  return PostCard(post: posts[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  final Post post;

  PostCard({required this.post});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 8,
      margin: EdgeInsets.all(8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
        side: BorderSide(color: Colors.black, width: 2),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),

              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(

                    post.imageUrl,
                    height: 150,
                    width: 150,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                    'Description:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  '${post.description}',
                  style: TextStyle(

                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Post Type:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${post.postType}',
                  style: TextStyle(
                    color: Colors.black54,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'Question:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  ' ${post.question}',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54,
                    fontSize: 15,
                  ),
                ),
                SizedBox(height: 8),
                /*Text(
                  'Timestamp: ${post.timestamp}',
                  style: TextStyle(
                    color: Colors.grey,
                  ),
                ),*/

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        textStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      ),
                      child: Text('Approve'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                        textStyle: TextStyle(fontSize: 13,fontWeight: FontWeight.bold),
                      ),
                      child: Text('Reject'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );


  }
}
class MyIconButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.info),
      onPressed: () {
        _showDialog(context);
      },
    );
  }

  void _showDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Information'),
          content: Text('This is a dialog box opened by the IconButton.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
class Post {
  final String postId;
  final String description;
  final String question;
  final String postType;
  final String imageUrl;
  final dynamic timestamp;

  Post({
    required this.postId,
    required this.description,
    required this.question,
    required this.postType,
    required this.imageUrl,
    required this.timestamp,
  });

  factory Post.fromMap(Map<dynamic, dynamic> map) {
    return Post(
      postId: map['postId'] ?? '',
      description: map['description'] ?? '',
      question: map['question'] ?? '',
      postType: map['postType'] ?? '',
      imageUrl: map['imageUrl'] ?? '',
      timestamp: map['timestamp'] ?? '',
    );
  }
}
