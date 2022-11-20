import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:themoviedb/domain/api_client/movie_api_client.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class MovieDetailPosterData {
  final String? backdropPath;
  final bool isFavorite;

  MovieDetailPosterData(this.backdropPath, this.isFavorite);
}

class MovieDetailsData {
  String title = 'Загрузка...';
  bool isLoading = true;
  String overview = '';
}

class MovieDetailsViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _sessionDataProvider = SessionDataProvider();
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();

  final int movieId;
  final data = MovieDetailsData();
  MovieDetails? _movieDetails;
  bool _isFavorite = false;
  String _locale = '';
  late DateFormat _dateFormat;

  MovieDetails? get movieDetails => _movieDetails;

  bool? get isFavorite => _isFavorite;

  MovieDetailsViewModel({
    required this.movieId,
  });

  Future<void> setupLocale(BuildContext context) async {
    final locale = Localizations.localeOf(context).toLanguageTag();
    if (_locale == locale) return;
    _locale = locale;
    _dateFormat = DateFormat.yMMMMd(locale);
    updateData(null);
    await loadDetails(context);
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      _movieDetails = await _movieApiClient.movieDetails(movieId, _locale);
      final sessionId = await _sessionDataProvider.getSessionId();
      if (sessionId != null) {
        _isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      }
      updateData(_movieDetails);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void updateData(MovieDetails? details) {
    data.title = _movieDetails?.title ?? 'Загрузка...';
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }
    data.overview = details.overview ?? '';
    notifyListeners();
  }

  Future<void> toggleFavorite(BuildContext context) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if (sessionId == null || accountId == null) return;

    _isFavorite = !_isFavorite;
    notifyListeners();

    try {
      await _accountApiClient.markAsFavorite(
        accountId: accountId,
        sessionId: sessionId,
        mediaType: MediaType.movie,
        mediaId: movieId,
        isFavorite: _isFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void _handleApiClientException(
      ApiClientException exception, BuildContext context) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logout();
        MainNavigation.resetNavigation(context);
        break;
      default:
        print(exception);
    }
  }

  void backToMovies(BuildContext context) {
    Navigator.pop(context);
  }
}
