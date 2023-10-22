import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';

import 'package:themoviedb/src/common/data/repository/auth/auth_repository.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  AuthBloc(
    AuthState initialState, {
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(initialState) {
    on<AuthEvent>((event, emit) async {
      switch (event) {
        case AuthCheckStatusEvent():
          await onAuthCheckStatusEvent(event, emit);
        case AuthLogoutEvent():
          await onAuthLogoutEvent(event, emit);
        case AuthLoginEvent():
          await onAuthLoginEvent(event, emit);
      }
    }, transformer: sequential());
    add(AuthCheckStatusEvent());
  }

  Future<void> onAuthCheckStatusEvent(
    AuthCheckStatusEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthInProgressState());
    final newState = await _authRepository.isAuth()
        ? AuthAuthorizedState()
        : AuthUnauthorizedState();
    emit(newState);
  }

  Future<void> onAuthLoginEvent(
    AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthInProgressState());
      await _authRepository.login(
        event.login,
        event.password,
      );

      emit(AuthAuthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }

  Future<void> onAuthLogoutEvent(
    AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      await _authRepository.logout();
      emit(AuthUnauthorizedState());
    } catch (e) {
      emit(AuthFailureState(e));
    }
  }
}
