import 'dart:async';

import 'package:flutter/material.dart';

import 'main_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 5), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) {
            return const MainPage();
          },
        ),
      );
    });

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/ic_launcher.png",
              width: MediaQuery.of(context).size.width * 0.75,
            ),
            const SizedBox(height: 20),
            const Text(
              'Powered By:',
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Color(0xFF9D4EDD),
                fontSize: 17,
              ),
            ),
            const SizedBox(height: 15),
            Image.asset(
              "assets/tmdb.png",
              width: MediaQuery.of(context).size.width * 0.20,
            ),
          ],
        ),
      ),
      backgroundColor: const Color(0x00000000),
    );
  }
}
