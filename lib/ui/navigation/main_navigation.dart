import 'package:flutter/material.dart';
import 'package:themoviedb/domain/factory/screen_factory.dart';

abstract class MainNavigationRouteNames {
  static const loaderScreen = '/';
  static const authScreen = '/auth';
  static const signUpScreen = 'sign_up';
  static const mainScreen = '/main';
  static const movieDetailsScreen = '/main/movie_details';
  static const movieTrailerScreen = '/main/movie_details/trailer';
}

class MainNavigation {
  static final _screenFactory = ScreenFactory();
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRouteNames.loaderScreen: (_) => _screenFactory.makeLoader(),
    MainNavigationRouteNames.authScreen: (_) => _screenFactory.makeAuth(),
    MainNavigationRouteNames.signUpScreen: (_) => _screenFactory.makeSignUp(),
    MainNavigationRouteNames.mainScreen: (_) => _screenFactory.makeMain(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.movieDetailsScreen:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieDetails(movieId),
        );
      case MainNavigationRouteNames.movieTrailerScreen:
        final arguments = settings.arguments;
        final youTubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieTrailer(youTubeKey),
        );
      default:
        const widget = Text("Navigation Error");
        return MaterialPageRoute(builder: (_) => widget);
    }
  }
}
