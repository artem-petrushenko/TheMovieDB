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

  MovieDetailsLocal copyWith({
    MovieDetails? details,
    bool? isFavorite,
    bool? isWatchlist,
  }) {
    return MovieDetailsLocal(
      details: details ?? this.details,
      isFavorite: isFavorite ?? this.isFavorite,
      isWatchlist: isWatchlist ?? this.isWatchlist,
    );
  }
}
