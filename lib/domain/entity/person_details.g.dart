// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetails _$PersonDetailsFromJson(Map<String, dynamic> json) =>
    PersonDetails(
      adult: json['adult'] as bool,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      biography: json['biography'] as String,
      birthday: parseMovieDateFromString(json['birthday'] as String?),
      deathday: parseMovieDateFromString(json['deathday'] as String?),
      gender: json['gender'] as int,
      homepage: json['homepage'] as String?,
      id: json['id'] as int,
      imdbId: json['imdb_id'] as String,
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      placeOfBirth: json['place_of_birth'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
      credits: PersonDetailsMovieCredits.fromJson(
          json['credits'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$PersonDetailsToJson(PersonDetails instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'also_known_as': instance.alsoKnownAs,
      'biography': instance.biography,
      'birthday': instance.birthday?.toIso8601String(),
      'deathday': instance.deathday?.toIso8601String(),
      'gender': instance.gender,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'place_of_birth': instance.placeOfBirth,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
      'credits': instance.credits.toJson(),
    };
