part of 'profile_bloc.dart';

@freezed
class ProfileEvent with _$ProfileEvent {
  const factory ProfileEvent.fetchProfile() = _FetchProfile;
  //TODO: THIS IS AUTH BLOC
  const factory ProfileEvent.logOut() = _LogOut;
}
