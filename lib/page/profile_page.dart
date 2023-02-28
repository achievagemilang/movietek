import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_ristek2023/model/user.dart';
import 'package:movie_ristek2023/page/loved_list_page.dart';
import 'package:movie_ristek2023/page/main_page.dart';
import 'package:movie_ristek2023/pref/user_preferences.dart';
import 'package:movie_ristek2023/widget/ribbon_heading.dart';
import 'package:movie_ristek2023/widget/ribbon_description.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.getUser();
    Widget buildEditProfile() => InkWell(
          child: const Text(
            "Edit Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF9D4EDD),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProfilePage(),
              ),
            );
            setState(() {});
          },
        );

    return Scaffold(
      backgroundColor: const Color(0xFF10002B),
      appBar: AppBar(
        elevation: 3.0,
        backgroundColor: const Color(0xFF10002B),
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const MainPage(),
              ),
            );
          },
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: Color(0xFF9D4EDD),
            ),
          ),
        ),
        title: const Center(
            child: Text(
          'Profile',
          style: TextStyle(
              color: Color(0xFF9D4EDD),
              fontFamily: 'Poppins',
              fontWeight: FontWeight.w700,
              fontSize: 20),
        )),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
            child: InkWell(
              splashColor: const Color(0xFF9D4EDD),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LovedListPage(),
                  ),
                );
              },
              child: const Icon(
                Icons.list_rounded,
                size: 35,
                color: Color(0xFF9D4EDD),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(height: 5),
                  CircleAvatar(
                    radius: 82,
                    backgroundColor: const Color(0xFF9D4EDD),
                    child: CircleAvatar(
                      radius: 80,
                      backgroundImage: (user.imagePath.contains('assets/'))
                          ? AssetImage(user.imagePath) as ImageProvider
                          : FileImage(File(user.imagePath)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    user.name,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color(0xFF9D4EDD),
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    user.major,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                      color: Color.fromARGB(255, 186, 186, 186),
                      fontSize: 17,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            const RibbonHeading(text: 'Panggilan'),
            RibbonDescription(text: user.nickname),
            const RibbonHeading(text: 'Hobi'),
            RibbonDescription(text: user.hobby),
            const RibbonHeading(text: 'Instagram'),
            RibbonDescription(text: user.socialMedia),
            const RibbonHeading(text: 'Tentang'),
            RibbonDescription(text: user.bio),
            const SizedBox(height: 20),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: buildEditProfile()),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
