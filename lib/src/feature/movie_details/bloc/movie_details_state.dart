part of 'movie_details_bloc.dart';

@freezed
class MovieDetailsState with _$MovieDetailsState {
  const factory MovieDetailsState.loading() = _Loading;

  const factory MovieDetailsState.success({
    required final MovieDetailsLocal details,
  }) = _Success;

  const factory MovieDetailsState.failure({required final Object error}) =
      _Failure;
}
