import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/models/movie_screen.dart';

class MovieScreen extends StatelessWidget {
  const MovieScreen({super.key});

  static const route = '/movie';

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as MovieScreenArgs;

    return Scaffold(
      appBar: AppBar(
        title: Text(args.movie.title),
      ),
      body: Center(
        child: Text(args.movie.title),
      ),
    );
  }
}
