import 'package:fluentui_icons/fluentui_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lostlinker/Archive.dart';
import 'package:lostlinker/create_post_page.dart';
import 'package:lostlinker/profile.dart';

import 'homepage.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _seletedIndex = 0;
  static final List<Widget>_widgetOption =<Widget>[
    HomePage(),
    CreatePostPage(),
    //const Text("Chat"),
    ArchivePage() ,
    ProfilePage(),

  ];
  void onTappedItem(int index){
    setState(() {
      _seletedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Center(
        child: _widgetOption[_seletedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _seletedIndex,
        onTap: onTappedItem,
        elevation: 10,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        unselectedItemColor: const Color(0xFF526480),
        items: const [
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_home_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_home_filled),
              label: "Home"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_add_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_add_filled),
              label: "Add"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_archive_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_archive_filled),
              label: "Chat"),
          BottomNavigationBarItem(icon: Icon(FluentSystemIcons.ic_fluent_person_regular),
              activeIcon: Icon(FluentSystemIcons.ic_fluent_person_filled),
              label: "Profile")
        ],
      ),
    );
  }
}