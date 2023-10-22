import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../common/data/repository/auth/auth_repository.dart';

part 'profile_event.dart';

part 'profile_state.dart';

part 'profile_bloc.freezed.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AuthRepository _authRepository;

  ProfileBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(const ProfileState.loading()) {
    on<ProfileEvent>((event, emit) async {
      event.map<Future<void>>(
        fetchProfile: (event) => _onFetchProfile(event, emit),
        logOut: (event) => _onLogOut(event, emit),
      );
    });
  }

  Future<void> _onLogOut(
    _LogOut event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      _authRepository.logout();
    } on Object catch (error) {
      emit(ProfileState.failure(error: error));
    }
  }

  Future<void> _onFetchProfile(
    _FetchProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      emit(const ProfileState.success());
    } on Object catch (error) {
      emit(ProfileState.failure(error: error));
    }
  }
}
