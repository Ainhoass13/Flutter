import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/screens/details_screen.dart';

// Pantalla que mostra les pel·lícules millor valorades
class TopRatedMoviesView extends StatelessWidget {
  const TopRatedMoviesView({super.key});

  @override
  Widget build(BuildContext context) {
    final MoviesController controller = Get.find<MoviesController>();

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Top Rated Movies',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 24),
            Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: controller.mainTopRatedMovies.length,
                itemBuilder: (_, index) {
                  final movie = controller.mainTopRatedMovies[index];
                  return GestureDetector(
                    onTap: () => Get.to(DetailsScreen(movie: movie)),
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                Api.imageBaseUrl + movie.posterPath,
                                fit: BoxFit.cover,
                                height: 220,
                                width: double.infinity,
                                errorBuilder: (_, __, ___) => Container(
                                  height: 220,
                                  decoration: BoxDecoration(
                                    color: const Color(0xff20252d),
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: const Icon(
                                    Icons.broken_image,
                                    size: 100,
                                  ),
                                ),
                                loadingBuilder: (_, __, ___) {
                                  if (___ == null) return __;
                                  return const FadeShimmer(
                                    width: double.infinity,
                                    height: 220,
                                    highlightColor: Color(0xff22272f),
                                    baseColor: Color(0xff20252d),
                                  );
                                },
                              ),
                            ),
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Obx(
                                () {
                                  bool isInWatchList =
                                      controller.isInWatchList(movie);
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.addToWatchList(movie),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.black54,
                                        shape: BoxShape.circle,
                                      ),
                                      padding: const EdgeInsets.all(8),
                                      child: Icon(
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
                        Flexible(
                          child: Text(
                            movie.title,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
