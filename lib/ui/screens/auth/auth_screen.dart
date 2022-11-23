import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/auth/auth_model.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.read<AuthViewModel>();
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 23.0,
            vertical: 30.0,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                controller: model.loginTextController,
                decoration: const InputDecoration(
                  hintText: 'Username',
                ),
              ),
              const SizedBox(height: 22.0),
              TextFormField(
                autocorrect: false,
                enableSuggestions: false,
                textCapitalization: TextCapitalization.none,
                textInputAction: TextInputAction.next,
                controller: model.passwordTextController,
                obscureText: model.isObscure == true ? true : false,
                decoration: const InputDecoration(
                  // suffixIcon: IconButton(
                  //   splashRadius: 24.0,
                  //   color: AppColors.kIconColor,
                  //   icon: SvgPicture.asset(
                  //       model?.isObscure == true
                  //           ? AppIcons.invisible
                  //           : AppIcons.visible,
                  //       width: 15.5,
                  //       height: 12.5,
                  //       color: AppColors.kIconColor),
                  //   onPressed: () => model?.toggle(),
                  // ),
                  hintText: 'Password',
                ),
              ),
              const _ErrorMessageWidget(),
              const SizedBox(height: 22.0),
              const _AuthButtonWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = context.watch<AuthViewModel>();
    final onPressed = model.canStartAuth ? () => model.auth(context) : null;
    final child = model.isAuthProgress == true
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
    final errorMessage =
        context.select((AuthViewModel model) => model.errorMessage);
    if (errorMessage == null) return const SizedBox.shrink();
    return Text(errorMessage);
  }
}
