import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/domain/entity/movie_details.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/services/movie_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/library/localized_model.dart';

class MovieDetailsPosterData {
  final String voteAverage;
  final String voteCount;
  final String? backdropPath;
  final String? trailerKey;

  final bool isWatchlist;

  IconData get isWatchlistIcon =>
      isWatchlist ? Icons.bookmark_rounded : Icons.bookmark_border_rounded;

  MovieDetailsPosterData({
    this.trailerKey,
    required this.voteAverage,
    required this.voteCount,
    this.backdropPath,
    this.isWatchlist = false,
  });

  MovieDetailsPosterData copyWith({
    String? voteAverage,
    String? voteCount,
    String? backdropPath,
    String? trailerKey,
    bool? isWatchlist,
  }) {
    return MovieDetailsPosterData(
      voteAverage: voteAverage ?? this.voteAverage,
      voteCount: voteCount ?? this.voteCount,
      backdropPath: backdropPath ?? this.backdropPath,
      trailerKey: trailerKey ?? this.trailerKey,
      isWatchlist: isWatchlist ?? this.isWatchlist,
    );
  }
}

class MovieDetailsInformationData {
  final String title;
  final String? overview;
  final bool isFavorite;
  final String? year;
  final String runtimeData;
  final List<String> genres;
  final String ageRating;

  IconData get isFavoriteIcon =>
      isFavorite ? Icons.favorite_rounded : Icons.favorite_border_rounded;

  MovieDetailsInformationData({
    this.isFavorite = false,
    required this.genres,
    required this.title,
    required this.overview,
    this.year,
    required this.runtimeData,
    required this.ageRating,
  });

  MovieDetailsInformationData copyWith({
    String? title,
    String? overview,
    bool? isFavorite,
    String? year,
    String? runtimeData,
    List<String>? genres,
    String? ageRating,
  }) {
    return MovieDetailsInformationData(
      title: title ?? this.title,
      overview: overview ?? this.overview,
      isFavorite: isFavorite ?? this.isFavorite,
      year: year ?? this.year,
      runtimeData: runtimeData ?? this.runtimeData,
      genres: genres ?? this.genres,
      ageRating: ageRating ?? this.ageRating,
    );
  }
}

class MovieDetailsRuntimeData {
  final String hours;
  final String minutes;

  MovieDetailsRuntimeData({
    required this.hours,
    required this.minutes,
  });
}

class MovieDetailsActorData {
  final int id;
  final String name;
  final String character;
  final String? profilePath;

  MovieDetailsActorData({
    required this.name,
    required this.character,
    required this.id,
    this.profilePath,
  });
}

class MovieDetailsData {
  bool isLoading = true;
  MovieDetailsPosterData posterData = MovieDetailsPosterData(
    voteAverage: '',
    voteCount: '',
  );

  MovieDetailsInformationData informationData = MovieDetailsInformationData(
    title: '',
    overview: '',
    year: '',
    runtimeData: '',
    ageRating: '',
    genres: [],
  );

  List<MovieDetailsActorData> castData = const <MovieDetailsActorData>[];
}

class MovieDetailsViewModel extends ChangeNotifier {
  final _authService = AuthService();
  final _movieService = MovieService();

  final int movieId;
  final data = MovieDetailsData();
  final _localizedStorage = LocalizedModelStorage();
  late DateFormat _dateFormat;

  MovieDetailsViewModel({required this.movieId});

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if (!_localizedStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localizedStorage.localeTag);
    updateData(null, false, false);
    await loadDetails(context);
  }

  void updateData(MovieDetails? details, bool isFavorite, bool isWatchlist) {
    //TODO add final
    data.isLoading = details == null;
    if (details == null) {
      notifyListeners();
      return;
    }

    final videos = details.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;

    data.posterData = MovieDetailsPosterData(
      backdropPath: details.backdropPath,
      isWatchlist: isWatchlist,
      voteAverage: details.voteAverage.toStringAsFixed(1),
      voteCount: details.voteCount.toString(),
      trailerKey: trailerKey,
    );
    data.informationData = MovieDetailsInformationData(
      isFavorite: isFavorite,
      title: details.title,
      overview: details.overview,
      year: details.releaseDate?.year.toString(),
      runtimeData: makeRuntime(details),
      genres: makeGenres(details),
      ageRating: 'PG-13', //TODO
    );
    data.castData = details.credits.cast
        .map(
          (e) => MovieDetailsActorData(
            id: e.id,
            name: e.name,
            character: e.character,
            profilePath: e.profilePath,
          ),
        )
        .toList();
    notifyListeners();
  }

  List<String> makeGenres(MovieDetails details) {
    final genres = details.genres;
    final genresNames = <String>[];
    for (var genre in genres) {
      genresNames.add(genre.name);
    }
    return genresNames;
  }

  String makeRuntime(MovieDetails details) {
    final runtime = details.runtime ?? 0;
    final duration = Duration(minutes: runtime);
    final hours = duration.inHours;
    final minutes = duration.inMinutes.remainder(60);
    final runtimeData = hours == 0 ? "${minutes}m" : "${hours}h ${minutes}m";
    return runtimeData;
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      final details = await _movieService.loadDetails(
        movieId: movieId,
        locale: _localizedStorage.localeTag,
      );
      updateData(
        details.details,
        details.isFavorite,
        details.isWatchlist,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  Future<void> toggleFavorite(BuildContext context) async {
    data.informationData = data.informationData
        .copyWith(isFavorite: !data.informationData.isFavorite);

    notifyListeners();

    try {
      await _movieService.updateFavorite(
        movieId: movieId,
        isFavorite: data.informationData.isFavorite,
      );
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  Future<void> toggleWatchlist(BuildContext context) async {
    data.posterData =
        data.posterData.copyWith(isWatchlist: !data.posterData.isWatchlist);
    notifyListeners();

    try {
      await _movieService.updateWatchlist(
        movieId: movieId,
        isWatchlist: data.posterData.isWatchlist,
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

  void openDetailsPerson(BuildContext context, int personId){
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.peopleDetailsScreen,
      arguments: personId,
    );
  }
}
