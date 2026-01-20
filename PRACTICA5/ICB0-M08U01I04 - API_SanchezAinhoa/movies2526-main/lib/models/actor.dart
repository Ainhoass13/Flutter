import 'dart:convert';

// Model bàsic d'un actor
//Camps principals que te l'actor
class Actor {
  int id;
  String name; 
  String profilePath; 
  String biography;
  String birthday;
  String placeOfBirth;
  List<dynamic> knownFor;
  int gender;
  double popularity;

  //Constructor de l'objecte
  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    this.biography = '',
    this.birthday = '',
    this.placeOfBirth = '',
    this.knownFor = const [],
    this.gender = 0,
    this.popularity = 0.0,
  });

  // Versió resumida de l'objecte
  factory Actor.fromMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      knownFor: map['known_for'] ?? [],
      gender: map['gender'] ?? 0,
      popularity: (map['popularity'] ?? 0.0).toDouble(),
    );
  }

  //Versió completa --> agafem totes les dades de l'actor
  factory Actor.fromDetailsMap(Map<String, dynamic> map) {
    return Actor(
      id: map['id'] as int,
      name: map['name'] ?? '',
      profilePath: map['profile_path'] ?? '',
      biography: map['biography'] ?? '',
      birthday: map['birthday'] ?? '',
      placeOfBirth: map['place_of_birth'] ?? '',
      knownFor: map['known_for'] ?? [],
      gender: map['gender'] ?? 0,
      popularity: (map['popularity'] ?? 0.0).toDouble(),
    );
  }

  factory Actor.fromJson(String source) => Actor.fromMap(json.decode(source));
}
