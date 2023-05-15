import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

import 'package:themoviedb/ui/screens/auth/auth_view_cubit.dart';

class _AuthDataStorage {
  String login = '';
  String password = '';
}

//TODO SNACKBAR TO ERROR MESSAGE

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthViewCubit, AuthViewCubitState>(
      listener: _onAuthViewCubitStateChange,
      child: Provider(
        create: (_) => _AuthDataStorage(),
        child: const Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: 23.0,
              vertical: 30.0,
            ),
            child: _FormWidget(),
          ),
        ),
      ),
    );
  }

  void _onAuthViewCubitStateChange(
    BuildContext context,
    AuthViewCubitState state,
  ) {
    if (state is AuthViewCubitSuccessAuthState) {
      MainNavigation.resetNavigation(context);
    }
  }
}

class _FormWidget extends StatelessWidget {
  const _FormWidget();

  @override
  Widget build(BuildContext context) {
    final authDataStorage = context.read<_AuthDataStorage>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextFormField(
          autocorrect: false,
          enableSuggestions: false,
          textCapitalization: TextCapitalization.none,
          keyboardType: TextInputType.emailAddress,
          textInputAction: TextInputAction.next,
          decoration: const InputDecoration(
            hintText: 'Username',
          ),
          onChanged: (text) => authDataStorage.login = text,
        ),
        const SizedBox(height: 22.0),
        TextFormField(
          autocorrect: false,
          enableSuggestions: false,
          textCapitalization: TextCapitalization.none,
          textInputAction: TextInputAction.next,
          obscureText: true,
          decoration: const InputDecoration(
            hintText: 'Password',
          ),
          onChanged: (text) => authDataStorage.password = text,
        ),
        const _ErrorMessageWidget(),
        const SizedBox(height: 22.0),
        const _AuthButtonWidget(),
      ],
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthViewCubit>();
    final authDataStorage = context.read<_AuthDataStorage>();
    final canStartAuth = cubit.state is AuthViewCubitFormFillInProgressState ||
        cubit.state is AuthViewCubitErrorState;
    final onPressed = canStartAuth
        ? () => cubit.auth(
              login: authDataStorage.login,
              password: authDataStorage.password,
            )
        : null;
    final child = cubit.state is AuthViewCubitAuthInProgressState == true
        ? const SizedBox(
            width: 20.0,
            height: 20.0,
            child: CircularProgressIndicator(),
          )
        : const Text('Log in');

    return ElevatedButton(onPressed: onPressed, child: child);
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = context.select((AuthViewCubit value) {
      final state = value.state;
      return state is AuthViewCubitErrorState ? state.errorMessage : null;
    });
    if (errorMessage == null) return const SizedBox.shrink();
    return Text(errorMessage);
  }
}
