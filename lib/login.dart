import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:lostlinker/bottombar.dart';
import 'package:lostlinker/fontstyle.dart';
import 'package:lostlinker/signup.dart';
import 'package:lostlinker/session_controller.dart';
import 'package:lostlinker/profile.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  dynamic userId = ''; // User ID field

  Future<void> _login() async {
    try {
      setState(() {
        isLoading = true;
      });

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );

      // Successfully logged in
      print('User logged in: ${userCredential.user!.uid}');

      // Set the user ID directly in the widget
      setState(() {
        userId = _emailController.text;
      });


      SessionController().setUserId(userId.replaceAll('.', '_'));

      // Navigate to HomePage on successful login
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => BottomBar(),
        ),
      );

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      // Handle login errors
      print('Error during login: $e');
      // Show an error message to the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed. Please check your credentials.'),
        ),
      );

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login', style: Styles.headLineStyle1),
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  'asset/lostlinker.png',
                  height: 250,
                ),
                SizedBox(height: 10),

                // Email TextField
                TextFormField(
                  controller: _emailController,
                  validator: (text) {
                    if (text == null || text.isEmpty) {
                      return 'Email is empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 12),

                // Password TextField
                TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _login();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text('Login'),
                ),
                SizedBox(height: 20),

                // Display User ID
                // Text('User ID: $userId', style: TextStyle(fontSize: 18)),

                // Profile Button


                // Signup Button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignUpPage()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.black,
                    padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
                    textStyle: TextStyle(fontSize: 18),
                  ),
                  child: Text('Signup'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}