import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';

import 'package:themoviedb/src/feature/movies/widget/movie_list_cubit.dart';

import 'package:themoviedb/src/feature/movie_details/movie_details_model.dart';
import 'package:themoviedb/src/feature/movie_details/movie_details_screen.dart';

import 'package:themoviedb/src/feature/main/widget/main_screen.dart';

import 'package:themoviedb/src/feature/movies/bloc/movies_bloc.dart';

import '../../src/feature/auth/auth/auth_bloc.dart';
import '../../src/feature/auth/auth_screen.dart';
import '../../src/feature/auth/auth_view_cubit.dart';
import '../../src/feature/loader/loader_screen.dart';
import '../../src/feature/loader/loader_view_cubit.dart';
import '../../src/feature/movies/widget/movie_list_screen.dart';
import '../../src/feature/profile/user_model.dart';
import '../../src/feature/profile/user_screen.dart';

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

  Widget makeMoviesList() {
    return BlocProvider(
      create: (_) => MovieListCubit(
        movieListBloc: MoviesBloc(),
      ),
      child: const MovieListScreen(),
    );
  }

  Widget makeUser() {
    return ChangeNotifierProvider(
      create: (_) => UserViewModel(),
      child: const UserScreen(),
    );
  }
}
