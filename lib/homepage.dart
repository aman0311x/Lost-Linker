import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:gap/gap.dart';
import 'package:lostlinker/session_controller.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
             
              
            },
          ),
        ],
      ),
      body: AllPostsTab(),
    );
  }
}

class AllPostsTab extends StatefulWidget {
  @override
  _AllPostsTabState createState() => _AllPostsTabState();
}

class _AllPostsTabState extends State<AllPostsTab> {
  late DatabaseReference _databaseReference;
  String logedinuserId = SessionController().getUserId();
  final List<Map<String, dynamic>> _posts = [];

  @override
  void initState() {
    super.initState();
    _databaseReference = FirebaseDatabase.instance.reference().child('posts');
    _fetchPosts();
  }

  Future<void> _fetchPosts() async {
    try {
      DatabaseEvent dataSnapshot = await _databaseReference.once();

      _posts.clear();
      if (dataSnapshot.snapshot.value != null) {
        Map<dynamic, dynamic> map = dataSnapshot.snapshot.value as Map<dynamic, dynamic>;
        map.forEach((userId, userPosts) {
          userPosts.forEach((postId, postDetails) {
            _posts.add(Map<String, dynamic>.from(postDetails));
          });
        });
      }
      setState(() {});
    } catch (error) {
      print('Error fetching posts: $error');
    }
  }

  String _formatPostTime(dynamic timestamp) {
    if (timestamp is String) {
      return timestamp;
    } else if (timestamp is int) {
      DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(timestamp);
      return dateTime.toString();
    } else {
      throw ArgumentError('Invalid timestamp format');
    }
  }

  void _showClaimDialog(String question) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Claim Box',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min, 
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Question: $question',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              TextFormField(
                maxLines: 5,
                decoration: InputDecoration(
                  labelText: '           Your Answer',
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                // Implement logic for handling the claim
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                textStyle: TextStyle(fontSize: 13),
              ),
              child: Text('Submit'),
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    return _posts.isNotEmpty
        ? ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (context, index) {
        final post = _posts[index];
        return Card(
          elevation: 5,
          margin: EdgeInsets.all(8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(color: Colors.black, width: 2),
          ),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Posted ${_formatPostTime(post['timestamp'])}',
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        post['description'],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 50),
                      ElevatedButton(
                        onPressed: () {
                          print(logedinuserId);
                          _showClaimDialog(post['question']);
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          padding: EdgeInsets.symmetric(vertical: 2, horizontal: 20),
                          textStyle: TextStyle(fontSize: 13),
                        ),
                        child: Text('Claim'),
                      ),
                    ],
                  ),
                ),
                Gap(20),
                Expanded(
                  flex: 3,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        post['imageUrl'],
                        width: 100,
                        height: 150,
                        fit: BoxFit.cover,
                        alignment: Alignment.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    )
        : Center(
      child: Text('No posts available.'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

