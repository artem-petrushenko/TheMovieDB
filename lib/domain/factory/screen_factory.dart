import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/widgets/loader/loader_model.dart';
import 'package:themoviedb/ui/widgets/loader/loader_widget.dart';

import 'package:themoviedb/ui/widgets/auth/auth_model.dart';
import 'package:themoviedb/ui/widgets/auth/auth_screen.dart';

import 'package:themoviedb/ui/widgets/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/widgets/movie_list/movie_list_widget.dart';

import 'package:themoviedb/ui/widgets/movie_trailer/movie_trailer.dart';

import 'package:themoviedb/ui/widgets/news_list/news_list_widget.dart';

import 'package:themoviedb/ui/widgets/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/widgets/movie_details/movie_details_screen.dart';

import 'package:themoviedb/ui/widgets/main_screen/main_screen_widget.dart';

import 'package:themoviedb/ui/widgets/tv_shows_list/tv_shows_list_widget.dart';

class ScreenFactory {
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeAuth() {
    return ChangeNotifierProvider(
      create: (_) => AuthViewModel(),
      child: const AuthScreen(),
    );
  }

  Widget makeMain() {
    return const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(movieId: movieId),
      child: const MovieDetailsScreen(),
    );
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return MovieTrailerWidget(youTubeKey: youTubeKey);
  }

  Widget makeNewsList() {
    return const NewsListWidget();
  }

  Widget makeMoviesList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListWidget(),
    );
  }

  Widget makeTVShowsList() {
    return const TVShowsListWidget();
  }
}
