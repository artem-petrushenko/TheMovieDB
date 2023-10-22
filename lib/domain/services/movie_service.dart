import 'package:themoviedb/src/common/constants/string.dart';

import 'package:themoviedb/domain/entity/popular_movie_response.dart';

import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/local_entity/movie_details_local.dart';

import 'package:themoviedb/src/common/data/client/secure_storage_dao.dart';

import '../../src/common/data/provider/session/local/session_storage_impl.dart';

class MovieService {
  final _movieApiClient = MovieApiClient();
  final _sessionDataProvider =
      SessionStorageImpl(secureStorageDao: SecureStorageDao());
  final _accountApiClient = AccountApiClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async =>
      _movieApiClient.popularMovie(page, locale, apiKey);

  Future<PopularMovieResponse> searchMovie(
          int page, String locale, String query) async =>
      _movieApiClient.searchMovie(page, locale, query, apiKey);

  Future<MovieDetailsLocal> loadDetails({
    required int movieId,
    required String locale,
  }) async {
    final movieDetails = await _movieApiClient.movieDetails(movieId, locale);
    final sessionId = await _sessionDataProvider.getSessionId();

    bool isFavorite = false;
    bool isWatchlist = false;
    if (sessionId != null) {
      final accountState =
          await _movieApiClient.accountState(movieId, sessionId);

      isWatchlist = accountState['watchlist'] as bool;
      isFavorite = accountState['favorite'] as bool;
    }

    return MovieDetailsLocal(
      details: movieDetails,
      isFavorite: isFavorite,
      isWatchlist: isWatchlist,
    );
  }

  Future<void> updateFavorite({
    required int movieId,
    required bool isFavorite,
  }) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    await _accountApiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isFavorite: isFavorite,
    );
  }

  Future<void> updateWatchlist({
    required int movieId,
    required bool isWatchlist,
  }) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    await _accountApiClient.markAsWatchlist(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isWatchlist: isWatchlist,
    );
  }
}
