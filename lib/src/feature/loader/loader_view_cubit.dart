import 'dart:async';

import 'package:bloc/bloc.dart';

import '../auth/auth/auth_bloc.dart';

enum LoaderViewCubitState {
  authorized,
  notAuthorized,
  unknown,
}

class LoaderViewCubit extends Cubit<LoaderViewCubitState> {
  final AuthBloc authBloc;
  late final StreamSubscription<AuthState> authBlocSubscription;

  LoaderViewCubit(
    LoaderViewCubitState initialState,
    this.authBloc,
  ) : super(initialState) {
    Future.microtask(() {
      authBloc.add(AuthCheckStatusEvent());
      _onState(authBloc.state);
      authBlocSubscription = authBloc.stream.listen(_onState);
    });
  }

  void _onState(AuthState state) {
    if (state is AuthAuthorizedState) {
      emit(LoaderViewCubitState.authorized);
    } else if (state is AuthUnauthorizedState) {
      emit(LoaderViewCubitState.notAuthorized);
    }
  }

  @override
  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
