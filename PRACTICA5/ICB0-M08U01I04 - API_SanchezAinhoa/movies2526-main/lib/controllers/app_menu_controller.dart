import 'package:get/get.dart';

//Controlador que gestiona la selecció del menú principal de l'aplicació
// Aquest controlador és observat pel drawer i la pantalla principal per actualitzar la interfície
class AppMenuController extends GetxController {
  // Menú seleccionat actualment: 'actors' o 'movies'
  var selectedMenu = 'actors'.obs; // Per defecte mostrem els actors

  //Selecciona el menú d'actors --> Actualitza la interfície per mostrar contingut relacionat amb actors
  void selectActors() {
    selectedMenu.value = 'actors';
  }

  // Selecciona el menú de pel·lícules --> Actualitza la interfície per mostrar contingut relacionat amb pel·lícules
  void selectMovies() {
    selectedMenu.value = 'movies';
  }

  // Comprova si actualment està seleccionat el menú d'actors.
  // Retorna --> true si selectedMenu és 'actors'/false en cas contrari
  bool isActorsSelected() => selectedMenu.value == 'actors';
  
  // Comprova si actualment està seleccionat el menú de pel·lícules.
  // Retorna --> true si selectedMenu és 'movies'/false en cas contrari
  bool isMoviesSelected() => selectedMenu.value == 'movies';
}

