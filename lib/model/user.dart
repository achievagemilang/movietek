class User {
  final String imagePath;
  final String name;
  final String socialMedia;
  final String nickname;
  final String hobby;
  final String major;
  final String bio;

  const User({
    required this.imagePath,
    required this.name,
    required this.socialMedia,
    required this.hobby,
    required this.nickname,
    required this.major,
    required this.bio,
  });

  User copy({
    String? imagePath,
    String? name,
    String? socialMedia,
    String? nickname,
    String? hobby,
    String? major,
    String? bio,
  }) =>
      User(
        imagePath: imagePath ?? this.imagePath,
        name: name ?? this.name,
        socialMedia: socialMedia ?? this.socialMedia,
        nickname: nickname ?? this.nickname,
        hobby: hobby ?? this.hobby,
        bio: bio ?? this.bio,
        major: major ?? this.major,
      );

  static User fromJson(Map<String, dynamic> json) => User(
        imagePath: json['imagePath'],
        name: json['name'],
        socialMedia: json['socialMedia'],
        nickname: json['nickname'],
        hobby: json['hobby'],
        major: json['major'],
        bio: json['bio'],
      );

  Map<String, dynamic> toJson() => {
        'imagePath': imagePath,
        'name': name,
        'socialMedia': socialMedia,
        'nickname': nickname,
        'hobby': hobby,
        'major': major,
        'bio': bio,
      };
}
