import 'dart:async';

import 'package:flutter/material.dart';
import 'package:themoviedb/domain/api_client/api_client.dart';
import 'package:themoviedb/domain/data_providers/session_data_provider.dart';

class AuthModel extends ChangeNotifier {
  final _sessionDataProvider = SessionDataProvider();
  final _apiClient = ApiClient();
  final loginTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  String? _errorMessage;
  bool _isObscure = true;
  bool _isAuthProgress = false;

  String? get errorMessage => _errorMessage;

  bool get isObscure => _isObscure;

  bool get canStartAuth => !_isAuthProgress;

  bool get isAuthProgress => _isAuthProgress;

  void _toggle() {
    _isObscure = !_isObscure;
  }

  Future<void> auth(BuildContext context) async {

    final login = loginTextController.text;
    final password = passwordTextController.text;
    if (login.isEmpty || password.isEmpty) {
      _errorMessage = 'Enter password and email';
      notifyListeners();
      return;
    }
    _errorMessage = null;
    _isAuthProgress = true;
    notifyListeners();
    String? sessionId;
    try {
      sessionId =
          await _apiClient.auth(username: login, password: password);
    } catch (e) {
      _errorMessage = 'Error';
    }
    _isAuthProgress = false;
    if (_errorMessage != null){
      notifyListeners();
      return;
    }
    if(sessionId == null){
      _errorMessage = 'Error Session';
      notifyListeners();
      return;
    }
    await _sessionDataProvider.setSessionId(sessionId);
    unawaited(Navigator.of(context).pushNamed('/main'));
  }
}

class AuthProvider extends InheritedNotifier {
  final AuthModel model;

  const AuthProvider({
    Key? key,
    required this.model,
    required Widget child,
  }) : super(key: key, notifier: model, child: child);

  static AuthProvider? watch(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AuthProvider>();
  }

  static AuthProvider? read(BuildContext context) {
    final widget =
        context.getElementForInheritedWidgetOfExactType<AuthProvider>()?.widget;
    return widget is AuthProvider ? widget : null;
  }
}
