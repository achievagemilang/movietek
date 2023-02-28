import 'package:flutter/material.dart';
import 'package:movie_ristek2023/page/splash_screen.dart';
import 'package:movie_ristek2023/pref/movie_preferences.dart';
import 'package:movie_ristek2023/pref/user_preferences.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await UserPreferences.init();
  await MoviePreferences.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MOVIETEK',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
      // home: const MainPage(),
    );
  }
}
