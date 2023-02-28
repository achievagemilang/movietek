import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_ristek2023/model/user.dart';
import 'package:movie_ristek2023/page/loved_list_page.dart';
import 'package:movie_ristek2023/pref/user_preferences.dart';
import 'package:movie_ristek2023/widget/textfield_widget.dart';

import 'package:path_provider/path_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late User user;

  @override
  void initState() {
    super.initState();
    user = UserPreferences.getUser();
  }

  @override
  Widget build(BuildContext context) {
    Widget buildEditProfile() => InkWell(
          child: const Text(
            "Save Profile",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'Poppins',
              color: Color(0xFF9D4EDD),
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          onTap: () {
            UserPreferences.setUser(user);
            Navigator.of(context).pop();
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
          'Edit Profile',
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
                  InkWell(
                    onTap: () async {
                      final image = await ImagePicker()
                          .pickImage(source: ImageSource.gallery);

                      if (image == null) return;
                      final directory =
                          await getApplicationDocumentsDirectory();
                      final name = basename(image.path);
                      final imageFile = File('${directory.path}/$name');
                      final newImage =
                          await File(image.path).copy(imageFile.path);

                      setState(
                        () => user = user.copy(imagePath: newImage.path),
                      );
                    },
                    child: CircleAvatar(
                      radius: 82,
                      backgroundColor: const Color(0xFF9D4EDD),
                      child: Stack(
                        children: [
                          Positioned(
                            child: CircleAvatar(
                              radius: 80,
                              backgroundImage: (user.imagePath
                                      .contains('assets/'))
                                  ? AssetImage(user.imagePath) as ImageProvider
                                  : FileImage(File(user.imagePath)),
                            ),
                          ),
                          Positioned(
                            bottom: 0.0,
                            right: 0.0,
                            child: ClipOval(
                              child: Container(
                                padding: const EdgeInsets.all(1.0),
                                color: const Color(0xFF9D4EDD),
                                child: ClipOval(
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    color: const Color(0xFF10002B),
                                    child: const Icon(
                                      Icons.change_circle_sharp,
                                      size: 25.0,
                                      color: Color.fromARGB(255, 194, 137, 241),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Nama',
                text: user.name,
                onChanged: (value) => user = user.copy(name: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Jurusan',
                text: user.major,
                onChanged: (value) => user = user.copy(major: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Panggilan',
                text: user.nickname,
                onChanged: (value) => user = user.copy(nickname: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Hobi',
                text: user.hobby,
                onChanged: (value) => user = user.copy(hobby: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Instagram',
                text: user.socialMedia,
                onChanged: (value) => user = user.copy(socialMedia: value),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFieldWidget(
                label: 'Tentang',
                maxLines: 4,
                text: user.bio,
                onChanged: (value) => user = user.copy(bio: value),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Align(
                    alignment: Alignment.bottomCenter,
                    child: buildEditProfile()),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}
