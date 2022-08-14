import 'package:flutter/material.dart';
import 'package:themoviedb/library/widgets/inherited/provider.dart';

import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen_widget/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_datails_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/sign_up/sign_up_model.dart';
import 'package:themoviedb/ui/widgets/sign_up/sign_up_widget.dart';
import 'package:themoviedb/ui/widgets/welcome/welcome_model.dart';
import 'package:themoviedb/ui/widgets/welcome/welcome_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen_widget/main_screen_model.dart';

abstract class MainNavigationRouteNames {
  static const welcomeScreen = 'welcome';
  static const authScreen = 'auth';
  static const signUpScreen = 'sign_up';
  static const mainScreen = '/';
  static const movieDetailsScreen = '/movie_details';
}

class MainNavigation {
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRouteNames.mainScreen
      : MainNavigationRouteNames.welcomeScreen;
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.welcomeScreen: (context) => NotifierProvider(
        create: () => WelcomeModel(), child: const WelcomeWidget()),
    MainNavigationRouteNames.authScreen: (context) =>
        NotifierProvider(create: () => AuthModel(), child: const AuthWidget()),
    MainNavigationRouteNames.signUpScreen: (context) => NotifierProvider(
        create: () => SignUpModel(), child: const SignUpWidget()),
    MainNavigationRouteNames.mainScreen: (context) => NotifierProvider(
        create: () => MainScreenModel(), child: const MainScreenWidget()),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetailsScreen:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (context) => NotifierProvider(
            create: () =>
                MovieDetailsModel(movieId: movieId)..setupLocale(context),
            child: const MovieDetailsWidget(),
          ),
        );
      default:
        const widget = Text("Navigation Error");
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
