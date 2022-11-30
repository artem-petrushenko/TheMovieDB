import 'package:themoviedb/domain/api_client/person_api_client.dart';
import 'package:themoviedb/domain/entity/person_details.dart';

class PersonService {
  final _personApiClient = PersonApiClient();

  Future<PersonDetails> loadDetails({
    required int personId,
    required String locale,
  }) async {
    final personDetails =
        await _personApiClient.personDetails(personId, locale);
    return personDetails;
  }
}
