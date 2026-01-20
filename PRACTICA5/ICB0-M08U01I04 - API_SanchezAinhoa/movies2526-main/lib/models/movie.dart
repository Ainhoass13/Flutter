import 'dart:convert';

// Mòdel bàsic d'una pel·lícula
class Movie {
  int id;
  String title; 
  String posterPath;
  String backdropPath; 
  String overview;
  String releaseDate;
  double voteAverage;
  List<int> genreIds;

  //Consructor de l'objecte
  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.backdropPath,
    required this.overview,
    required this.releaseDate,
    required this.voteAverage,
    required this.genreIds,
  });

  //Mètode amb el que carreguem els llistats de pel·lícules
  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      voteAverage: map['vote_average']?.toDouble() ?? 0.0,
      genreIds: List<int>.from(map['genre_ids']),
    );
  }

  //Mètode amb el que carreguem els detalls d'una pel·lícula concreta --> pagina de detalls
  factory Movie.fromDetailsMap(Map<String, dynamic> map) {
    List<int> genres = [];
    if (map['genres'] != null && map['genres'] is List) {
      genres = (map['genres'] as List)
          .map<int>((g) => (g['id'] ?? 0) as int)
          .toList();
    }

    //retornem l'objecte
    return Movie(
      id: map['id'] as int,
      title: map['title'] ?? '',
      posterPath: map['poster_path'] ?? '',
      backdropPath: map['backdrop_path'] ?? '',
      overview: map['overview'] ?? '',
      releaseDate: map['release_date'] ?? '',
      voteAverage: (map['vote_average'] ?? 0).toDouble(),
      genreIds: genres,
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));
}
