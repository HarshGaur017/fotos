import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:fotos/pages/feed_page.dart';
import 'package:fotos/pages/profile_page.dart';
import 'package:fotos/services/firebase_service.dart';
import 'package:get_it/get_it.dart';

class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  FirebaseService? _firebaseService;
  int _currentPage = 0;
  final List<Widget> _pages = [
    FeedPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    super.initState();
    _firebaseService = GetIt.instance.get<FirebaseService>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text(
          "Fotos",
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          GestureDetector(
            onTap: _postImage,
            child: Icon(
              Icons.add_a_photo,
              color: Colors.white,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 8.0,
              right: 8.0,
            ),
            child: GestureDetector(
              onTap: () async {
                await _firebaseService!.logout();
                Navigator.popAndPushNamed(context, 'login');
              },
              child: Icon(
                Icons.logout,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _bottomNavigationBar(),
      body: _pages[_currentPage],
    );
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _currentPage,
      onTap: (_index) {
        setState(() {
          _currentPage = _index;
        });
      },
      items: const [
        BottomNavigationBarItem(
          label: 'Feed',
          icon: Icon(
            Icons.feed,
          ),
        ),
        BottomNavigationBarItem(
          label: 'Profile',
          icon: Icon(
            Icons.account_box,
          ),
        ),
      ],
    );
  }

  void _postImage() async {
    FilePickerResult? _result =
        await FilePicker.platform.pickFiles(type: FileType.image);
    File _image = File(_result!.files.first.path!);
    await _firebaseService!.postImage(_image);
  }
}
