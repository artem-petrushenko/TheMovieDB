import '../../../../../../domain/entity/movie_details.dart';
import '../../../../../../domain/entity/popular_movie_response.dart';

abstract interface class MovieNetworkDataProvider {
  Future<PopularMovieResponse> popularMovie(
    int page,
    String locale,
    String apiKey,
  );

  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
    String apiKey,
  );

  Future<MovieDetails> movieDetails(
    int movieId,
    String locale,
  );

  Future<Map<String, dynamic>> accountState(
    int movieId,
    String sessionId,
  );
}
