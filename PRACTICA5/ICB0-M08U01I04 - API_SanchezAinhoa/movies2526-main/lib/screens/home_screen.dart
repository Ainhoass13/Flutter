import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/search_controller.dart';
import 'package:movies/controllers/app_menu_controller.dart';
import 'package:movies/widgets/actors_list.dart';
import 'package:movies/screens/movies_home_view.dart';
import 'package:movies/widgets/app_navigation_drawer.dart';

//Pantalla principal que alterna entre --> pel·lícules i actors segons la selecció del menú
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  // Controladors per gestionar l'estat de pel·lícules, cerca i menú
  final MoviesController movieController = Get.put(MoviesController());
  final SearchController1 searchController = Get.put(SearchController1());
  final AppMenuController menuController = Get.put(AppMenuController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar amb títol dinàmic basat en la selecció del menú
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1F26),
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0xFF0296E5),
        ),
        // Títol que canvia entre "Actores" i "Pel·lícules"
        title: Obx(
          () => Text(
            menuController.isActorsSelected() ? 'Actores' : 'Películas',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        centerTitle: false,
      ),
      // Opcions --> permeten seleccionar entre pel·lícules i actors
      drawer: const AppNavigationDrawer(),
      //Escolta --> mostrar ActorsList o MoviesHomeView segons la selecció
      body: Obx(
        () {
          if (menuController.isActorsSelected()) {
            return const ActorsList(); // Vista d'actors
          } else {
            return const MoviesHomeView(); // Vista de pel·lícules
          }
        },
      ),
    );
  }
}
