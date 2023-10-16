part of 'movies_bloc.dart';

@immutable
sealed class MovieListEvent {}

class MovieListLoadNextPageEvent extends MovieListEvent {
  final String locale;

  MovieListLoadNextPageEvent(
    this.locale,
  );
}

class MovieListResetEvent extends MovieListEvent {
  MovieListResetEvent();
}

class MovieListSearchEvent extends MovieListEvent {
  final String query;

  MovieListSearchEvent(
    this.query,
  );
}
