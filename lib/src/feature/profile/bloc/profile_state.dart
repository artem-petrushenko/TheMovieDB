part of 'profile_bloc.dart';

@freezed
class ProfileState with _$ProfileState {
  const factory ProfileState.loading() = _Loading;

  const factory ProfileState.success() = _Success;

  const factory ProfileState.failure({
    required final Object error,
  }) = _Failure;
}
