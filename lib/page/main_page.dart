import 'dart:io';

import 'package:flutter/material.dart';
import 'package:movie_ristek2023/page/profile_page.dart';
import 'package:movie_ristek2023/widget/movie_list.dart';
import 'package:movie_ristek2023/widget/now_playing_list.dart';
import 'package:tmdb_api/tmdb_api.dart';
import 'loved_list_page.dart';

import 'package:movie_ristek2023/model/user.dart';
import 'package:movie_ristek2023/pref/user_preferences.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<dynamic> trendingMovies = [];
  List<dynamic> upcomingMovies = [];
  List<dynamic> nowPlayingMovies = [];
  static const String apiKey = '0c77e643d7a8531c591586df53258ca3';
  static const String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYzc3ZTY0M2Q3YTg1MzFjNTkxNTg2ZGY1MzI1OGNhMyIsInN1YiI6IjYzZWU2MzIzMWYzZTYwMDBjMDMzYjBkNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Qvot9Nf-IsjcxlET-ZQ3QkTRvNASUTMg7HNXXd4ZrhQ';
  late User user;

  @override
  void initState() {
    loadMovies();
    super.initState();
    user = UserPreferences.getUser();
  }

  void loadMovies() async {
    TMDB tmdb = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    Map<dynamic, dynamic> trendingResult = await tmdb.v3.trending.getTrending();
    Map<dynamic, dynamic> upcomingResult = await tmdb.v3.movies.getUpcoming();
    Map<dynamic, dynamic> nowPlayingResult =
        await tmdb.v3.movies.getNowPlaying();

    setState(() {
      trendingMovies = trendingResult['results'];
      upcomingMovies = upcomingResult['results'];
      nowPlayingMovies = nowPlayingResult['results'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10002B),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ProfilePage(),
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 21,
                            backgroundColor: const Color(0xFF9D4EDD),
                            child: CircleAvatar(
                              radius: 20,
                              backgroundImage: (user.imagePath
                                      .contains('assets/'))
                                  ? AssetImage(user.imagePath) as ImageProvider
                                  : FileImage(File(user.imagePath)),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name,
                              style: const TextStyle(
                                  color: Color(0xFF9D4EDD),
                                  fontFamily: 'Poppins',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16),
                            ),
                            Text(
                              user.major,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 186, 186, 186),
                                fontSize: 12,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
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
                  ],
                ),
                const SizedBox(height: 35),
                const Text(
                  'Now Playing',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF9D4EDD),
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 15),
                NowPlayingList(nowPlayingList: nowPlayingMovies),
                const SizedBox(height: 15),
                const Text(
                  'Trending',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF9D4EDD),
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 15),
                MovieList(movieList: trendingMovies),
                const SizedBox(height: 5),
                const Text(
                  'Upcoming',
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    color: Color(0xFF9D4EDD),
                    fontWeight: FontWeight.bold,
                    fontSize: 19,
                  ),
                ),
                const SizedBox(height: 15),
                MovieList(movieList: upcomingMovies),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
