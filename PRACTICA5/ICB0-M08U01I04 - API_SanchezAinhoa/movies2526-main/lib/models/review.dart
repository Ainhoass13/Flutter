// Mòdel de les ressenyes d'una pel·lícula
class Review {
  String author; 
  String comment;
  double rating;

  //Constructor de l'objecte
  Review({
    required this.author,
    required this.comment,
    required this.rating,
  });

  //Mètode amb el que carreguem les ressenyes --> convertim en un objecte de review
  factory Review.fromJson(Map<String, dynamic> map) {
    return Review(
      author: map['name'] ?? '',
      comment: map['content'] ?? '',
      rating: map['rating']?.toDouble() ?? 0.0,
    );
  }
}

