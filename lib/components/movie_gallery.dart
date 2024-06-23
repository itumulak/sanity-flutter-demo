import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MovieGallery extends StatefulWidget {
  MovieGallery({super.key, required this.moviePosters});

  final List<String> moviePosters;

  @override
  State<MovieGallery> createState() => _MovieGalleryState();
}

class _MovieGalleryState extends State<MovieGallery> {
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
              if (kDebugMode) {
                print('hello');
              }
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
