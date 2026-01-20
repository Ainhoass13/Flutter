// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:movies/models/movie.dart';

 // Utilitat per obtenir els gèneres de les pel·lícules a partir dels seus IDs
class Utils{
  static String getGenres(Movie movie) {
    // Llista per emmagatzemar els noms dels gèneres
    List<String> genres = [];

    movie.genreIds.forEach((id) {
      [
        {28: 'Action'},
        {12: 'Adventure'},
        {16: 'Animation'},
        {35: 'Comedy'},
        {80: 'Crime'},
        {99: 'Documentary'},
        {18: 'Drama'},
        {10751: 'Family'},
        {14: 'Fantasy'},
        {36: 'History'},
        {27: 'Horror'},
        {10402: 'Music'},
        {9648: 'Mystery'},
        {10749: 'Romance'},
        {878: 'Science Fiction'},
        {10770: 'TV Movie'},
        {53: 'Thriller'},
        {10752: 'War'},
        {37: 'Western'}
      ].forEach((m) {
        m.keys.first == id ? genres.add(m.values.first) : null;
      });
    });
    return genres.isEmpty ? 'N/A' : genres.take(2).join(', '); // Retornem els dos primers gèneres o 'N/A' si no n'hi ha
  }
}