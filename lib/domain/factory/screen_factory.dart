import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/library/widgets/inherited/provider.dart'
    as old_provider;

import 'package:themoviedb/ui/widgets/loader/loader_view_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';
import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_widget.dart';
import 'package:themoviedb/ui/widgets/main_screen_widget/main_screen_model.dart';
import 'package:themoviedb/ui/widgets/main_screen_widget/main_screen_widget.dart';
import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer.dart';
import 'package:themoviedb/ui/widgets/sign_up/sign_up_model.dart';
import 'package:themoviedb/ui/widgets/sign_up/sign_up_widget.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return old_provider.NotifierProvider(
      create: () => AuthModel(),
      child: const AuthWidget(),
    );
  }

  Widget makeSignUp() {
    return old_provider.NotifierProvider(
      create: () => SignUpModel(),
      child: const SignUpWidget(),
    );
  }

  Widget makeMain() {
    return old_provider.NotifierProvider(
      create: () => MainScreenModel(),
      child: const MainScreenWidget(),
    );
  }

  Widget makeMovieDetails(int movieId) {
    return old_provider.NotifierProvider(
      create: () => MovieDetailsModel(movieId: movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }
}
