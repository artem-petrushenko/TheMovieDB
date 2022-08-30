import 'package:flutter/material.dart';

import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class TVShowsListWidget extends StatelessWidget {
  const TVShowsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () => SessionDataProvider().setSessionId(null),
        child: const Text('Log Out'),
      ),
    );
  }
}
