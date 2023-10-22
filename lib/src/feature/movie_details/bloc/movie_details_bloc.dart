import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:themoviedb/src/common/data/repository/movie/movie_repository.dart';

import '../../../../domain/local_entity/movie_details_local.dart';
import '../../../../library/localized_model.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

part 'movie_details_bloc.freezed.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final _localizedStorage = LocalizedModelStorage();

  final MovieRepository _movieRepository;

  MovieDetailsBloc({
    required MovieRepository movieRepository,
  })  : _movieRepository = movieRepository,
        super(const MovieDetailsState.loading()) {
    on<MovieDetailsEvent>(
      (event, emit) => event.map<Future<void>>(
        fetchDetails: (event) => _onFetchDetails(event, emit),
        changeFavorite: (event) => _onChangeFavorite(event, emit),
        changeWatchlist: (event) => _onChangeWatchlist(event, emit),
      ),
    );
  }

  Future<void> _onFetchDetails(
    _FetchDetails event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      final details = await _movieRepository.loadDetails(
        movieId: event.movieId,
        locale: _localizedStorage.localeTag,
      );
      emit(_Success(details: details));
    } on Object catch (error) {
      emit(_Failure(error: error));
    }
  }

  Future<void> _onChangeFavorite(
    _ChangeFavorite event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      final currentState = state as _Success;

      _movieRepository.updateFavorite(
        movieId: event.movieId,
        isFavorite: event.isFavorite,
      );

      emit(
        currentState.copyWith(
          details: currentState.details.copyWith(isFavorite: event.isFavorite),
        ),
      );
    } on Object catch (error) {
      emit(_Failure(error: error));
    }
  }

  Future<void> _onChangeWatchlist(
    _ChangeWatchlist event,
    Emitter<MovieDetailsState> emit,
  ) async {
    try {
      final currentState = state as _Success;

      _movieRepository.updateFavorite(
        movieId: event.movieId,
        isFavorite: event.isWatchlist,
      );

      emit(
        currentState.copyWith(
          details:
              currentState.details.copyWith(isWatchlist: event.isWatchlist),
        ),
      );
    } on Object catch (error) {
      emit(_Failure(error: error));
    }
  }
}
