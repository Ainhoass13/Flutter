import 'package:get/get.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/actor.dart';

// Controlador que gestiona l'estat dels actors a l'aplicació.
class ActorsController extends GetxController {
  // Llista d'actors populars a la pàgina actual
  var popularActors = <Actor>[].obs;
  // Llista d'actors guardats per l'usuari
  var watchListActors = <Actor>[].obs;
  // Pàgina actual --> paginació d'actors
  var currentPage = 1.obs;
  // Estat de càrrega quan s'estan obtenint més actors
  var isLoadingMore = false.obs;

  /// Mètode que s'executa quan s'inicialitza el controlador.
  /// Carrega la primera pàgina d'actors populars des de l'API.
  @override
  void onInit() async {
    var actors = await ApiService.getPopularActorsByPage(1);
    if (actors != null) popularActors.value = actors;
    super.onInit();
  }

  //Carreguem la següent pàgina d'actors populars --> incrementem currentPage i obtenim nous actors
  Future<void> loadNextPage() async {
    isLoadingMore.value = true;
    currentPage.value++;
    // Obtiene los actores de la página siguiente
    var actors = await ApiService.getPopularActorsByPage(currentPage.value);
    if (actors != null) {
      popularActors.value = actors;
      popularActors.refresh(); // Fuerza actualización de observables
    }
    isLoadingMore.value = false;
  }

  // Carreguem la pàgina anterior d'actors populars --> decrementem currentPage i obtenim nous actors 
  // No permet anar a una pàgina menor que 1.
  Future<void> loadPreviousPage() async {
    if (currentPage.value <= 1) return; // No permet pàgina 0 o negativa
    isLoadingMore.value = true;
    currentPage.value--;
    // Obtenim els actors de la pàgina anterior
    var actors = await ApiService.getPopularActorsByPage(currentPage.value);
    if (actors != null) {
      popularActors.value = actors;
      popularActors.refresh(); // Força actualització d'observables
    }
    isLoadingMore.value = false;
  }

  // Comprova si un actor ja està a la llista personal de l'usuari
  // Retorna --> true si l'actor està a watchList/ false en cas contrari
  bool isActorInWatchList(Actor actor) {
    return watchListActors.any((a) => a.id == actor.id);
  }

  // Afegeix o elimina un actor de la llista personal de l'usuari
  // Quan l'usuari clica sobre el boto de watchList --> si l'actor ja està l'elimina. Si no està, l'afegeix.
  // Mostra una notificació de confirmació a l'usuari sobre l'acció realitzada.
  void addActorToWatchList(Actor actor) {
    if (watchListActors.any((a) => a.id == actor.id)) {
      // Si ya existe, lo elimina
      watchListActors.removeWhere((a) => a.id == actor.id);
      Get.snackbar('Éxito', 'Actor eliminado de la lista',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    } else {
      // Si no existe, lo añade
      watchListActors.add(actor);
      Get.snackbar('Éxito', 'Actor añadido a la lista',
          snackPosition: SnackPosition.BOTTOM,
          animationDuration: const Duration(milliseconds: 500),
          duration: const Duration(milliseconds: 500));
    }
  }
}
