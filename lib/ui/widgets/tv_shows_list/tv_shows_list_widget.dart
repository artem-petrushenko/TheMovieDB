import 'package:flutter/material.dart';

import 'package:themoviedb/domain/services/auth_service.dart';

class TVShowsListWidget extends StatelessWidget {
  const TVShowsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => AuthService().logout(),
        child: const Text('Log Out'),
      ),
    );
  }
}
