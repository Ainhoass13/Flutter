import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/screens/details_screen.dart';

class ActorsList extends StatelessWidget {
  const ActorsList({super.key});

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
            Obx(() {
              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 0.6,
                ),
                itemCount: controller.popularActors.length,
                itemBuilder: (_, index) {
                  final actor = controller.popularActors[index];
                  return GestureDetector(
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
                            Positioned(
                              top: 8,
                              right: 8,
                              child: Obx(
                                () {
                                  bool isInWatchList =
                                      controller.isActorInWatchList(actor);
                                  return GestureDetector(
                                    onTap: () =>
                                        controller.addActorToWatchList(actor),
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
                            actor.name,
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
            const SizedBox(height: 24),
            Obx(() {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
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
                  if (controller.isLoadingMore.value)
                    const SizedBox(
                      height: 24,
                      width: 24,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation(Color(0xff0296E5)),
                      ),
                    )
                  else
                    IconButton(
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
