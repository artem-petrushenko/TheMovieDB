import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:themoviedb/src/feature/auth/auth/auth_bloc.dart';

import 'package:themoviedb/domain/api_client/api_client_exception.dart';

part 'auth_view_state.dart';

part 'auth_view_cubit.freezed.dart';

class AuthViewCubit extends Cubit<AuthViewState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  AuthViewCubit(AuthViewState initialState, this.authBloc)
      : super(initialState) {
    _onState(authBloc.state);
    authBlocSubscription = authBloc.stream.listen(_onState);
  }

  bool get canStartAuth => state.maybeMap(
        formFillInProgress: (_) => true,
        failure: (_) => true,
        orElse: () => false,
      );

  bool _isValid(String login, String password) =>
      login.isNotEmpty || password.isNotEmpty;

  void auth({
    required String login,
    required String password,
  }) {
    if (!_isValid(login, password)) {
      emit(const _Failure(error: 'Enter email or password'));
      return;
    }
    authBloc.add(AuthLoginEvent(login: login, password: password));
  }

  void _onState(AuthState state) {
    if (state is AuthUnauthorizedState) {
      emit(const _FormFillInProgress());
    } else if (state is AuthAuthorizedState) {
      emit(const _SuccessAuthState());
    } else if (state is AuthFailureState) {
      final message = _mapErrorToMessage(state.error);
      emit(_Failure(error: message));
    } else if (state is AuthInProgressState) {
      emit(const _InProgressState());
    } else if (state is AuthCheckStatusInProgressState) {
      emit(const _InProgressState());
    }
  }

  String _mapErrorToMessage(Object error) {
    if (error is! ApiClientException) {
      return 'Error. Try Again!';
    }
    switch (error.type) {
      case ApiClientExceptionType.network:
        return 'Server is not available';
      case ApiClientExceptionType.auth:
        return 'Incorrect login or password';
      case ApiClientExceptionType.sessionExpired:
      case ApiClientExceptionType.other:
        return 'An error has occurred. Try again';
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
