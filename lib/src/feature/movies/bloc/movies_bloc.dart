import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter/material.dart';
import 'package:themoviedb/src/common/constants/string.dart';

import 'package:themoviedb/domain/api_client/movie_api_client.dart';

import 'package:themoviedb/domain/entity/movie.dart';
import 'package:themoviedb/domain/entity/popular_movie_response.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MovieListEvent, MovieListState> {
  final _movieApiClient = MovieApiClient();

  MoviesBloc() : super(const MovieListState.initial()) {
    on<MovieListEvent>(
      (event, emit) async {
        switch (event) {
          case MovieListLoadNextPageEvent():
            await onMovieListLoadNextPage(event, emit);
          case MovieListResetEvent():
            await onMovieListResetEvent(event, emit);
          case MovieListSearchEvent():
            await onMovieListSearchEvent(event, emit);
        }
      },
      transformer: sequential(),
    );
  }

  Future<void> onMovieListLoadNextPage(
    MovieListLoadNextPageEvent event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.isSearchMode) {
      final container = await _loadNextPage(
        state.searchMovieContainer,
        (nextPage) async {
          final result = _movieApiClient.searchMovie(
            nextPage,
            event.locale,
            state.searchQuery,
            apiKey,
          );
          return result;
        },
      );
      if (container != null) {
        final newState = state.copyWith(searchMovieContainer: container);
        emit(newState);
      }
    } else {
      final container = await _loadNextPage(
        state.popularMovieContainer,
        (nextPage) async {
          final result = _movieApiClient.popularMovie(
            nextPage,
            event.locale,
            apiKey,
          );
          return result;
        },
      );
      if (container != null) {
        final newState = state.copyWith(popularMovieContainer: container);
        emit(newState);
      }
    }
  }

  Future<MovieListContainer?> _loadNextPage(
    MovieListContainer container,
    Future<PopularMovieResponse> Function(int) loader,
  ) async {
    if (container.isComplete) return null;
    final nextPage = container.currentPage + 1;
    final result = await loader(nextPage);
    final movies = List<Movie>.from(container.movies)..addAll(result.movies);
    final newContainer = container.copyWith(
      movies: movies,
      currentPage: result.page,
      totalPage: result.totalPages,
    );
    return newContainer;
  }

  Future<void> onMovieListResetEvent(
    MovieListResetEvent event,
    Emitter<MovieListState> emit,
  ) async {
    emit(const MovieListState.initial());
  }

  Future<void> onMovieListSearchEvent(
    MovieListSearchEvent event,
    Emitter<MovieListState> emit,
  ) async {
    if (state.searchQuery == event.query) return;
    final newState = state.copyWith(
      searchQuery: event.query,
      searchMovieContainer: const MovieListContainer.initial(),
    );
    emit(newState);
  }
}
