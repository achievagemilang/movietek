import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tmdb_api/tmdb_api.dart';

class CastList extends StatefulWidget {
  const CastList({super.key, required this.movieId});

  final int movieId;

  @override
  State<CastList> createState() => _CastListState();
}

class _CastListState extends State<CastList> {
  List<dynamic> castList = [];
  static const String apiKey = '0c77e643d7a8531c591586df53258ca3';
  static const String readAccessToken =
      'eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiIwYzc3ZTY0M2Q3YTg1MzFjNTkxNTg2ZGY1MzI1OGNhMyIsInN1YiI6IjYzZWU2MzIzMWYzZTYwMDBjMDMzYjBkNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.Qvot9Nf-IsjcxlET-ZQ3QkTRvNASUTMg7HNXXd4ZrhQ';

  @override
  void initState() {
    loadCast();
    super.initState();
  }

  void loadCast() async {
    TMDB tmdb = TMDB(ApiKeys(apiKey, readAccessToken),
        logConfig: const ConfigLogger(showLogs: true, showErrorLogs: true));
    Map<dynamic, dynamic> castResult;
    try {
      castResult = await tmdb.v3.movies.getCredits(widget.movieId);
    } catch (e) {
      castResult = await tmdb.v3.tv.getCredits(widget.movieId);
    }
    setState(() {
      castList = castResult['cast'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: castList.length,
        itemBuilder: (context, index) {
          return Row(
            children: [
              SizedBox(
                width: 80,
                child: Column(
                  children: [
                    Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: castList[index]['profile_path'] != null
                              ? NetworkImage(
                                  'http://image.tmdb.org/t/p/w500${castList[index]['profile_path']}')
                              : Image.asset('assets/no_picture.jpg').image,
                        ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    SizedBox(
                      width: 100,
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              castList[index]['original_name'],
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 225, 225, 225),
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10)
            ],
          );
        },
      ),
    );
  }
}
