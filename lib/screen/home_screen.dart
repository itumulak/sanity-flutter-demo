import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/models/movie.dart';
import 'package:sanity_flutter_demo/models/sanity_client.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final SanityClient sanityClient = SanityClient(
    projectId: '7hso24qo',
    dataset: 'production',
    useCdn: true,
  );

  late List<Movie> movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovies();
  }

  Future<void> fetchMovies() async {
    const String query = '*[_type == "movie"] { _id, title, poster { asset->{ url } } }';
    final List<dynamic> result = await sanityClient.fetch(query: query);

    if (result is List<dynamic>) {
      setState(() {
        movies = result.map((data) => Movie.fromJson(data)).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Text(''),
      ),
    );
  }
}
