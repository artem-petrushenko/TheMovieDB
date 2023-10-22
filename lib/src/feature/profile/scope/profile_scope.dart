import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themoviedb/src/feature/profile/bloc/profile_bloc.dart';

abstract class ProfileScope {
  static ProfileBloc of(BuildContext context) {
    return context.read<ProfileBloc>();
  }

  static void fetchProfile(BuildContext context) {
    of(context).add(const ProfileEvent.fetchProfile());
  }

  static void logOut(BuildContext context) {
    of(context).add(const ProfileEvent.logOut());
  }
}
