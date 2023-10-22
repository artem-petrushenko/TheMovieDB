part of 'movie_details_bloc.dart';

@freezed
class MovieDetailsEvent with _$MovieDetailsEvent {
  const factory MovieDetailsEvent.fetchDetails({
    required final int movieId,
  }) = _FetchDetails;

  const factory MovieDetailsEvent.changeFavorite({
    required final int movieId,
    required final bool isFavorite,
  }) = _ChangeFavorite;

  const factory MovieDetailsEvent.changeWatchlist({
    required final int movieId,
    required final bool isWatchlist,
  }) = _ChangeWatchlist;
}
