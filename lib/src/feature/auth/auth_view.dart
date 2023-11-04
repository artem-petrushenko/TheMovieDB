import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themoviedb/src/common/widget/navigation/navigation.dart';

import 'package:themoviedb/src/feature/auth/auth_view_cubit/auth_view_cubit.dart';
import 'package:themoviedb/src/feature/auth/widget/auth_text_form_field.dart';

class AuthDataStorage {
  String login = '';
  String password = '';
}

class AuthView extends StatelessWidget {
  const AuthView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVisible = false;
    return BlocListener<AuthViewCubit, AuthViewState>(
      listener: (BuildContext context, AuthViewState state) {
        state.mapOrNull(
          successAuthState: (state) => Navigation.resetNavigation(context),
          failure: (state) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error.toString())),
          ),
        );
      },
      child: Provider<AuthDataStorage>(
        create: (BuildContext context) => AuthDataStorage(),
        builder: (context, child) {
          return SafeArea(
            child: Scaffold(
              body: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AuthTextFormField(
                        hintText: 'Email',
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (text) =>
                            context.read<AuthDataStorage>().login = text,
                      ),
                      const SizedBox(height: 22.0),
                      AuthTextFormField(
                        hintText: 'Password',
                        obscureText: true,
                        onChanged: (text) =>
                            context.read<AuthDataStorage>().password = text,
                        suffixIcon: IconButton(
                          //TODO: ADD VISIBLE/HIDE
                          onPressed: () {},
                          icon: Icon(
                            isVisible
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                        ),
                        suffixIconColor: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(height: 24.0),
                      const _AuthButtonWidget(),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class _AuthButtonWidget extends StatelessWidget {
  const _AuthButtonWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<AuthViewCubit>();
    final authDataStorage = context.read<AuthDataStorage>();

    return GestureDetector(
      onTap: cubit.canStartAuth
          ? () => cubit.auth(
                login: authDataStorage.login,
                password: authDataStorage.password,
              )
          : null,
      child: Container(
        width: double.infinity,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(vertical: 18.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(8.0),
          ),
          gradient: LinearGradient(
            colors: [
              Color(0xFFD02626),
              Color(0xFF200B0B),
            ],
          ),
        ),
        child: SizedBox(
          height: 20.0,
          child: cubit.state.maybeMap(
            inProgressState: (state) => SizedBox(
              width: 20.0,
              child: CircularProgressIndicator(
                strokeWidth: 2.0,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
            orElse: () => Text(
              'Log In',
              style: GoogleFonts.montserrat(
                fontSize: 16.0,
                fontWeight: FontWeight.w400,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
