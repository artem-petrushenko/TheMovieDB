import 'dart:async';
import 'package:flutter/material.dart';

import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class AuthViewModel extends ChangeNotifier {
  final _authServices = AuthService();

  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;

  String? get errorMessage => _errorMessage;

  bool _isAuthProgress = false;

  bool get canStartAuth => !_isAuthProgress;

  bool get isAuthProgress => _isAuthProgress;

  bool _isValid(String login, String password) =>
      login.isNotEmpty || password.isNotEmpty;

  Future<String?> _login(String login, String password) async {
    try {
      await _authServices.login(login, password);
    } on ApiClientException catch (e) {
      switch (e.type) {
        case ApiClientExceptionType.network:
          return 'Server is not available';
        case ApiClientExceptionType.auth:
          return 'Incorrect login or password';
        case ApiClientExceptionType.sessionExpired:
        case ApiClientExceptionType.other:
          return 'An error has occurred. Try again';
      }
    } catch (e) {
      _errorMessage = 'Error. Try Again!';
    }
    return null;
  }

  bool _isObscure = true;

  bool get isObscure => _isObscure;

  void toggle() {
    _isObscure = !_isObscure;
    // notifyListeners();
  }

  Future<void> auth(BuildContext context) async {
    final login = loginTextController.text;
    final password = passwordTextController.text;

    if (!_isValid(login, password)) {
      _updateState('Enter email or password', false);
      return;
    }

    _updateState(null, true);

    _errorMessage = await _login(login, password);
    if (_errorMessage == null) {
      MainNavigation.resetNavigation(context);
    } else {
      _updateState(_errorMessage, false);
    }
  }

  void _updateState(String? errorMessage, bool isAuthProgress) {
    if (_errorMessage == errorMessage && _isAuthProgress == isAuthProgress) {
      return;
    }
    _errorMessage = errorMessage;
    _isAuthProgress = isAuthProgress;
    notifyListeners();
  }
}
