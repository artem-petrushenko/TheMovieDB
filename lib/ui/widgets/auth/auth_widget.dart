import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:themoviedb/ui/theme/app_colors.dart';
import 'package:themoviedb/icons.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';

class AuthWidget extends StatelessWidget {
  const AuthWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.read(context)?.model;
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
                      onPressed: () {},
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
                      onPressed: () {},
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
                  controller: model?.loginTextController,
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
                  controller: model?.passwordTextController,
                  // obscureText: model?.isObscure == true ? true : false,
                  decoration: InputDecoration(
                      // suffixIcon: IconButton(
                      //   splashRadius: 24,
                      //   color: AppColors.kIconColor,
                      //   icon: SvgPicture.asset(
                      //       _isObscure == true
                      //           ? AppIcons.invisible
                      //           : AppIcons.visible,
                      //       width: 15.5,
                      //       height: 12.5,
                      //       color: AppColors.kIconColor),
                      //   onPressed: () => _toggle(),
                      // ),
                      hintText: 'Enter your password',
                      hintStyle: Theme.of(context).textTheme.overline),
                  style: Theme.of(context).textTheme.overline),
              const _ErrorMessageWidget()
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
                _AuthButtonWidget(),
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
                        onPressed: () {},
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

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = AuthProvider.watch(context)?.model;
    final onPressed =
        model?.canStartAuth == true ? () => model?.auth(context) : null;
    final child = model?.isAuthProgress == true
        ? const SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(color: AppColors.kTextColor,),
          )
        : Text('Log in', style: Theme.of(context).textTheme.headline4);
    return Container(
      width: double.infinity,
      height: 47,
      decoration: ShapeDecoration(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
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
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(11.0)),
        onPressed: onPressed,
        child: child,
      ),
    );
  }
}

class _ErrorMessageWidget extends StatelessWidget {
  const _ErrorMessageWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final errorMessage = AuthProvider.watch(context)?.model.errorMessage;
    if (errorMessage == null) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: Text(errorMessage, style: const TextStyle(color: Colors.white)),
    );
  }
}
