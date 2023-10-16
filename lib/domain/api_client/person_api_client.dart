import 'package:themoviedb/src/common/constants/string.dart';
import 'package:themoviedb/domain/entity/person_details.dart';

import '../../src/common/data/client/rest_client/rest_client.dart';

class PersonApiClient {
  final _networkClient = RestClient();

  Future<PersonDetails> personDetails(
    int personId,
    String locale,
  ) async {
    PersonDetails parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PersonDetails.fromJson(jsonMap);
      return response;
    }

    final result = _networkClient.get(
      '/person/$personId',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'language': locale,
        'append_to_response': 'credits',
      },
    );
    return result;
  }
}
