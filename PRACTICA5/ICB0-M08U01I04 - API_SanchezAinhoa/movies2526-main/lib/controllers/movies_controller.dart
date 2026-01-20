import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';

// Controlador que gestiona l'estat de les pel·lícules en tota l'aplicació.
class MoviesController extends GetxController {
  // Estat de càrrega quan s'obtenen les pel·lícules destacades
  var isLoading = false.obs;
  // Pel·lícules millor valorades per mostrar en el carrusel principal de l'app
  var mainTopRatedMovies = <Movie>[].obs;
  // Llista personal de pel·lícules guardades per l'usuari
  var watchListMovies = <Movie>[].obs;

  // Mètode que s'executa quan s'inicialitza el controlador
  // Aquí es carreguen les pel·lícules destacades des de l'API
  @override
  void onInit() async {
    isLoading.value = true;
    //Cridem al endpoint per obtenir les pel·lícules millor valorades
    mainTopRatedMovies.value = (await ApiService.getTopRatedMovies())!;
    isLoading.value = false;
    super.onInit();
  }

  // Comprovem si una pel·lícula ja està a la llista de l'usuari --> Retorna: true si està a watchList/ false en cas contrari
  bool isInWatchList(Movie movie) {
    return watchListMovies.any((m) => m.id == movie.id);
  }

  // Si la pel·lícula ja està a la llista, l'elimina. Si no està, l'afegeix.
  // Mostra una notificació de confirmació a l'usuari sobre l'acció realitzada.
  void addToWatchList(Movie movie) {
    if (watchListMovies.any((m) => m.id == movie.id)) {
      // Si ja existeix, l'elimina
      watchListMovies.removeWhere((m) => m.id == movie.id);
      Get.snackbar('Éxito', 'Eliminada de la lista',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      // Si no existeix, l'afegeix
      watchListMovies.add(movie);
      Get.snackbar('Éxito', 'Añadida a la lista',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}
