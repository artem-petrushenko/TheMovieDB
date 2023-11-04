part of 'auth_view_cubit.dart';

@freezed
class AuthViewState with _$AuthViewState {
  const factory AuthViewState.formFillInProgress() = _FormFillInProgress;

  const factory AuthViewState.successAuthState() = _SuccessAuthState;

  const factory AuthViewState.inProgressState() = _InProgressState;

  const factory AuthViewState.failure({
    required final Object error,
  }) = _Failure;
}
