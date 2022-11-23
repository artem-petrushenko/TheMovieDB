import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/user/user_model.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<UserViewModel>();
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          onPressed: model.logout,
          child: const Text('Log Out'),
        ),
      ),
    );
  }
}
