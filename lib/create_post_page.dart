import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:gap/gap.dart';
import 'dart:io';

import 'package:lostlinker/session_controller.dart';

import 'package:image_picker/image_picker.dart';

import 'fontstyle.dart';

class CreatePostPage extends StatefulWidget {
  @override
  _CreatePostPageState createState() => _CreatePostPageState();
}


class _CreatePostPageState extends State<CreatePostPage> {
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late DatabaseReference dbRef;
  File? _selectedImage;



  String _postType = 'Lost'; 

  @override
  void initState() {
    super.initState();
    Firebase.initializeApp(); 
    dbRef = FirebaseDatabase.instance.reference().child('posts');
  }
  Future<void> _getImage() async {
    await Firebase.initializeApp();
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    /*if (_selectedImage == null) {
      
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Please select an image.'),
        duration: Duration(seconds: 2),
      ));
      return;
    }*/

    setState(() {
      if (pickedFile != null) {
        _selectedImage = File(pickedFile.path);
      }
    });
  }
  Future<void> _post() async {
    try {
      if (_selectedImage == null) {
       
        return;
      }

     
      final Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('post_images/${DateTime.now().toIso8601String()}');

     
      final UploadTask uploadTask = storageReference.putFile(_selectedImage!);
      final TaskSnapshot taskSnapshot = await uploadTask;

      
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();

   
      final User? user = _auth.currentUser;
      if (user == null) {

        return;
      }
      final String userEmail = SessionController().getUserId();

      
      dbRef.child(userEmail).push().set({
        'description': _descriptionController.text,
        'question': _questionController.text,
        'postType': _postType,
        'imageUrl': imageUrl,
        'timestamp': DateTime.now().toIso8601String(), // Convert DateTime to string
      });

     
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Post uploaded successfully!'),
        duration: Duration(seconds: 2),
      ));

      
      _descriptionController.clear();
      _questionController.clear();
      setState(() {
        _selectedImage = null;
      });
    } catch (error) {
      
      print('Error uploading post: $error');
     
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Error uploading post. Please try again.'),
        duration: Duration(seconds: 2),
      ));
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Post'),
        actions: [
          IconButton(
            onPressed: _post,
            icon: const Icon(Icons.upload_outlined),
          ),
        ],
      ),
      body: Center(

        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _postType = 'Lost';
                      });
                    },
                    style: _postType == 'Lost'
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.black12)
                        : null,
                    child: Text('Lost',style: TextStyle(color: Colors.black),),
                  ),
                  const SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _postType = 'Found';
                      });
                    },
                    style: _postType == 'Found'
                        ? ElevatedButton.styleFrom(backgroundColor: Colors.grey)
                        : null,
                    child: Text('Found',style: TextStyle(color: Colors.black),),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _descriptionController,
                maxLines: 5,
                decoration: const InputDecoration(
                  hintText: 'Enter your description here...',
                  border: OutlineInputBorder(),

                ),
              ),
              Gap(15),
              TextField(
                controller: _questionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  hintText: '  Enter your question here...',
                  border: OutlineInputBorder(),

                  contentPadding: EdgeInsets.symmetric(vertical: 8.0), 

                ),
              ),
              Gap(10),
              _selectedImage != null
                  ? Container(
                height: 150,
                width: 150,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: Colors.black, 
                    width: 2.0, 
                  ),
                ),
                child: Image.file(
                  _selectedImage!,
                  fit: BoxFit.cover,
                ),
              )
                  : Container(),
              SizedBox(height: 16),

              ElevatedButton(
                onPressed: _getImage,
                style: ElevatedButton.styleFrom(
                  primary: Colors.black, 
                ),
                child: Text('Import Photo',style: TextStyle(color: Colors.white),),
              ),
              SizedBox(height: 16),

            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }
}
