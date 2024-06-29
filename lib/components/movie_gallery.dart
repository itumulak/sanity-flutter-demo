import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/models/movie_screen.dart';
import 'package:sanity_flutter_demo/screen/movie_screen.dart';

import '../models/cast.dart';
import '../models/movie.dart';
import '../services/sanity_client.dart';

class MovieGallery extends StatefulWidget {
  const MovieGallery({
    super.key,
    required this.movies,
    required this.moviePosters,
  });

  final List<String> moviePosters;
  final List<Movie> movies;

  @override
  State<MovieGallery> createState() => _MovieGalleryState();
}

class _MovieGalleryState extends State<MovieGallery> {
  final SanityClient sanityClient = SanityClient(
    projectId: '7hso24qo',
    dataset: 'production',
    useCdn: true,
  );

  Future<List<Cast>> fetchCasts(String id) async {
    String query =
        '*[_type == "movie" && _id == "$id"] { _id, castMembers[] { person->{ _id, name, image { asset->{ url, metadata } } } } }';
    final List<dynamic> result = await sanityClient.fetch(query: query);
    final castMembers = result[0]['castMembers'] as List;

    return castMembers.map((data) => Cast.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: widget.moviePosters.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              final Movie movie = widget.movies[index];
              final String poster = widget.moviePosters[index];
              late Future<List<Cast>> casts =
                  fetchCasts(widget.movies[index].id);

              Navigator.pushNamed(
                context,
                MovieScreen.route,
                arguments: MovieScreenArgs(movie, poster, casts),
              );
            },
            child: GridTile(
              child: Image.network(
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) {
                    return child;
                  }
                  else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                },
                widget.moviePosters[index],
                fit: BoxFit.fitHeight,
                height: double.infinity,
                width: double.infinity,
              ),
            ),
          );
        },
      ),
    );
  }
}
