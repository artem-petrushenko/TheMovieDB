import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/src/common/data/client/rest_client/rest_client.dart';
import 'package:themoviedb/src/common/data/client/secure_storage_dao.dart';
import 'package:themoviedb/src/common/data/provider/auth/remote/auth_network_data_provider_impl.dart';
import 'package:themoviedb/src/common/data/provider/session/local/session_storage_impl.dart';
import 'package:themoviedb/src/common/data/repository/auth/auth_repository_impl.dart';

import 'package:themoviedb/src/feature/movies/widget/movie_list_cubit.dart';

import 'package:themoviedb/src/feature/main/widget/main_screen.dart';

import 'package:themoviedb/src/feature/movies/bloc/movies_bloc.dart';
import 'package:themoviedb/src/feature/profile/bloc/profile_bloc.dart';
import 'package:themoviedb/src/feature/profile/widget/profile_view.dart';

import '../../src/feature/auth/auth/auth_bloc.dart';
import '../../src/feature/auth/auth_screen.dart';
import '../../src/feature/auth/auth_view_cubit.dart';
import '../../src/feature/loader/loader_screen.dart';
import '../../src/feature/loader/loader_view_cubit.dart';
import '../../src/feature/movie_details/bloc/movie_details_bloc.dart';
import '../../src/feature/movie_details/widget/movie_details_view.dart';
import '../../src/feature/movies/widget/movie_list_screen.dart';

class ScreenFactory {
  AuthBloc? _authBloc;

  Widget makeLoader() {
    final authBloc = _authBloc ??
        AuthBloc(
          AuthCheckStatusInProgressState(),
          authRepository: AuthRepositoryImpl(
            sessionStorage:
                SessionStorageImpl(secureStorageDao: SecureStorageDao()),
            authNetworkDataProvider:
                AuthNetworkDataProviderImpl(client: RestClient()),
            accountApiClient: AccountApiClient(),
          ),
        );
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
    final authBloc = _authBloc ??
        AuthBloc(
          AuthCheckStatusInProgressState(),
          authRepository: AuthRepositoryImpl(
            sessionStorage:
                SessionStorageImpl(secureStorageDao: SecureStorageDao()),
            authNetworkDataProvider:
                AuthNetworkDataProviderImpl(client: RestClient()),
            accountApiClient: AccountApiClient(),
          ),
        );
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
    return BlocProvider(
      create: (_) => MovieDetailsBloc()
        ..add(MovieDetailsEvent.fetchDetails(movieId: movieId)),
      child: MovieDetailsView(movieId: movieId),
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

  Widget makeProfile() {
    return BlocProvider(
      create: (BuildContext context) => ProfileBloc(
        authRepository: AuthRepositoryImpl(
          sessionStorage:
              SessionStorageImpl(secureStorageDao: SecureStorageDao()),
          authNetworkDataProvider:
              AuthNetworkDataProviderImpl(client: RestClient()),
          accountApiClient: AccountApiClient(),
        ),
      )..add(const ProfileEvent.fetchProfile()),
      child: const ProfileView(),
    );
  }
}
