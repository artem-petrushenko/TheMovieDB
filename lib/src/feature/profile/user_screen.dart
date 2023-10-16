import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/src/feature/profile/user_model.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _BodyWidget(),
    );
  }
}

class _BodyWidget extends StatelessWidget {
  const _BodyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<UserViewModel>();
    return Center(
      child: ElevatedButton(
        onPressed: () => model.logout(context),
        child: const Text('Log Out'),
      ),
    );
  }
}
