import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:themoviedb/theme/app_colors.dart';

class SignUpWidget extends StatefulWidget {
  const SignUpWidget({Key? key}) : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0.0,
        leading: IconButton(
          splashRadius: 24,
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.kTextColor,
          ),
          onPressed: () {},
        ),
        title: Text('Sign up', style: Theme.of(context).textTheme.headline2),
      ),
      body: const _Body(),
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({
    Key? key,
  }) : super(key: key);

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  final _nameTextController = TextEditingController();
  final _loginTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  bool _isObscure = true;

  void _signInGoogle() {
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _signInApple() {
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _login() {
    Navigator.of(context).pushReplacementNamed('/auth');
  }

  void _createAccount() {
    final name = _nameTextController.text;
    final login = _loginTextController.text;
    final password = _passwordTextController.text;

    if (login == 'admin' && password == 'admin' && name == 'admin') {
      Navigator.of(context).pushReplacementNamed('/main');
    } else {
      log('Not ok');
    }
  }

  void _toggle() {
    _isObscure = !_isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      // physics: const BouncingScrollPhysics(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 23.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 30),
            Text('Sign up with one of following options',
                style: Theme.of(context).textTheme.subtitle1),
            const SizedBox(height: 42),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: _signInApple,
                    child: const Center(
                      child: Icon(Icons.apple_rounded,
                          size: 24, color: AppColors.kIconColor),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _signInGoogle,
                    child: const Center(
                      child: Icon(Icons.facebook_rounded,
                          size: 24, color: AppColors.kIconColor),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 48),
            Text('Name', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 10),
            TextFormField(
                controller: _nameTextController,
                decoration: InputDecoration(
                    hintText: 'Enter your name',
                    hintStyle: Theme.of(context).textTheme.overline),
                style: Theme.of(context).textTheme.overline),
            const SizedBox(height: 30),
            Text('Email', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 10),
            TextFormField(
                controller: _loginTextController,
                decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: Theme.of(context).textTheme.overline),
                style: Theme.of(context).textTheme.overline),
            const SizedBox(height: 22),
            Text('Password', style: Theme.of(context).textTheme.headline4),
            const SizedBox(height: 10),
            TextFormField(
                controller: _passwordTextController,
                obscureText: _isObscure == true ? true : false,
                decoration: InputDecoration(
                    suffixIcon: IconButton(
                      splashRadius: 24,
                      color: AppColors.kIconColor,
                      icon: Icon(_isObscure == true
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined),
                      onPressed: () {
                        setState(() {
                          _toggle();
                        });
                      },
                    ),
                    hintText: 'Enter your password',
                    hintStyle: Theme.of(context).textTheme.overline),
                style: Theme.of(context).textTheme.overline),
            const SizedBox(height: 53),
            Container(
              width: double.infinity,
              height: 47,
              decoration: ShapeDecoration(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0)),
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppColors.kSecondGradientColor,
                    AppColors.kFirstGradientColor
                  ],
                ),
              ),
              child: MaterialButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(11.0)),
                onPressed: _createAccount,
                child: Text('Create Account',
                    style: Theme.of(context).textTheme.headline4),
              ),
            ),
            const SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Already have an account?',
                    style: Theme.of(context).textTheme.headline6),
                TextButton(
                  style: TextButton.styleFrom(primary: AppColors.kTextColor),
                  onPressed: _login,
                  child: Text('Login',
                      style: Theme.of(context).textTheme.headline4),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
