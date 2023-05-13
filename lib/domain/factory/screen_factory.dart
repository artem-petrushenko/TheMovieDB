import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/ui/screens/loader/loader_view_cubit.dart';
import 'package:themoviedb/ui/screens/loader/loader_screen.dart';

import 'package:themoviedb/ui/screens/auth/auth_view_cubit.dart';
import 'package:themoviedb/ui/screens/auth/auth_screen.dart';

import 'package:themoviedb/ui/screens/movie_list/movie_list_model.dart';
import 'package:themoviedb/ui/screens/movie_list/movie_list_screen.dart';
import 'package:themoviedb/ui/screens/movie_trailer/movie_trailer_model.dart';

import 'package:themoviedb/ui/screens/movie_trailer/movie_trailer_screen.dart';

import 'package:themoviedb/ui/screens/news_list/news_list_widget.dart';

import 'package:themoviedb/ui/screens/movie_details/movie_details_model.dart';
import 'package:themoviedb/ui/screens/movie_details/movie_details_screen.dart';

import 'package:themoviedb/ui/screens/main_screen/main_screen.dart';

import 'package:themoviedb/ui/screens/tv_shows_list/tv_shows_list_widget.dart';

import 'package:themoviedb/ui/screens/user/user_screen.dart';
import 'package:themoviedb/ui/screens/user/user_model.dart';

import 'package:themoviedb/ui/screens/people_details/person_details_screen.dart';
import 'package:themoviedb/ui/screens/people_details/person_details_model.dart';

import 'package:themoviedb/domain/blocs/auth_bloc.dart';

class ScreenFactory {
  AuthBloc? _authBloc;

  Widget makeLoader() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<LoaderViewCubit>(
      create: (_) => LoaderViewCubit(
        LoaderViewCubitState.unknown,
        authBloc,
      ),
      child: const LoaderScreen(),
    );
  }

  Widget makeAuth() {
    final authBloc = _authBloc ?? AuthBloc(AuthCheckStatusInProgressState());
    _authBloc = authBloc;
    return BlocProvider<AuthViewCubit>(
      create: (_) => AuthViewCubit(
        AuthViewCubitFormFillInProgressState(),
        authBloc,
      ),
      child: const AuthScreen(),
    );
  }

  Widget makeMain() {
    _authBloc?.close();
    _authBloc = null;
    return const MainScreenWidget();
  }

  Widget makeMovieDetails(int movieId) {
    return ChangeNotifierProvider(
      create: (_) => MovieDetailsViewModel(movieId: movieId),
      child: const MovieDetailsScreen(),
    );
  }

  Widget makeMovieTrailer(String youTubeKey) {
    return ChangeNotifierProvider(
      create: (_) => MovieTrailerViewModel(youTubeKey: youTubeKey),
      child: const MovieTrailerScreen(),
    );
  }

  Widget makeNewsList() {
    return const NewsListWidget();
  }

  Widget makeMoviesList() {
    return ChangeNotifierProvider(
      create: (_) => MovieListViewModel(),
      child: const MovieListScreen(),
    );
  }

  Widget makeTVShowsList() {
    return const TVShowsListWidget();
  }

  Widget makeUser() {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: const UserScreen(),
    );
  }

  Widget makePeopleDetails(int personId) {
    return ChangeNotifierProvider(
      create: (_) => PersonDetailsViewModel(personId: personId),
      child: const PersonDetailsScreen(),
    );
  }
}
