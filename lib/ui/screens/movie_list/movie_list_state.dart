part of 'movie_list_cubit.dart';



class MovieListCubitState {
  final List<MovieListRowData> movies;
  final String localeTag;

  MovieListCubitState({
    required this.movies,
    required this.localeTag,
  });

  MovieListCubitState copyWith({
    List<MovieListRowData>? movies,
    String? localeTag,
  }) {
    return MovieListCubitState(
      movies: movies ?? this.movies,
      localeTag: localeTag ?? this.localeTag,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MovieListCubitState &&
          runtimeType == other.runtimeType &&
          movies == other.movies &&
          localeTag == other.localeTag;

  @override
  int get hashCode =>
      movies.hashCode ^ localeTag.hashCode;
}
