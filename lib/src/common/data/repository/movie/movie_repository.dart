import '../../../../../domain/entity/popular_movie_response.dart';
import '../../../../../domain/local_entity/movie_details_local.dart';

abstract interface class MovieRepository {
  Future<PopularMovieResponse> popularMovie(int page, String locale);

  Future<PopularMovieResponse> searchMovie(
      int page, String locale, String query);

  Future<MovieDetailsLocal> loadDetails({
    required int movieId,
    required String locale,
  });

  Future<void> updateFavorite({
    required int movieId,
    required bool isFavorite,
  });

  Future<void> updateWatchlist({
    required int movieId,
    required bool isWatchlist,
  });
}
