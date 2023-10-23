import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:themoviedb/src/feature/movie_details/bloc/movie_details_bloc.dart';

abstract class MovieDetailsScope {
  static MovieDetailsBloc of(BuildContext context) {
    return context.read<MovieDetailsBloc>();
  }

  static void changeFavorite(
    BuildContext context,
    int movieId,
    bool isFavorite,
  ) {
    of(context).add(MovieDetailsEvent.changeFavorite(
        movieId: movieId, isFavorite: isFavorite));
  }

  static void changeWatchlist(
    BuildContext context,
    int movieId,
    bool isWatchlist,
  ) {
    of(context).add(MovieDetailsEvent.changeWatchlist(
        movieId: movieId, isWatchlist: isWatchlist));
  }

  static void fetchDetails(BuildContext context, int movieId) {
    of(context).add(MovieDetailsEvent.fetchDetails(movieId: movieId));
  }
}
