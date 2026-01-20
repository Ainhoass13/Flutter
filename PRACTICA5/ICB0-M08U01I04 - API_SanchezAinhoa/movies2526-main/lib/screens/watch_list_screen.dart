import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/bottom_navigator_controller.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/infos.dart';

//Las películas y actores se pueden ver en detalle y eliminar de la lista.  
class WatchList extends StatelessWidget {
  const WatchList({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => SingleChildScrollView( 
          child: Padding(
            padding: const EdgeInsets.all(34.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Volver al inicio',
                      onPressed: () =>
                          Get.find<BottomNavigatorController>().setIndex(0),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Mi lista',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    const SizedBox(
                      width: 33,
                      height: 33,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                // Secció de pel·lícules
                if (Get.find<MoviesController>().watchListMovies.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Películas',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ...Get.find<MoviesController>().watchListMovies.map( 
                        (movie) => Column(
                          children: [
                            GestureDetector(
                              onTap: () => Get.to(DetailsScreen(movie: movie)), // Permet obrir la pantalla de detalls de la pel·lícula --> ho hem afegit només en aquesta secció
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: Image.network(
                                      Api.imageBaseUrl + movie.posterPath,
                                      height: 180,
                                      width: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, __, ___) => Container(
                                        height: 180,
                                        width: 100,
                                        decoration: BoxDecoration(
                                          color: const Color(0xff0296E5),
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: const Center(
                                          child: Icon(
                                            Icons.movie,
                                            size: 60,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      loadingBuilder: (_, __, ___) {
                                        // ignore: no_wildcard_variable_uses
                                        if (___ == null) return __;
                                        return const FadeShimmer(
                                          width: 150,
                                          height: 150,
                                          highlightColor: Color(0xff22272f),
                                          baseColor: Color(0xff20252d),
                                        );
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Infos(movie: movie)
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                  const SizedBox(height: 30),
                ],
                // Sección de actores
                if (Get.find<ActorsController>().watchListActors.isNotEmpty) ...[
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Actores',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  ...Get.find<ActorsController>().watchListActors.map(
                        (actor) => Column(
                          children: [
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(16),
                                  child: Image.network(
                                    Api.imageBaseUrl + actor.profilePath,
                                    height: 120,
                                    width: 80,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => Container(
                                      height: 120,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: const Color(0xff0296E5),
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.person,
                                          size: 45,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                    loadingBuilder: (_, __, ___) {
                                      if (___ == null) return __;
                                      return const FadeShimmer(
                                        width: 80,
                                        height: 120,
                                        highlightColor: Color(0xff22272f),
                                        baseColor: Color(0xff20252d),
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(width: 15),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        actor.name,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 16,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        'Popularidad: ${actor.popularity.toStringAsFixed(1)}',
                                        style: const TextStyle(
                                          fontSize: 12,
                                          color: Colors.grey,
                                        ),
                                      ),
                                      if (actor.birthday.isNotEmpty)
                                        Padding(
                                          padding: const EdgeInsets.only(top: 5),
                                          child: Text(
                                            'Nacimiento: ${actor.birthday}',
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                ],
                // Missatge quan no hi ha res a la llista
                if (Get.find<MoviesController>().watchListMovies.isEmpty &&
                    Get.find<ActorsController>().watchListActors.isEmpty)
                  const Column(
                    children: [
                      SizedBox(
                        height: 200,
                      ),
                      Text(
                        'No hay películas ni actores en tu lista',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w200,
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ));
  }
}
