import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/user.dart';

class UserPreferences {
  static late SharedPreferences _preferences;
  static const _keyUser = 'user';

  static const myUser = User(
    imagePath: 'assets/no_picture.jpg',
    name: 'Your Name',
    socialMedia: 'Your Social Media',
    nickname: 'Your Nickname',
    hobby: 'Your Hobby',
    major: 'Your Major',
    bio: 'Your Bio',
  );

  static Future init() async {
    _preferences = await SharedPreferences.getInstance();
    return _preferences;
  }

  static Future setUser(User user) async {
    final json = jsonEncode(user.toJson());

    await _preferences.setString(_keyUser, json);
  }

  static User getUser() {
    final json = _preferences.getString(_keyUser);

    return json == null ? myUser : User.fromJson(jsonDecode(json));
  }
}
