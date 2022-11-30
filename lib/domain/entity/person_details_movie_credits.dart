import 'package:json_annotation/json_annotation.dart';

import 'package:themoviedb/domain/entity/movie_date_parser.dart';

part 'person_details_movie_credits.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PersonDetailsMovieCredits {
  final List<Cast> cast;
  final List<Crew> crew;

  PersonDetailsMovieCredits({
    required this.cast,
    required this.crew,
  });

  factory PersonDetailsMovieCredits.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailsMovieCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$PersonDetailsMovieCreditsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Cast {
  final int id;
  final bool adult;
  final List<int> genreIds;
  final String? backdropPath;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String character;
  final String creditId;
  final int order;

  const Cast({
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.genreIds,
    required this.posterPath,
    required this.voteAverage,
    required this.voteCount,
    required this.character,
    required this.backdropPath,
    required this.popularity,
    required this.creditId,
    required this.originalTitle,
    required this.video,
    required this.releaseDate,
    required this.title,
    required this.adult,
    required this.order,
  });

  factory Cast.fromJson(Map<String, dynamic> json) => _$CastFromJson(json);

  Map<String, dynamic> toJson() => _$CastToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Crew {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? releaseDate;
  final String title;
  final bool video;
  final double voteAverage;
  final int voteCount;
  final String creditId;
  final String department;
  final String job;

  const Crew({
    required this.id,
    required this.originalLanguage,
    required this.job,
    required this.overview,
    required this.voteCount,
    required this.popularity,
    required this.creditId,
    required this.backdropPath,
    required this.voteAverage,
    required this.genreIds,
    required this.posterPath,
    required this.originalTitle,
    required this.video,
    required this.title,
    required this.adult,
    required this.releaseDate,
    required this.department,
  });

  factory Crew.fromJson(Map<String, dynamic> json) => _$CrewFromJson(json);

  Map<String, dynamic> toJson() => _$CrewToJson(this);
}
