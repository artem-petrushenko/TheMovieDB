import 'package:themoviedb/domain/entity/movie_details.dart';

class MovieDetailsLocal {
  final MovieDetails details;
  final bool isFavorite;
  final bool isWatchlist;

  MovieDetailsLocal({
    required this.details,
    required this.isFavorite,
    required this.isWatchlist,
  });
}
