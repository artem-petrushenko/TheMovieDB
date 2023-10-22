import 'package:themoviedb/src/common/data/provider/account/remove/account_network_data_provider.dart';
import 'package:themoviedb/src/common/data/provider/movie/remote/movie_network_data_provider.dart';
import 'package:themoviedb/src/common/data/provider/session/local/session_storage.dart';
import 'package:themoviedb/src/common/data/repository/movie/movie_repository.dart';

import '../../../../../domain/entity/popular_movie_response.dart';
import '../../../../../domain/local_entity/movie_details_local.dart';
import '../../../constants/string.dart';
import '../../../utils/extension/media_type_as_string.dart';

class MovieRepositoryImpl implements MovieRepository {
  MovieRepositoryImpl(
      {required MovieNetworkDataProvider movieNetworkDataProvider,
      required SessionStorage sessionStorage,
      required AccountNetworkDataProvider accountNetworkDataProvider})
      : _accountNetworkDataProvider = accountNetworkDataProvider,
        _movieNetworkDataProvider = movieNetworkDataProvider,
        _sessionStorage = sessionStorage;

  final AccountNetworkDataProvider _accountNetworkDataProvider;
  final MovieNetworkDataProvider _movieNetworkDataProvider;
  final SessionStorage _sessionStorage;

  @override
  Future<PopularMovieResponse> popularMovie(int page, String locale) async =>
      _movieNetworkDataProvider.popularMovie(page, locale, apiKey);

  @override
  Future<PopularMovieResponse> searchMovie(
          int page, String locale, String query) async =>
      _movieNetworkDataProvider.searchMovie(page, locale, query, apiKey);

  @override
  Future<MovieDetailsLocal> loadDetails({
    required int movieId,
    required String locale,
  }) async {
    final movieDetails =
        await _movieNetworkDataProvider.movieDetails(movieId, locale);
    final sessionId = await _sessionStorage.getSessionId();

    bool isFavorite = false;
    bool isWatchlist = false;
    if (sessionId != null) {
      final accountState =
          await _movieNetworkDataProvider.accountState(movieId, sessionId);

      isWatchlist = accountState['watchlist'] as bool;
      isFavorite = accountState['favorite'] as bool;
    }

    return MovieDetailsLocal(
      details: movieDetails,
      isFavorite: isFavorite,
      isWatchlist: isWatchlist,
    );
  }

  @override
  Future<void> updateFavorite({
    required int movieId,
    required bool isFavorite,
  }) async {
    final sessionId = await _sessionStorage.getSessionId();
    final accountId = await _sessionStorage.getAccountId();

    if (sessionId == null || accountId == null) return;

    await _accountNetworkDataProvider.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isFavorite: isFavorite,
    );
  }

  @override
  Future<void> updateWatchlist({
    required int movieId,
    required bool isWatchlist,
  }) async {
    final sessionId = await _sessionStorage.getSessionId();
    final accountId = await _sessionStorage.getAccountId();

    if (sessionId == null || accountId == null) return;

    await _accountNetworkDataProvider.markAsWatchlist(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isWatchlist: isWatchlist,
    );
  }
}
