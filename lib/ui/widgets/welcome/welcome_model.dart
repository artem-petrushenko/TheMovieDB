import 'package:flutter/material.dart';

import 'package:themoviedb/ui/navigation/main_navigation.dart';

class WelcomeModel extends ChangeNotifier {
  void openAuthScreen(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(MainNavigationRouteNames.authScreen);
  }
}
