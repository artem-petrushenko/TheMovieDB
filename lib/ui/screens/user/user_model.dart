import 'package:flutter/material.dart';

import 'package:themoviedb/domain/services/auth_service.dart';

class UserViewModel extends ChangeNotifier {
  Future<void> logout() async => AuthService().logout();
}
