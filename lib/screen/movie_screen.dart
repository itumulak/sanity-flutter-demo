import 'package:flutter/material.dart';
import 'package:sanity_flutter_demo/components/cast_list.dart';
import 'package:sanity_flutter_demo/models/movie_screen.dart';

import '../models/cast.dart';

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
      body: ListView(
        children: [
          Image.network(
            args.moviePoster,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 30,
            ),
            child: Text(
              args.movie.overview,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20),
            child: Text(
              'Casts',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          FutureBuilder(
            future: args.casts,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Cast> casts = snapshot.data!;

                return CastList(casts: casts);
              }

              return const Text(
                'Loading casts...',
                textAlign: TextAlign.center,
              );
            },
          ),
        ],
      ),
    );
  }
}
