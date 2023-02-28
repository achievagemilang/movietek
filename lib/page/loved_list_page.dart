import 'package:flutter/material.dart';
import 'package:movie_ristek2023/model/loved_movies.dart';
import 'package:movie_ristek2023/page/movie_detail_page.dart';
import 'package:movie_ristek2023/pref/movie_preferences.dart';
import 'package:tmdb_api/tmdb_api.dart';

class LovedListPage extends StatefulWidget {
  const LovedListPage({super.key});

  @override
  State<LovedListPage> createState() => _LovedListPageState();
}

class _LovedListPageState extends State<LovedListPage> {
  static const String apiKey = '0c77e643d7a8531c591586df53258ca3';
  static const String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYzc3ZTY0M2Q3YTg1MzFjNTkxNTg2ZGY1MzI1OGNhMyIsInN1YiI6IjYzZWU2MzIzMWYzZTYwMDBjMDMzYjBkNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Qvot9Nf-IsjcxlET-ZQ3QkTRvNASUTMg7HNXXd4ZrhQ';

  late LovedMovies lovedMovie;
  List<Map<dynamic, dynamic>> listMovies = [];

  @override
  void initState() {
    super.initState();
    lovedMovie = MoviePreferences.getMovie();

    getLovedMovies();
  }

  getLovedMovies() async {
    TMDB tmdb = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    List<Map<dynamic, dynamic>> movies = [];

    for (var k in lovedMovie.details.keys) {
      Map<dynamic, dynamic> movie;

      if (lovedMovie.details[k] == true) {
        try {
          movie = await tmdb.v3.movies.getDetails(int.parse(k));
        } catch (e) {
          movie = await tmdb.v3.tv.getDetails(int.parse(k));
        }
        movies.add(movie);
      }
    }

    setState(() {
      listMovies = movies;
    });
  }

  @override
  Widget build(BuildContext context) {
    ListTile makeListTile(movie) => ListTile(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
            padding: const EdgeInsets.only(right: 12.0),
            decoration: const BoxDecoration(
                border: Border(
                    right: BorderSide(width: 1.0, color: Colors.white24))),
            child: const Icon(Icons.movie, color: Colors.white),
          ),
          title: Text(
            movie['title'] ?? movie['name'],
            style: const TextStyle(
              color: Colors.white,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right,
              color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailPage(movie: movie)));
          },
        );

    Padding makeCard(movie) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 2.0),
          child: Card(
            elevation: 8.0,
            margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 50, 10, 83),
                    Color.fromARGB(255, 90, 42, 130),
                    Color.fromARGB(255, 105, 60, 142),
                    Color.fromARGB(255, 90, 42, 130),
                    Color.fromARGB(255, 50, 10, 83),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: makeListTile(movie),
            ),
          ),
        );

    final makeBody = ListView.builder(
      scrollDirection: Axis.vertical,
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
      itemCount: listMovies.length,
      itemBuilder: (BuildContext context, int index) {
        return makeCard(listMovies[index]);
      },
    );

    final topAppBar = AppBar(
      elevation: 0.1,
      backgroundColor: const Color.fromARGB(255, 18, 2, 47),
      iconTheme: const IconThemeData(color: Color(0xFF9D4EDD)),
      title: const Center(
          child: Text(
        'Loved List Page',
        style: TextStyle(
          fontFamily: 'Poppins',
          color: Color(0xFF9D4EDD),
          fontWeight: FontWeight.bold,
        ),
      )),
      actions: <Widget>[
        IconButton(
          icon: const Icon(
            Icons.refresh_sharp,
            color: Color(0xFF9D4EDD),
          ),
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const LovedListPage()));
          },
        )
      ],
    );

    return Scaffold(
      appBar: topAppBar,
      backgroundColor: const Color(0xFF10002B),
      body: makeBody,
    );
  }
}
