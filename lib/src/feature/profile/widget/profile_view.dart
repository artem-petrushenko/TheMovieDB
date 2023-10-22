import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themoviedb/src/feature/profile/bloc/profile_bloc.dart';
import 'package:themoviedb/src/feature/profile/scope/profile_scope.dart';

import 'package:themoviedb/src/common/widget/navigation/navigation.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProfileBloc>().state;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            onPressed: () async {
              ProfileScope.logOut(context);
              Navigation.resetNavigation(context);
            },
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      body: Center(
        child: state.map(
          loading: (state) => const CircularProgressIndicator(),
          success: (state) => const Text('Success'),
          failure: (state) => const Text('Failure'),
        ),
      ),
    );
  }
}
