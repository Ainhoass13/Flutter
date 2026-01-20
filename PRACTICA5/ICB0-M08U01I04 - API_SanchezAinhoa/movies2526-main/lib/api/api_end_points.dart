import 'package:movies/api/api.dart';

// cosntrucció de les URLs finals per les peticions de l'ApiService
// Utilitzarem en tots els mètodes statics per facilitar l'accés sense instanciar --> ApiEndPoints.getTopRatedMovies()
class ApiEndPoints {
  static const products = "products";
  static const popularMovies = "movie/popular";
  static const upcomingMovies = "movie/upcoming";
  static const getGenreList = "genre/movie/list";
  static const popularPersons = "person";

  // Top Rated movies
  static String getTopRatedMovies() =>
      '${Api.baseUrl}movie/top_rated?api_key=${Api.apiKey}&language=es-ES&page=1';

  // Endpoint flexible: rep la ruta d'allò que es vol veure (popular, upcoming, etc.)
  static String getCustomMovies(String endpoint) =>
      '$endpoint?api_key=${Api.apiKey}&language=es-ES&page=1';

  // Actors populars --> comença a la pàgina 1 per defecte
  static String getPopularActors() =>
      '${Api.baseUrl}person/popular?api_key=${Api.apiKey}&language=es-ES&page=1';

  // Reviews d'una pel·lícula concreta
  static String getMovieReviews(int movieId) =>
      'https://api.themoviedb.org/3/movie/$movieId/reviews?api_key=${Api.apiKey}&language=es-ES&page=1';

  // Detalls d'una peli
  static String getMovieDetails(int movieId) =>
      '${Api.baseUrl}movie/$movieId?api_key=${Api.apiKey}&language=es-ES';

  // Detalls d'un actor
  static String getActorDetails(int actorId) =>
      '${Api.baseUrl}person/$actorId?api_key=${Api.apiKey}&language=es-ES';

  // Cerca de pel·lícules
  static String getSearchMovies(String query) =>
      '${Api.baseUrl}search/movie?api_key=${Api.apiKey}&language=es-ES&query=$query&page=1&include_adult=false';

  // Cerca de persones/actors
  static String getSearchPeople(String query) =>
      '${Api.baseUrl}search/person?api_key=${Api.apiKey}&language=es-ES&query=$query&page=1&include_adult=false';
}
