import 'package:fade_shimmer/fade_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movies/api/api.dart';
import 'package:movies/api/api_service.dart';
import 'package:movies/models/movie.dart';
import 'package:movies/screens/details_screen.dart';
import 'package:movies/widgets/index_number.dart';

class MoviesHomeView extends StatelessWidget { 
  const MoviesHomeView({super.key}); 

  // Cosntruïm la URL de l'endpoint amb els paràmetres necessaris --> key i l'idioma que volem
  String _endpoint(String path) =>
      '$path?api_key=${Api.apiKey}&language=es-ES&page=1';

  // Fila de pel·lícules destacades (Top Rated) --> acompanyades d'un número d'índex
  Widget _featuredRow() {
    return FutureBuilder<List<Movie>?>(
      future: ApiService.getTopRatedMovies(), //Cridem a l'endpoint de Top Rated
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SizedBox( 
            height: 220,
            child: Row(
              children: [
                Expanded(
                  child: FadeShimmer(
                    width: double.infinity,
                    height: 220,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: FadeShimmer(
                    width: double.infinity,
                    height: 220,
                    highlightColor: Color(0xff22272f),
                    baseColor: Color(0xff20252d),
                  ),
                ),
              ],
            ),
          );
        }
        // Un cop tenim les dades, les mostrem en un PageView
        final movies = snapshot.data ?? [];
        if (movies.isEmpty) return const SizedBox(height: 380); //Si no hi ha dades, retornem un espai buit
        final controller =
            PageController(viewportFraction: 0.8, keepPage: true);
        return SizedBox(
          height: 380,
          //Construïm com volem que es vegi la pantalla amb les pel·lícules
          child: PageView.builder( 
            controller: controller,
            itemCount: movies.length,
            padEnds: false,
            physics: const BouncingScrollPhysics(), //Efecte de rebot al final de la llista
            itemBuilder: (context, index) {
              final m = movies[index];
              return Padding(
                padding: EdgeInsets.only( // Afegim marge a l'esquerra del primer element --> sense això no es veu bé
                  left: index == 0 ? 16 : 0,
                  right: 16,
                ),
                // Permet detectar tocs en cada element del PageView --> si en detecta  --> obre la pantalla de detalls d'aquesta pel·lícula
                child: GestureDetector( 
                  onTap: () => Get.to(DetailsScreen(movie: m)),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            Api.imageBaseUrl + m.posterPath,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.broken_image, size: 120),
                          ),
                        ),
                      ),
                      Positioned(
                        left: -12,
                        bottom: -24,
                        child: IndexNumber(number: index + 1),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  // Llista de pel·lícules per a cada pestanya --> d'aquesta manera evitem repetir codi --> per cada pestanya només canviem l'endpoint
  Widget _tabList(
    String endpoint, {
    int crossAxisCount = 3,
    double childAspectRatio = 0.62,
  }) {
    // Cridem a l'endpoint corresponent i mostrem les pel·lícules en una graella --> GridView Builder
    return FutureBuilder<List<Movie>?>(
      future: ApiService.getCustomMovies(_endpoint(endpoint)), //Cridem a l'endpoint corresponent
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        final movies = snapshot.data ?? [];
        if (movies.isEmpty) {
          return const Center(child: Text('Sin datos')); 
        }
        return GridView.builder( 
          padding: EdgeInsets.zero,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: childAspectRatio,
          ),
          itemCount: movies.length,
          itemBuilder: (_, index) {
            final m = movies[index];
            return GestureDetector(
              onTap: () => Get.to(DetailsScreen(movie: m)), //Obrim la pantalla de detalls d'aquesta pel·lícula
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  Api.imageBaseUrl + m.posterPath,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    decoration: BoxDecoration(
                      color: const Color(0xff0296E5),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.movie,
                        size: 60,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  // Construïm la vista principal de pel·lícules --> amb les pel·lícules destacades i les pestanyes
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _featuredRow(),
          ),
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
        child: DefaultTabController(   // Controlador de les pestanyes
            length: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const TabBar(
                  isScrollable: false,
                  indicatorColor: Color(0xff0296E5),
                  indicatorWeight: 4,
                  indicatorSize: TabBarIndicatorSize.label,
                  labelColor: Color(0xff0296E5),
                  unselectedLabelColor: Colors.white54,
                  tabs: [
                    Tab(text: 'En cartelera'),
                    Tab(text: 'Próximamente'),
                    Tab(text: 'Mejor valoradas'),
                    Tab(text: 'Populares'),
                  ],
                ),
                SizedBox(
                  height: 1,
                  child: Container(color: Color(0xFF3A3F47)),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 460,
                  child: TabBarView(
                    children: [
                      _tabList('now_playing'),
                      _tabList('upcoming'),
                      _tabList('top_rated'),
                      _tabList('popular'),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ),
        ],
      ),
    );
  }
}
