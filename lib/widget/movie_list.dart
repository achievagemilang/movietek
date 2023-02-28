import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_ristek2023/page/movie_detail_page.dart'; // for date format

class MovieList extends StatelessWidget {
  const MovieList({super.key, required this.movieList});

  final List<dynamic> movieList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: movieList.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailPage(movie: movieList[index]),
                ),
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: 140,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                                'http://image.tmdb.org/t/p/w500${movieList[index]['poster_path']}'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: 120,
                        child: Text(
                          movieList[index]['title'] ?? movieList[index]['name'],
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 186, 186, 186),
                            fontSize: 13,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 120,
                        child: Text(
                          movieList[index]['release_date'] != null
                              ? DateFormat.yMMMMd()
                                  .format(DateTime.parse(
                                      movieList[index]['release_date']))
                                  .toString()
                              : DateFormat.yMMMMd()
                                  .format(DateTime.parse(
                                      movieList[index]['first_air_date']))
                                  .toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            overflow: TextOverflow.ellipsis,
                            color: Color.fromARGB(255, 186, 186, 186),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 10)
              ],
            ),
          );
        },
      ),
    );
  }
}
