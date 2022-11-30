import 'package:json_annotation/json_annotation.dart';

import 'package:themoviedb/domain/entity/movie_date_parser.dart';
import 'package:themoviedb/domain/entity/person_details_movie_credits.dart';

part 'person_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PersonDetails {
  final bool adult;
  final List<String> alsoKnownAs;
  final String biography;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? birthday;
  @JsonKey(fromJson: parseMovieDateFromString)
  final DateTime? deathday;
  final int gender;
  final String? homepage;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String? placeOfBirth;
  final double popularity;
  final String? profilePath;
  final PersonDetailsMovieCredits credits;

  PersonDetails({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name,
    required this.placeOfBirth,
    required this.popularity,
    required this.profilePath,
    required this.credits,
  });

  factory PersonDetails.fromJson(Map<String, dynamic> json) =>
      _$PersonDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PersonDetailsToJson(this);
}
