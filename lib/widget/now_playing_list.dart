import 'package:flutter/material.dart';
import 'package:movie_ristek2023/model/genre.dart';
import 'package:movie_ristek2023/page/movie_detail_page.dart';

class NowPlayingList extends StatelessWidget {
  const NowPlayingList({super.key, required this.nowPlayingList});

  final List<dynamic> nowPlayingList;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 260,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: nowPlayingList.isEmpty ? nowPlayingList.length : 3,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      MovieDetailPage(movie: nowPlayingList[index]),
                ),
              );
            },
            child: Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(
                                    'http://image.tmdb.org/t/p/w500${nowPlayingList[index]['poster_path']}'))),
                      ),
                      const SizedBox(height: 5),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Text(
                          nowPlayingList[index]['title'] ??
                              nowPlayingList[index]['name'],
                          style: const TextStyle(
                            color: Color.fromARGB(255, 186, 186, 186),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Poppins',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Text(
                          getGenre(
                              nowPlayingList[index]['genre_ids'].toString()),
                          style: const TextStyle(
                            color: Color.fromARGB(255, 186, 186, 186),
                            fontSize: 13,
                            fontFamily: 'Poppins',
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(width: 20)
              ],
            ),
          );
        },
      ),
    );
  }

  String getGenre(String string) {
    string = string.substring(1, (string.length - 1));
    List<String> genreIds = string.split(',');
    String hasil = "";

    for (String s in genreIds) {
      hasil += (Genre.details[int.parse(s)]! + ", ");
    }
    hasil = hasil.substring(0, hasil.length - 2);
    return hasil;
  }
}
