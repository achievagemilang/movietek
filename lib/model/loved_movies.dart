class LovedMovies {
  final Map<String, dynamic> details;

  const LovedMovies({
    required this.details,
  });

  LovedMovies copy({
    List<dynamic>? lovedMovies,
    Map<String, dynamic>? details,
  }) =>
      LovedMovies(
        details: details ?? this.details,
      );

  static LovedMovies fromJson(Map<String, dynamic> json) {
    return LovedMovies(
      details: json['details'],
    );
  }

  Map<String, dynamic> toJson() => {
        'details': details,
      };
}
