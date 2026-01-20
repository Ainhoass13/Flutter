import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';

/// Pantalla principal de l'aplicació amb navegació inferior entre diferents seccions.
class Main extends StatelessWidget {
  Main({super.key});
  final BottomNavigatorController controller = Get.put(BottomNavigatorController());
  @override
  Widget build(BuildContext context) {
    return Obx(
      () => GestureDetector(
        // Cierra el teclado cuando se toca la pantalla
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
          body: SafeArea(
            // IndexedStack manté totes les pantalles en memòria
            // Només la pantalla amb l'índex actual és visible
            child: IndexedStack(
              index: controller.index.value,
              children: Get.find<BottomNavigatorController>().screens,
            ),
          ),
          // Barra de navegació inferior amb tres opcions de pestanya
          bottomNavigationBar: Container(
            height: 78,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Color(0xFF0296E5),
                  width: 1,
                ),
              ),
            ),
            child: BottomNavigationBar(
              currentIndex: controller.index.value,
              onTap: (index) =>
                  Get.find<BottomNavigatorController>().setIndex(index),
              backgroundColor: const Color(0xFF242A32),
              selectedItemColor: const Color(0xFF0296E5),
              unselectedItemColor: const Color(0xFF67686D),
              selectedFontSize: 12,
              unselectedFontSize: 12,
              items: [
                // Primera pestanya: Inici
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Home.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 0
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Inicio',
                ),
                // Segona pestanya: Buscar
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Search.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 1
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Buscar',
                  tooltip: 'Buscar películas',
                ),
                // Tercera pestanya: La meva llista
                BottomNavigationBarItem(
                  icon: Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    child: SvgPicture.asset(
                      'assets/Save.svg',
                      height: 21,
                      width: 21,
                      // ignore: deprecated_member_use
                      color: controller.index.value == 2
                          ? const Color(0xFF0296E5)
                          : const Color(0xFF67686D),
                    ),
                  ),
                  label: 'Mi lista',
                  tooltip: 'Tu lista',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
