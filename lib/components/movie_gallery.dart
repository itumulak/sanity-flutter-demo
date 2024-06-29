import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/models/movie_screen.dart';
import 'package:sanity_flutter_demo/screen/movie_screen.dart';
import 'package:sprintf/sprintf.dart';

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
        '*[_type == "movie" && _id == "movie_10681"] { _id, castMembers[] { person->{ _id, name, image { asset->{ url, metadata } } } } }';
    final List<dynamic> result = await sanityClient.fetch(query: query);
    final castMembers = result[0]['castMembers'] as List;

    return castMembers.map((data) => Cast.fromJson(data)).toList();

    // print(result[0]['castMembers'][0]['person']);

    // Cast cast = Cast.fromJson(result[0]['castMembers'][0]);
    // for (var data in result[0]['castMembers']) {
    //   if (kDebugMode) {
    // print(data['person']);
    // result.map((data) => Movie.fromJson(data)).toList();
    // print(data['person'].map((data) => Cast.fromJson(data)).toList());
    //   }
    // }
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
          crossAxisSpacing: 1,
          mainAxisSpacing: 1,
        ),
        itemCount: widget.moviePosters.length,
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              final Movie movie = widget.movies[index];
              final String poster = widget.moviePosters[index];
              late Future<List<Cast>> casts = fetchCasts(widget.movies[index].id);

              Navigator.pushNamed(
                context,
                MovieScreen.route,
                arguments: MovieScreenArgs(
                  movie,
                  poster,
                  casts
                ),
              );

              // if (kDebugMode) {
              // print(poster);
              // print(fetchCasts(widget.movies[index].id));
              // final String casts = widget.movies[index].casts;
              // final parsedCasts = (jsonDecode(casts) as List).cast<Map<String, dynamic>>();
              // print(widget.movies[index].casts);
              // Map<dynamic, String> casts = jsonDecode(widget.movies[index].casts);
              // final List<Cast> casts = widget.movies[index].casts.map((data) => Cast.fromJson(data));
              // print(casts);
              // print(widget.movies[index].casts);
              // print(widget.movies[index].id);
              // }
            },
            child: GridTile(
              child: Image.network(
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
