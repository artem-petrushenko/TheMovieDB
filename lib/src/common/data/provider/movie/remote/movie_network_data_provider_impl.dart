import 'package:themoviedb/src/common/data/client/rest_client/rest_client.dart';
import 'package:themoviedb/src/common/data/provider/movie/remote/movie_network_data_provider.dart';

import '../../../../../../domain/entity/movie_details.dart';
import '../../../../../../domain/entity/popular_movie_response.dart';
import '../../../../constants/string.dart';

class MovieNetworkDataProviderImpl implements MovieNetworkDataProvider {
  const MovieNetworkDataProviderImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<PopularMovieResponse> popularMovie(
      int page, String locale, String apiKey) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _client.get(
      '/movie/popular',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'page': page.toString(),
        'language': locale,
      },
    );
    return result;
  }

  @override
  Future<PopularMovieResponse> searchMovie(
    int page,
    String locale,
    String query,
    String apiKey,
  ) async {
    PopularMovieResponse parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }

    final result = _client.get(
      '/search/movie',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'page': page.toString(),
        'language': locale,
        'query': query,
        'include_adult': true.toString(),
      },
    );
    return result;
  }

  @override
  Future<MovieDetails> movieDetails(
    int movieId,
    String locale,
  ) async {
    MovieDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }

    final result = _client.get(
      '/movie/$movieId',
      parser,
      <String, dynamic>{
        'append_to_response': 'credits,videos',
        'api_key': apiKey,
        'language': locale,
      },
    );
    return result;
  }

  @override
  Future<Map<String, dynamic>> accountState(
    int movieId,
    String sessionId,
  ) async {
    Map<String, dynamic> parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap;
      return result;
    }

    final result = _client.get(
      '/movie/$movieId/account_states',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
