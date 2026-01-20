import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/controllers/movies_controller.dart';
import 'package:movies/controllers/actors_controller.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/models/actor.dart';
import 'package:movies/models/review.dart';
import 'package:movies/utils/utils.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({
    super.key,
    required this.movie,
  });
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    ApiService.getMovieReviews(movie.id);
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 24, right: 24, top: 34),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    IconButton(
                      tooltip: 'Volver al inicio',
                      onPressed: () => Get.back(),
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                    const Text(
                      'Detalles',
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 24,
                      ),
                    ),
                    Tooltip(
                      message: 'Guardar esta película en tu lista',
                      triggerMode: TooltipTriggerMode.tap,
                      child: IconButton(
                        onPressed: () {
                          Get.find<MoviesController>().addToWatchList(movie);
                        },
                        icon: Obx(
                          () =>
                              Get.find<MoviesController>().isInWatchList(movie)
                                  ? const Icon(
                                      Icons.favorite,
                                      color: Colors.red,
                                      size: 28,
                                    )
                                  : const Icon(
                                      Icons.favorite_border,
                                      color: Colors.white,
                                      size: 28,
                                    ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 330,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(16),
                        bottomRight: Radius.circular(16),
                      ),
                      child: Image.network(
                        Api.imageBaseUrl + movie.backdropPath,
                        width: Get.width,
                        height: 250,
                        fit: BoxFit.cover,
                        loadingBuilder: (_, __, ___) {
                          // ignore: no_wildcard_variable_uses
                          if (___ == null) return __;
                          return FadeShimmer(
                            width: Get.width,
                            height: 250,
                            highlightColor: const Color(0xff22272f),
                            baseColor: const Color(0xff20252d),
                          );
                        },
                        errorBuilder: (_, __, ___) => const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            Icons.broken_image,
                            size: 250,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.bottomLeft,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            'https://image.tmdb.org/t/p/w500/${movie.posterPath}',
                            width: 110,
                            height: 140,
                            fit: BoxFit.cover,
                            loadingBuilder: (_, __, ___) {
                              // ignore: no_wildcard_variable_uses
                              if (___ == null) return __;
                              return const FadeShimmer(
                                width: 110,
                                height: 140,
                                highlightColor: Color(0xff22272f),
                                baseColor: Color(0xff20252d),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 255,
                      left: 155,
                      child: SizedBox(
                        width: 230,
                        child: Text(
                          movie.title,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 200,
                      right: 30,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: const Color.fromRGBO(37, 40, 54, 0.52),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/Star.svg'),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              movie.voteAverage == 0.0
                                  ? 'N/A'
                                  : movie.voteAverage.toString(),
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFFF8700),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Opacity(
                opacity: .6,
                child: SizedBox(
                  width: Get.width / 1.3,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/calender.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            movie.releaseDate.split('-')[0],
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const Text('|'),
                      Row(
                        children: [
                          SvgPicture.asset('assets/Ticket.svg'),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            Utils.getGenres(movie),
                            style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(24),
                child: DefaultTabController(
                  length: 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const TabBar(
                          indicatorWeight: 4,
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(
                            0xFF3A3F47,
                          ),
                          tabs: [
                            Tab(text: 'Sobre la película'),
                            Tab(text: 'Reseñas'),
                            Tab(text: 'Reparto'),
                          ]),
                      SizedBox(
                        height: 400,
                        child: TabBarView(children: [
                          //Si el resum que es mostra a la pantalla de detalls és molt llarg ens permet veure'l sencer fent scroll
                          SingleChildScrollView(
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 10),
                              child: Text(
                                movie.overview,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w200,
                                ),
                              ),
                            ),
                          ),
                          FutureBuilder<List<Review>?>(
                            future: ApiService.getMovieReviews(movie.id),
                            builder: (_, snapshot) {
                              if (snapshot.hasData) {
                                return snapshot.data!.isEmpty
                                    ? const Padding(
                                        padding: EdgeInsets.only(top: 30.0),
                                        child: Text(
                                          'Sin reseñas',
                                          textAlign: TextAlign.center,
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: snapshot.data!.length,
                                        itemBuilder: (_, index) => Padding(
                                          padding: const EdgeInsets.all(10.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Column(
                                                children: [
                                                  SvgPicture.asset(
                                                    'assets/avatar.svg',
                                                    height: 50,
                                                    width: 50,
                                                    // fit: BoxFit.cover,
                                                  ),
                                                  const SizedBox(
                                                    height: 15,
                                                  ),
                                                  Text(
                                                    snapshot.data![index].rating
                                                        .toString(),
                                                    style: const TextStyle(
                                                      color: Color(0xff0296E5),
                                                    ),
                                                  )
                                                ],
                                              ),
                                              const SizedBox(
                                                width: 10,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    snapshot
                                                        .data![index].author,
                                                    style: const TextStyle(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 10,
                                                  ),
                                                  SizedBox(
                                                    width: 245,
                                                    child: Text(
                                                      snapshot
                                                          .data![index].comment,
                                                      style: const TextStyle(
                                                        fontSize: 8,
                                                        fontWeight:
                                                            FontWeight.w400,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                              } else {
                                return const Center(
                                  child: Text('Wait...'),
                                );
                              }
                            },
                          ),
                          _CastTabContent(movieId: movie.id),
                        ]),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ActorDetailScreen extends StatelessWidget {
  final int actorId;
  final String initialName;
  final String initialProfilePath;

  const ActorDetailScreen({
    super.key,
    required this.actorId,
    required this.initialName,
    required this.initialProfilePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1F26),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1F26),
        elevation: 0,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(initialName,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold)),
        centerTitle: false,
        actions: [
          FutureBuilder<Actor?>(
            //Agafem els detalls complets de l'actor
            future: ApiService.getActorDetails(actorId),
            builder: (context, snapshot) {
              final actor = snapshot.data ??
                  //Si no s'han carregat encara, utilitzem les dades inicials
                  Actor(
                      id: actorId,
                      name: initialName,
                      profilePath: initialProfilePath);
              return Tooltip(                          
                message: 'Guardar este actor en tu lista',
                triggerMode: TooltipTriggerMode.tap,
                child: IconButton(
                  onPressed: () {
                    //Afegim o elimineml'actor a la llista de seguiment segons si ja hi és o no
                    Get.find<ActorsController>().addActorToWatchList(  
                      Actor(
                        id: actor.id,
                        name: actor.name,
                        profilePath: actor.profilePath,
                        biography: actor.biography,
                        birthday: actor.birthday,
                        placeOfBirth: actor.placeOfBirth,
                        knownFor: actor.knownFor,
                        gender: actor.gender,
                        popularity: actor.popularity,
                      ),
                    );
                  },
                  //Actualitzem la icona segons si l'actor està a la llista de seguiment
                  icon: Obx(
                    () {
                      bool isInWatchList =
                          Get.find<ActorsController>().isActorInWatchList(
                        Actor(
                          id: actor.id,
                          name: actor.name,
                          profilePath: actor.profilePath,
                          biography: actor.biography,
                          birthday: actor.birthday,
                          placeOfBirth: actor.placeOfBirth,
                          knownFor: actor.knownFor,
                          gender: actor.gender,
                          popularity: actor.popularity,
                        ),
                      );
                      return isInWatchList
                          ? const Icon(
                              Icons.favorite,
                              color: Colors.red, //Està a la llista
                              size: 28,
                            )
                          : const Icon(
                              Icons.favorite_border,
                              color: Colors.white, //No està a la llista
                              size: 28,
                            );
                    },
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: FutureBuilder<Actor?>(
        //Carreguem les dades de l'API --> detalls complets de l'actor
        future: ApiService.getActorDetails(actorId),
        builder: (context, snapshot) {
          //Gestionem l'estat de càrrega
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child: CircularProgressIndicator(color: Color(0xff0296E5)));
          }
          final actor = snapshot.data ??
              Actor(
                  id: actorId,
                  name: initialName,
                  profilePath: initialProfilePath);
          //Ens permet fer scroll si el contingut és més gran que la pantalla
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      Api.imageBaseUrl + actor.profilePath,
                      height: 300,
                      errorBuilder: (_, __, ___) => const Icon(Icons.person,
                          size: 120, color: Color(0xff0296E5)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  actor.name,
                  style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0296E5)),
                ),
                const SizedBox(height: 12),
                //Mostrem la data de naixement i lloc si estan disponibles
                if (actor.birthday.isNotEmpty)
                  Text(
                    'Nacimiento: ${actor.birthday}',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                if (actor.placeOfBirth.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: Text(
                      'Lugar: ${actor.placeOfBirth}',
                      style:
                          const TextStyle(color: Colors.white70, fontSize: 14),
                    ),
                  ),
                const SizedBox(height: 16),
                const Text(
                  'Biografía',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0296E5)),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF2A2E35),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    actor.biography.isNotEmpty
                        ? actor.biography
                        : 'No disponible',
                    style: const TextStyle(
                        color: Colors.white, fontSize: 14, height: 1.5),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Conocido por',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff0296E5)),
                ),
                const SizedBox(height: 12),

                //Mostrem els crèdits de l'actor
                FutureBuilder<List<dynamic>?>(
                  future: ApiService.getActorCredits(actorId),
                  builder: (context, creditsSnap) {
                    //Gestionem l'estat de càrrega
                    if (creditsSnap.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child:
                            CircularProgressIndicator(color: Color(0xff0296E5)),
                      );
                    }
                    final credits = creditsSnap.data ?? [];
                    if (credits.isEmpty)
                      return const Text(
                        'No hay créditos disponibles',
                        style: TextStyle(color: Colors.white70),
                      );
                    return GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(), //Deshabilitem el scroll intern
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount( //Definim la graella
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.6,
                      ),
                      itemCount: credits.length > 10 ? 10 : credits.length, //Mostrem un màxim de 10 crèdits
                      itemBuilder: (context, index) {
                        final credit = credits[index];
                        final title =
                            credit['title'] ?? credit['name'] ?? 'Sin título';
                        final posterPath = credit['poster_path'] ?? '';
                        final movieId = credit['id'] ?? 0;
                        final mediaType = credit['media_type'] ?? 'movie';
                        final year = (credit['release_date'] ??
                            credit['first_air_date'] ??
                            '') as String;

                        //Extraiem només l'any de la data completa
                        return GestureDetector(
                          onTap: () async {
                            if (mediaType == 'movie' && movieId != 0) {
                              final movie =
                                  await ApiService.getMovieDetails(movieId); //Agafem els detalls complets de la pel·lícula
                              if (movie != null) {
                                Get.to(
                                  () => DetailsScreen(movie: movie), //Naveguem a la pantalla de detalls
                                  transition: Transition.fadeIn,
                                );
                              } else {
                                print(
                                    'Error: película no se cargó (getMovieDetails retornó null)');
                              }
                            }
                          },
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8),
                                child: posterPath.isNotEmpty
                                    ? Image.network(
                                        Api.imageBaseUrl + posterPath,
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (_, __, ___) => Container(
                                          height: 200,
                                          color: const Color(0xFF2A2E35),
                                          child: const Icon(
                                              Icons.image_not_supported,
                                              color: Color(0xff0296E5)),
                                        ),
                                      )
                                    : Container(
                                        height: 200,
                                        color: const Color(0xFF2A2E35),
                                        child: const Icon(Icons.image,
                                            color: Color(0xff0296E5)),
                                      ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                title,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Color(0xff0296E5),
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                              ),
                              if (year.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    year,
                                    style: const TextStyle(
                                        color: Colors.white54, fontSize: 12),
                                  ),
                                ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _CastTabContent extends StatefulWidget {
  final int movieId;
  const _CastTabContent({Key? key, required this.movieId}) : super(key: key);

  @override
  State<_CastTabContent> createState() => _CastTabContentState();
}

class _CastTabContentState extends State<_CastTabContent> {
  late Future<List<dynamic>?> _castFuture;
  int _displayedCount = 10;

  @override
  void initState() {
    super.initState();
    _castFuture = ApiService.getMovieCredits(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    //Carreguem els participants de la pel·lícula
    return FutureBuilder<List<dynamic>?>(
      future: _castFuture,
      builder: (context, castSnap) {
        if (castSnap.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: Color(0xff0296E5)));
        }
        final cast = castSnap.data ?? [];
        if (cast.isEmpty) {
          return const Center(child: Text('No hay reparto disponible'));
        }

        // Mostrem només una part del repartiment --> opció de veure més
        final displayedCast = cast.take(_displayedCount).toList();
        final hasMore = cast.length > displayedCast.length;

        //Construïm la llista de participants
        return ListView.builder(
          itemCount: displayedCast.length + (hasMore ? 1 : 0),
          itemBuilder: (context, index) {
            if (index == displayedCast.length) {
              final remaining = cast.length - _displayedCount; //Participants restants per mostrar
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0296E5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                    ),
                    onPressed: () {
                      setState(() {
                        _displayedCount =
                            (_displayedCount + 10).clamp(0, cast.length); //Augmentem el nombre de participants mostrats
                      });
                    },
                    child: Text(
                      remaining > 0
                          ? 'Ver más ($remaining restantes)'
                          : 'Ver más',
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              );
            }

            final person = displayedCast[index];
            final name = person['name'] ?? 'Desconocido';
            final profile = person['profile_path'] ?? '';
            final character = person['character'] ?? 'Sin especificar';

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: GestureDetector( //Fem que tota la fila sigui clicable
                onTap: () {
                  //Naveguem a la pantalla de detalls de l'actor
                  Get.to(() => ActorDetailScreen(
                        actorId: person[
                            'id'], //Pasem l'ID de l'actor per carregar els detalls
                        initialName: name,
                        initialProfilePath: profile,
                      ));
                },
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: profile.isNotEmpty
                          ? Image.network(
                              Api.imageBaseUrl + profile,
                              height: 80,
                              width: 60,
                              fit: BoxFit.cover,
                              errorBuilder: (_, __, ___) => Container(
                                height: 80,
                                width: 60,
                                color: const Color(0xFF2A2E35),
                                child: const Icon(Icons.person,
                                    color: Color(0xff0296E5), size: 30),
                              ),
                            )
                          : Container(
                              height: 80,
                              width: 60,
                              color: const Color(0xFF2A2E35),
                              child: const Icon(Icons.person,
                                  color: Color(0xff0296E5), size: 30),
                            ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            name,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'como $character',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
