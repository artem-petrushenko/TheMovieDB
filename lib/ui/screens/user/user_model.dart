import 'package:flutter/material.dart';

import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class UserViewModel extends ChangeNotifier {
  Future<void> logout(BuildContext context) async {
    AuthService().logout();
    MainNavigation.resetNavigation(context);
  }
}
