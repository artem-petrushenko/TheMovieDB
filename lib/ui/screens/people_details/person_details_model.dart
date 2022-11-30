import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:themoviedb/domain/entity/person_details.dart';
import 'package:themoviedb/domain/services/auth_service.dart';
import 'package:themoviedb/domain/services/person_service.dart';

import 'package:themoviedb/library/localized_model.dart';

import 'package:themoviedb/domain/api_client/api_client_exception.dart';
import 'package:themoviedb/ui/navigation/main_navigation.dart';

class PersonDetailsPhotoData {
  final String? profilePath;
  final String name;

  PersonDetailsPhotoData({
    this.profilePath,
    required this.name,
  });
}

class PersonDetailsPersonalInformationData {
  final String? birthday;
  final String? deathday;
  final String gender;
  final String? placeOfBirth;
  final String knownForDepartment;
  final List<String> alsoKnownAs;

  PersonDetailsPersonalInformationData({
    this.birthday,
    this.deathday,
    required this.gender,
    this.placeOfBirth,
    required this.knownForDepartment,
    required this.alsoKnownAs,
  });
}

class PersonDetailsBiographyData {
  final String biography;

  PersonDetailsBiographyData({
    required this.biography,
  });
}

class PersonDetailsKnownForData {}

class PersonDetailsSocialNetworkData {
  final String? homepage;

  PersonDetailsSocialNetworkData({
    this.homepage,
  });
}

class PersonDetailsActorCreditsData {
  final int id;
  final String character;
  final String name;
  final String releaseDate;

  PersonDetailsActorCreditsData({
    required this.id,
    required this.character,
    required this.name,
    required this.releaseDate,
  });
}

class PersonDetailsData {
  bool isLoading = true;
  int id = 0;
  PersonDetailsPhotoData photoData = PersonDetailsPhotoData(
    name: '',
  );

  PersonDetailsPersonalInformationData personInformationData =
      PersonDetailsPersonalInformationData(
    gender: '',
    knownForDepartment: '',
    alsoKnownAs: [],
  );

  PersonDetailsBiographyData biographyData =
      PersonDetailsBiographyData(biography: '');

  PersonDetailsKnownForData knownForData = PersonDetailsKnownForData();

  PersonDetailsSocialNetworkData socialNetworkData =
      PersonDetailsSocialNetworkData();

  List<PersonDetailsActorCreditsData> creditsMovieData =
      <PersonDetailsActorCreditsData>[];
}

class PersonDetailsViewModel extends ChangeNotifier {
  final _personService = PersonService();
  final _authService = AuthService();

  final int personId;
  final _localizedStore = LocalizedModelStorage();
  late DateFormat _dateFormat;
  final data = PersonDetailsData();


  PersonDetailsViewModel({required this.personId});

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if (!_localizedStore.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localizedStore.localeTag);
    updateData(null);
    await loadDetails(context);
  }

  void updateData(PersonDetails? details) {
    data.isLoading = details == null;

    if (details == null) {
      notifyListeners();
      return;
    }
    data.id = details.id;

    data.photoData = PersonDetailsPhotoData(
      name: details.name,
      profilePath: details.profilePath,
    );
    data.personInformationData = PersonDetailsPersonalInformationData(
      birthday: details.birthday.toString(),
      deathday: details.deathday != null ? details.deathday.toString() : null,
      placeOfBirth: details.placeOfBirth,
      gender: makeGender(details.gender),
      knownForDepartment: details.knownForDepartment,
      alsoKnownAs: details.alsoKnownAs,
    );
    data.socialNetworkData = PersonDetailsSocialNetworkData(
      homepage: details.homepage,
    );
    data.knownForData = PersonDetailsKnownForData();
    data.biographyData = PersonDetailsBiographyData(
      biography: details.biography,
    );

    data.creditsMovieData = details.credits.cast
        .map(
          (e) => PersonDetailsActorCreditsData(
            id: e.id,
            name: e.title,
            character: e.character,
            releaseDate: e.releaseDate.toString(),
          ),
        )
        .toList();
    notifyListeners();
  }

  String makeGender(int numberGender) {
    final String gender;
    switch (numberGender) {
      case 1:
        gender = 'Female';
        break;
      case 2:
        gender = 'Male';
        break;
      default:
        gender = 'Other';
        break;
    }
    return gender;
  }

  Future<void> loadDetails(BuildContext context) async {
    try {
      final details = await _personService.loadDetails(
        personId: personId,
        locale: _localizedStore.localeTag,
      );
      updateData(details);
    } on ApiClientException catch (e) {
      _handleApiClientException(e, context);
    }
  }

  void _handleApiClientException(
      ApiClientException exception, BuildContext context) {
    switch (exception.type) {
      case ApiClientExceptionType.sessionExpired:
        _authService.logout();
        MainNavigation.resetNavigation(context);
        break;
      default:
        print(exception);
    }
  }

  void openLink(BuildContext context, String link) {}
}
