import 'package:flutter/material.dart';
import 'package:movie_ristek2023/model/genre.dart';
import 'package:movie_ristek2023/model/loved_movies.dart';
import 'package:movie_ristek2023/pref/movie_preferences.dart';
import 'package:movie_ristek2023/widget/cast_list.dart';
import 'package:movie_ristek2023/widget/expandable_text.dart';

class MovieDetailPage extends StatefulWidget {
  const MovieDetailPage({super.key, required this.movie});
  final dynamic movie;
  @override
  State<MovieDetailPage> createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  late LovedMovies lovedMovie;

  @override
  void initState() {
    super.initState();
    lovedMovie = MoviePreferences.getMovie();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF10002B),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.65,
              child: Stack(
                children: [
                  Positioned(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: ShaderMask(
                        shaderCallback: (rect) {
                          return const LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Color(0xFF10002B), Colors.transparent],
                          ).createShader(
                              Rect.fromLTRB(0, 0, rect.width, rect.height));
                        },
                        blendMode: BlendMode.dstIn,
                        child: Image.network(
                            'http://image.tmdb.org/t/p/w500${widget.movie["poster_path"]}',
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 80,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: InkWell(
                        onTap: () {
                          MoviePreferences.setMovie(lovedMovie);
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 40,
                          color: Color.fromARGB(255, 202, 202, 202),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.86,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width * 0.6,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          widget.movie['title'] ??
                                              widget.movie['name'],
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontFamily: 'Poppins',
                                              fontWeight: FontWeight.bold,
                                              fontSize: 25),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                InkWell(
                                  splashColor: const Color(0xFF9D4EDD),
                                  onTap: () {
                                    if (lovedMovie.details[
                                            widget.movie['id'].toString()] ==
                                        null) {
                                      Map<String, dynamic> details2 =
                                          Map.from(lovedMovie.details);
                                      details2[widget.movie['id'].toString()] =
                                          true;

                                      setState(() {
                                        lovedMovie = lovedMovie.copy(
                                          details: details2,
                                        );
                                      });
                                    } else {
                                      Map<String, dynamic> details2 =
                                          Map.from(lovedMovie.details);
                                      details2[widget.movie['id'].toString()] =
                                          !details2[
                                              widget.movie['id'].toString()];

                                      setState(() {
                                        lovedMovie = lovedMovie.copy(
                                          details: details2,
                                        );
                                      });
                                    }
                                  },
                                  child: Icon(
                                    lovedMovie.details[widget.movie['id']
                                                .toString()] ==
                                            true
                                        ? Icons.favorite
                                        : Icons.favorite_border,
                                    size: 40,
                                    color: lovedMovie.details[widget.movie['id']
                                                .toString()] ==
                                            true
                                        ? const Color(0xFF9D4EDD)
                                        : Colors.white,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.86,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    getGenre(widget.movie),
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 123, 123, 123),
                                      fontSize: 12,
                                      fontFamily: 'Poppins',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.86,
              child: ExpandableText(
                text: widget.movie['overview'],
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.86,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cast',
                    style: TextStyle(
                        color: Colors.white,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  CastList(movieId: widget.movie['id']),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getGenre(movie) {
    String hasil = "";
    try {
      String string = movie['genre_ids'].toString();
      string = string.substring(1, (string.length - 1));
      List<String> genreIds = string.split(',');

      for (String s in genreIds) {
        hasil += (Genre.details[int.parse(s)]! + ", ");
      }
      hasil = hasil.substring(0, hasil.length - 2);
    } catch (e) {
      List<dynamic> listGenres = movie['genres'];
      for (int i = 0; i < listGenres.length; i++) {
        hasil += (listGenres[i]['name'] + ", ");
      }

      hasil = hasil.substring(0, hasil.length - 2);
    }

    return hasil;
  }
}
