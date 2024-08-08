import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:lostlinker/session_controller.dart';
import 'package:lostlinker/login.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ref = FirebaseDatabase.instance.reference().child('user');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
             
              _logout();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: StreamBuilder(
          stream: ref.child(SessionController().userId.toString()).onValue,
          builder: (context, AsyncSnapshot snapshot) {
            print('User ID: ${SessionController().userId}');
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              print('Error loading profile data: ${snapshot.error}');
              return Center(
                  child: Text('Error loading profile data. Please try again later.'));
            } else if (snapshot.hasData && snapshot.data!.snapshot.value != null) {
              dynamic data = snapshot.data!.snapshot.value!;
              print('User data from Firebase: $data');

             
              String contactNumber = data['Contact Number'] ?? 'No Contact Number';
              String fullName = data['Full Name'] ?? 'No Full Name';
              String email = data['Email'] ?? 'No Email';

              return Column(
                children: [
                  const Gap(80),
                  CircleAvatar(
                    radius: 50,
                  
                    backgroundImage: AssetImage('asset/person.png'),
                  ),
                  const Gap(20),
                  itemProfile('Name', fullName, Icons.person),
                  const SizedBox(height: 10),
                  itemProfile('Phone', contactNumber, Icons.phone),
                  const SizedBox(height: 10),
                  itemProfile('Email', email, Icons.mail),
                  const SizedBox(height: 20),
                ],
              );
            } else {
              return Center(child: Text('User ID: ${SessionController().userId}'));
            }
          },
        ),
      ),
    );
  }

  Widget itemProfile(String title, String subtitle, IconData iconData) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            color: Colors.black.withOpacity(.2),
            spreadRadius: 2,
            blurRadius: 10,
          )
        ],
      ),
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        leading: Icon(iconData, color: Colors.black), 
        //trailing: Icon(Icons.arrow_forward, color: Colors.grey.shade400),
        tileColor: Colors.white,
      ),
    );
  }
  void _logout() {
   
    SessionController().setUserId(''); 
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
