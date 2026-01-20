import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/screens/details_screen.dart';

// Vista que mostra els actors més populars amb paginació
class PopularActorsView extends StatelessWidget {
  const PopularActorsView({super.key});

  @override 
  Widget build(BuildContext context) { 
    final ActorsController controller = Get.put(ActorsController()); 

    return SingleChildScrollView( 
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Obx(() { // Obx per actualitzar la UI quan canvia l'estat del controlador --> paginació
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(), // Evita que el GridView tingui el seu propi desplaçament
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( // Defineix la disposició de la graella
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: controller.popularActors.length,
                itemBuilder: (_, index) {
                  final actor = controller.popularActors[index];
                  return GestureDetector( // Permet detectar tocs en cada element de la graella --> si en detecta  --> obre la pantalla de detalls d'aquest actor
                    onTap: () => Get.to(ActorDetailScreen( 
                        actorId: actor.id,
                        initialName: actor.name,
                        initialProfilePath: actor.profilePath)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                Api.imageBaseUrl + actor.profilePath,
                                fit: BoxFit.cover,
                                height: 220,
                                width: double.infinity,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff0296E5),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Center(
                                    child: Icon(
                                      Icons.person,
                                      size: 80,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned( // Icona de cor per afegir a la llista de favorits
                              top: 8,
                              right: 8,
                              child: Obx( // Obx per actualitzar l'estat de l'icona quan es canvia la llista de favorits
                                () {
                                  bool isInWatchList =
                                      controller.isActorInWatchList(actor); // Comprova si l'actor està a la llista de favorits
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.addActorToWatchList(actor), // Afegeix o elimina l'actor de la llista de favorits
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Icon( // Icona de cor plena o buida segons si està a la llista de favorits
                                        isInWatchList
                                            ? Icons.favorite
                                            : Icons.favorite_border,
                                        color: isInWatchList 
                                            ? Colors.red
                                            : Colors.white,
                                        size: 20,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Flexible( // Permet que el text s'ajusti dins del seu contenidor
                          child: Text( 
                            actor.name,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis, // Quan el nom és mmolt llarg --> mostra punts suspensius si el text és massa llarg --> sense això surt un alert de overflow
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            const SizedBox(height: 24),
            Obx(() { // Obx per actualitzar la UI quan canvia la pàgina actual o l'estat de càrrega --> al canviar de pàgina
              return Row( 
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton( // Botó per carregar la pàgina anterior
                    onPressed: controller.currentPage.value <= 1
                        ? null
                        : () => controller.loadPreviousPage(),
                    icon: const Icon(Icons.arrow_back),
                    color: controller.currentPage.value <= 1
                        ? Colors.grey
                        : const Color(0xff0296E5),
                    iconSize: 24,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    'Página ${controller.currentPage.value}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff0296E5),
                    ),
                  ),
                  const SizedBox(width: 16),
                  if (controller.isLoadingMore.value) // Mostra un indicador de càrrega mentre es carreguen més actors
                    const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator( 
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Color(0xff0296E5)),
                      ),
                    )
                  else
                    IconButton( // Botó per carregar la següent pàgina
                      onPressed: () => controller.loadNextPage(),
                      icon: const Icon(Icons.arrow_forward),
                      color: const Color(0xff0296E5),
                      iconSize: 24,
                    ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
