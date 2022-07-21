import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themoviedb/theme/app_colors.dart';
import 'package:themoviedb/icons.dart';

class AuthWidget extends StatefulWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  State<AuthWidget> createState() => _AuthWidgetState();
}

class _AuthWidgetState extends State<AuthWidget> {
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
    final login = _loginTextController.text;
    final password = _passwordTextController.text;

    if (login == 'admin' && password == 'admin') {
      log('Ok');
    } else {
      log('Not ok');
    }
    Navigator.of(context).pushReplacementNamed('/main');
  }

  void _createAccount() {
    Navigator.of(context).pushReplacementNamed('/sign_up');
  }

  void _toggle() {
    _isObscure = !_isObscure;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 64,
        elevation: 0,
        titleSpacing: 0.0,
        leading: IconButton(
          splashRadius: 24,
          icon: SvgPicture.asset(AppIcons.arrowLeft,
              width: 14, height: 15, color: AppColors.kTextColor),
          onPressed: () {},
        ),
        title: const Text(
          'Login',
          style: TextStyle(fontWeight: FontWeight.w700, fontSize: 24),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 23.0, vertical: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Log in with one of following options',
                  style: Theme.of(context).textTheme.subtitle1),
              const SizedBox(height: 42),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _signInApple,
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.apple,
                          height: 19.5,
                          width: 19.5,
                          color: AppColors.kIconColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _signInGoogle,
                      child: Center(
                        child: SvgPicture.asset(
                          AppIcons.google,
                          height: 19.5,
                          width: 19.5,
                          color: AppColors.kIconColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 44),
              Text('Email', style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 10),
              TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  controller: _loginTextController,
                  decoration: InputDecoration(
                      hintText: 'Enter your email',
                      hintStyle: Theme.of(context).textTheme.overline),
                  style: Theme.of(context).textTheme.overline),
              const SizedBox(height: 22),
              Text('Password', style: Theme.of(context).textTheme.headline4),
              const SizedBox(height: 10),
              TextFormField(
                  autocorrect: false,
                  enableSuggestions: false,
                  textCapitalization: TextCapitalization.none,
                  textInputAction: TextInputAction.next,
                  controller: _passwordTextController,
                  obscureText: _isObscure == true ? true : false,
                  decoration: InputDecoration(
                      suffixIcon: IconButton(
                        splashRadius: 24,
                        color: AppColors.kIconColor,
                        icon: SvgPicture.asset(
                            _isObscure == true
                                ? AppIcons.invisible
                                : AppIcons.visible,
                            width: 15.5,
                            height: 12.5,
                            color: AppColors.kIconColor),
                        onPressed: () {
                          setState(() {
                            _toggle();
                          });
                        },
                      ),
                      hintText: 'Enter your password',
                      hintStyle: Theme.of(context).textTheme.overline),
                  style: Theme.of(context).textTheme.overline),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: AppColors.kBackgroundColor,
        child: Padding(
          padding:
              const EdgeInsets.only(right: 26, left: 26, bottom: 60, top: 16),
          child: SizedBox(
            height: 118,
            child: Column(
              children: [
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
                    onPressed: _login,
                    child: Text('Log in',
                        style: Theme.of(context).textTheme.headline4),
                  ),
                ),
                const SizedBox(height: 50),
                SizedBox(
                  height: 21,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 18,
                            color: AppColors.kSupportTextColor),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          primary: AppColors.kTextColor,
                        ),
                        onPressed: () {
                          _createAccount();
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.kTextColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
