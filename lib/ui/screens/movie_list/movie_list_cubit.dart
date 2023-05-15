import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:intl/intl.dart';

import 'package:themoviedb/domain/blocs/movie_list/movie_list_bloc.dart';
import 'package:themoviedb/domain/entity/movie.dart';

part 'movie_list_state.dart';

class MovieListRowData {
  final int id;
  final String? posterPath;
  final String title;
  final String releaseDate;
  final String overview;

  const MovieListRowData({
    required this.id,
    required this.posterPath,
    required this.title,
    required this.releaseDate,
    required this.overview,
  });
}

class MovieListCubit extends Cubit<MovieListCubitState> {
  final MovieListBloc movieListBloc;
  late final StreamSubscription<MovieListState> movieListBlocSubscription;
  late DateFormat _dateFormat;
  Timer? searchDebounce;

  MovieListCubit({
    required this.movieListBloc,
  }) : super(
          MovieListCubitState(
            movies: <MovieListRowData>[],
            localeTag: '',
          ),
        ) {
    Future.microtask(() {
      _onState(movieListBloc.state);
      movieListBlocSubscription = movieListBloc.stream.listen(_onState);
    });
  }

  void _onState(MovieListState state) {
    final movies = state.movies.map(_makeRowData).toList();
    final newState = this.state.copyWith(movies: movies);
    emit(newState);
  }

  void setupLocale(String localeTag) {
    if (state.localeTag == localeTag) return;
    final newState = state.copyWith(localeTag: localeTag);
    emit(newState);
    _dateFormat = DateFormat.yMMMd(localeTag);
    movieListBloc.add(MovieListResetEvent());
    movieListBloc.add(MovieListLoadNextPageEvent(localeTag));
  }

  MovieListRowData _makeRowData(Movie movie) {
    final releaseDate = movie.releaseDate;
    final releaseDateTitle =
        releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieListRowData(
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.title,
      releaseDate: releaseDateTitle,
      overview: movie.overview,
    );
  }

  void showedMovieAtIndex(int index) {
    if(index < state.movies.length - 1) return;
    movieListBloc.add(MovieListLoadNextPageEvent(state.localeTag));
  }

  void searchMovie(String text) {
    searchDebounce?.cancel();
    searchDebounce = Timer(const Duration(microseconds: 250), () async {
      movieListBloc.add(MovieListSearchEvent(text));
      movieListBloc.add(MovieListLoadNextPageEvent(state.localeTag));
    });
  }

  @override
  Future<void> close() {
    movieListBlocSubscription.cancel();
    return super.close();
  }
}
