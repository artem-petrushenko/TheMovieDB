import 'package:flutter/material.dart';

import 'package:themoviedb/ui/navigation/main_navigation.dart';
import 'package:themoviedb/domain/services/auth_service.dart';

class LoaderViewModel {
  final BuildContext context;
  final _authService = AuthService();

  LoaderViewModel(this.context) {
    asyncInit();
  }

  Future<void> asyncInit() async {
    checkAuth();
  }

  Future<void> checkAuth() async {
    final isAuth = await _authService.isAuth();
    final nextScreen = isAuth
        ? MainNavigationRouteNames.mainScreen
        : MainNavigationRouteNames.authScreen;
    Navigator.of(context).pushReplacementNamed(nextScreen);
  }
}
