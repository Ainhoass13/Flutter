import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/app_menu_controller.dart';

/// Widget del drawer (menú lateral) de navegación principal.
/// Proporciona dos opciones para alternar entre:
/// 1. Películas - Muestra películas populares y destacadas
/// 2. Actores - Muestra actores populares
/// 
/// El drawer contiene un encabezado azul con el icono de película,
/// dos opciones de menú que se resaltan cuando están seleccionadas,
/// y se cierra automáticamente cuando se selecciona una opción.
class AppNavigationDrawer extends StatelessWidget {
  const AppNavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AppMenuController menuController = Get.find<AppMenuController>();

    return Drawer(
      backgroundColor: const Color(0xFF1C1F26),
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Encabezado del drawer con icono y título
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Color(0xff0296E5),
            ),
            child: const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.movie,
                  size: 48,
                  color: Colors.white,
                ),
                SizedBox(height: 12),
                Text(
                  'Películas y Actores',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          // Opción del menú: Películas
          Obx(
            () => ListTile(
              leading: Icon(
                Icons.movie,
                color: menuController.isMoviesSelected()
                    ? const Color(0xff0296E5)
                    : Colors.grey,
              ),
              title: const Text(
                'Películas',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              selected: menuController.isMoviesSelected(),
              selectedTileColor: const Color(0xFF2A2E35),
              onTap: () {
                menuController.selectMovies();
                Navigator.pop(context);
              },
            ),
          ),
          // Opción del menú: Actores
          Obx(
            () => ListTile(
              leading: Icon(
                Icons.person,
                color: menuController.isActorsSelected()
                    ? const Color(0xff0296E5)
                    : Colors.grey,
              ),
              title: const Text(
                'Actores',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              selected: menuController.isActorsSelected(),
              selectedTileColor: const Color(0xFF2A2E35),
              onTap: () {
                menuController.selectActors();
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
