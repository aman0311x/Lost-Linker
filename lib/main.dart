// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lostlinker/login.dart';
import 'package:lostlinker/session_controller.dart';

import 'bottombar.dart';
import 'firebase_options.dart';
import 'fontstyle.dart';
  void main ()async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(
      apiKey: 'AIzaSyB51VQNx_cbvT4-3HLzEyGwYF827kypGmI',
      appId: '1:844153587045:android:569916b750b077e1c54d8c',
      messagingSenderId: '844153587045',
      projectId: 'lostlinker-8b41e',
      authDomain: 'lostlinker-8b41e.firebaseapp.com',
      databaseURL: 'https://lostlinker-8b41e-default-rtdb.asia-southeast1.firebasedatabase.app/',
        storageBucket: 'lostlinker-8b41e.appspot.com'
    ),
  );
  runApp( MyApp());
  SessionController();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Lost Linker',

      theme: ThemeData(
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: '',),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'asset/lostlinker.png',
              width: 500,
              height: 400,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white, backgroundColor: Colors.black,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 35),
                textStyle: TextStyle(fontSize: 18),
              ),
              child: Text('Get Started'),
            ),
          ],
        ),
      ),
    );
  }
}
