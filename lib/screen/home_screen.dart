import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/components/movie_gallery.dart';
import 'package:sanity_flutter_demo/models/movie.dart';
import 'package:sanity_flutter_demo/services/sanity_client.dart';

import '../models/cast.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static const route = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SanityClient sanityClient = SanityClient(
    projectId: '7hso24qo',
    dataset: 'production',
    useCdn: true,
  );

  late Future<List<Movie>> _movies;

  @override
  void initState() {
    super.initState();
    _movies = fetchMovies();
  }

  Future<List<Movie>> fetchMovies() async {
    const String query = '*[_type == "movie"] { _id, title, releaseDate, overview[0] { children[0] { text } }, poster { asset->{ url } }, castMembers[] { person->{ _id, name, image { asset->{ url, metadata } } } }}';
    final List<dynamic> result = await sanityClient.fetch(query: query);

    return result.map((data) => Movie.fromJson(data)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(color: Colors.white70),
          child: FutureBuilder(
            future: _movies,
            builder: (context, snapshot) {
              if(snapshot.hasData) {
                List<Movie> movies = snapshot.data!;
                List<String> moviePosters = movies.map((data) => data.imageUrl).toList();

                return MovieGallery(
                  movies: movies,
                  moviePosters: moviePosters,
                );
              }

              return const CircularProgressIndicator();
            },
          ),
        ),
      ),
    );
  }
}
