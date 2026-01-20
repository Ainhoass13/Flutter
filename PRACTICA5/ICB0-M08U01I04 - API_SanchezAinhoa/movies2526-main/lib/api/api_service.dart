import 'dart:convert';
import 'package:movies/api/api.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/actor.dart';
import 'package:http/http.dart' as http;
import 'package:movies/models/review.dart';

class ApiService {

  // Top Rated: carreguem 5 pelicules pel carrusel principal --> Ens saltem les 6 primeres perque sigunin diferents a les de populars
  static Future<List<Movie>?> getTopRatedMovies() async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=es-ES&page=1'));
      var res = jsonDecode(response.body);

      //convertim cada element del array en un objecte Movie
      res['results'].skip(6).take(5).forEach(
            (m) => movies.add(Movie.fromMap(m)),
          );

      return movies;
    } catch (e) {
      return null;
    }
  }

  // Mètode flexible per demanar qualsevol llista de pelis (popular, properament, etc.)
  //Rep endpoint --> genera la petició corresponent
  static Future<List<Movie>?> getCustomMovies(String url) async {
    List<Movie> movies = [];
    try {
      http.Response response =
          await http.get(Uri.parse('${Api.baseUrl}movie/$url'));
      var res = jsonDecode(response.body);
      res['results'].take(6).forEach((m) => movies.add(Movie.fromMap(m)));
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Cerca de pelis --> depenent del text introduit en el buscador
  static Future<List<Movie>?> getSearchedMovies(String query) async {
    List<Movie> movies = [];
    try {
      http.Response response = await http.get(Uri.parse(
          '${Api.baseUrl}search/movie?api_key=${Api.apiKey}&language=es-ES&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      res['results'].forEach((m) => movies.add(Movie.fromMap(m)));
      return movies;
    } catch (e) {
      return null;
    }
  }

  // Cerca d'actors --> depenent del text introduit en el buscador
  static Future<List<Actor>?> getSearchedPeople(String query) async {
    List<Actor> people = [];
    try {
      final response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/search/person?api_key=${Api.apiKey}&language=es&query=$query&page=1&include_adult=false'));
      var res = jsonDecode(response.body);
      (res['results'] as List).forEach((p) => people.add(Actor.fromMap(p)));
      return people;
    } catch (e) {
      return null;
    }
  }

  //carreguem les ressenyes d'una pel·lícula concreta
  static Future<List<Review>?> getMovieReviews(int movieId) async {
    List<Review> reviews = [];
    try {
      http.Response response = await http.get(Uri.parse(
          'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=es-ES&page=1'));
      var res = jsonDecode(response.body);
      //convertim cada element del array en un objecte Review
      res['results'].forEach((r) {
        reviews.add(
          Review(
            author: r['author'],
            comment: r['content'],
            rating: r['author_details']['rating'],
          ),
        );
      });
      return reviews;
    } catch (e) {
      return null;
    }
  }

  //Tots els detalls d'una pel·lícula concreta
  static Future<Movie?> getMovieDetails(int movieId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId?api_key=${Api.apiKey}&language=es'));
      var res = jsonDecode(response.body);

      //Utilitzem el fromDetailsMap per agafar més camps que amb fromMap
      return Movie.fromDetailsMap(res);
    } catch (e) {
      return null;
    }
  }

  // Mètode amb el que obtenim els actors d'una pel·lícula concreta
  static Future<List<dynamic>?> getMovieCredits(int movieId) async {
    try {
      //URL per obtenir el cast d'una peli --> aqui directament ja que és molt específica i no l'utilitzem en cap altre lloc
      final response = await http.get(Uri.parse(
          '${Api.baseUrl}movie/$movieId/credits?api_key=${Api.apiKey}&language=es'));
      var res = jsonDecode(response.body);
      return res['cast'] ?? []; // Retornem la llista de cast
    } catch (e) {
      return null;
    }
  }

  // Carreguem els actors populars --> comencem a la pàgina 1 per defecte
  static Future<List<Actor>?> getPopularActors() async {
    List<Actor> actors = [];
    try {
      final response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=es&page=1'));
      var res = jsonDecode(response.body);
      //Convertim cada element del array en un objecte Actor
      (res['results'] as List).forEach((p) => actors.add(Actor.fromMap(p)));
      return actors;
    } catch (e) {
      return null;
    }
  }

  // Paginació d'actors populars --> passem la pàgina que volem carregar
  static Future<List<Actor>?> getPopularActorsByPage(int page) async {
    List<Actor> actors = [];
    try {
      final response = await http.get(Uri.parse(
          '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=es&page=$page'));
      var res = jsonDecode(response.body);
      (res['results'] as List).forEach((p) => actors.add(Actor.fromMap(p)));
      return actors;
    } catch (e) {
      return null;
    }
  }

  // Detalls d'un actor
  static Future<Actor?> getActorDetails(int actorId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$actorId?api_key=${Api.apiKey}&language=es'));
      var res = jsonDecode(response.body);
      return Actor.fromDetailsMap(res);
    } catch (e) {
      return null;
    }
  }

  // Crèdits d'un actor (peli i sèries on ha participat)
  static Future<List<dynamic>?> getActorCredits(int actorId) async {
    try {
      final response = await http.get(Uri.parse(
          '${Api.baseUrl}person/$actorId/combined_credits?api_key=${Api.apiKey}&language=es'));
      var res = jsonDecode(response.body);
      return res['cast'] ?? res['crew'] ?? [];
    } catch (e) {
      return null;
    }
  }
}
