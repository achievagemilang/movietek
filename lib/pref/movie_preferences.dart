import 'dart:convert';
import 'package:movie_ristek2023/model/loved_movies.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MoviePreferences {
  static late SharedPreferences _preferences;
  static const _keyMovie = 'movie';

  static const lovedMovie = LovedMovies(
    details: {},
  );

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future setMovie(LovedMovies movie) async {
    final json = jsonEncode(movie.toJson());

    await _preferences.setString(_keyMovie, json);
  }

  static LovedMovies getMovie() {
    final json = _preferences.getString(_keyMovie);

    return json == null ? lovedMovie : LovedMovies.fromJson(jsonDecode(json));
  }
}
