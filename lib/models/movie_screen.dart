import 'cast.dart';
import 'movie.dart';

class MovieScreenArgs {
  final Movie movie;
  final Future<List<Cast>> casts;
  final String moviePoster;

  MovieScreenArgs(
    this.movie,
    this.moviePoster,
    this.casts,
  );
}
