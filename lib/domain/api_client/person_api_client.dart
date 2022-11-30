import 'package:themoviedb/configuration/configuration.dart';
import 'package:themoviedb/domain/api_client/network_client.dart';
import 'package:themoviedb/domain/entity/person_details.dart';

class PersonApiClient {
  final _networkClient = NetworkClient();

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
        'api_key': Configuration.apiKey,
        'language': locale,
        'append_to_response': 'credits',
      },
    );
    return result;
  }
}
