import 'package:flutter/cupertino.dart';
import 'package:sanity_flutter_demo/models/movie.dart';

class Movies extends ChangeNotifier {
  final Movie movie;

  Movies({required this.movie});
}