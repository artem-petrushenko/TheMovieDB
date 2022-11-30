// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'person_details_movie_credits.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PersonDetailsMovieCredits _$PersonDetailsMovieCreditsFromJson(
        Map<String, dynamic> json) =>
    PersonDetailsMovieCredits(
      cast: (json['cast'] as List<dynamic>)
          .map((e) => Cast.fromJson(e as Map<String, dynamic>))
          .toList(),
      crew: (json['crew'] as List<dynamic>)
          .map((e) => Crew.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PersonDetailsMovieCreditsToJson(
        PersonDetailsMovieCredits instance) =>
    <String, dynamic>{
      'cast': instance.cast.map((e) => e.toJson()).toList(),
      'crew': instance.crew.map((e) => e.toJson()).toList(),
    };

Cast _$CastFromJson(Map<String, dynamic> json) => Cast(
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String,
      overview: json['overview'] as String,
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      posterPath: json['poster_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      voteCount: json['vote_count'] as int,
      character: json['character'] as String,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      creditId: json['credit_id'] as String,
      originalTitle: json['original_title'] as String,
      video: json['video'] as bool,
      releaseDate: parseMovieDateFromString(json['release_date'] as String?),
      title: json['title'] as String,
      adult: json['adult'] as bool,
      order: json['order'] as int,
    );

Map<String, dynamic> _$CastToJson(Cast instance) => <String, dynamic>{
      'id': instance.id,
      'adult': instance.adult,
      'genre_ids': instance.genreIds,
      'backdrop_path': instance.backdropPath,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'character': instance.character,
      'credit_id': instance.creditId,
      'order': instance.order,
    };

Crew _$CrewFromJson(Map<String, dynamic> json) => Crew(
      id: json['id'] as int,
      originalLanguage: json['original_language'] as String,
      job: json['job'] as String,
      overview: json['overview'] as String,
      voteCount: json['vote_count'] as int,
      popularity: (json['popularity'] as num).toDouble(),
      creditId: json['credit_id'] as String,
      backdropPath: json['backdrop_path'] as String?,
      voteAverage: (json['vote_average'] as num).toDouble(),
      genreIds:
          (json['genre_ids'] as List<dynamic>).map((e) => e as int).toList(),
      posterPath: json['poster_path'] as String?,
      originalTitle: json['original_title'] as String,
      video: json['video'] as bool,
      title: json['title'] as String,
      adult: json['adult'] as bool,
      releaseDate: parseMovieDateFromString(json['release_date'] as String?),
      department: json['department'] as String,
    );

Map<String, dynamic> _$CrewToJson(Crew instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'credit_id': instance.creditId,
      'department': instance.department,
      'job': instance.job,
    };
