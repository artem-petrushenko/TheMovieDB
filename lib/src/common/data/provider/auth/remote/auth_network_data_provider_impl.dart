import 'package:themoviedb/src/common/data/client/rest_client/rest_client.dart';
import 'package:themoviedb/src/common/data/provider/auth/remote/auth_network_data_provider.dart';

import '../../../../constants/string.dart';

class AuthNetworkDataProviderImpl implements AuthNetworkDataProvider {
  const AuthNetworkDataProviderImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<String> signInWithUsernameAndPassword({
    required String username,
    required String password,
  }) async {
    final token = await _makeToken();
    final validToken = await _validateUser(
      username: username,
      password: password,
      requestToken: token,
    );
    final sessionId = await _makeSession(requestToken: validToken);
    return sessionId;
  }

  Future<String> _makeToken() async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final result = _client.get(
      '/authentication/token/new',
      parser,
      <String, dynamic>{'api_key': apiKey},
    );
    return result;
  }

  Future<String> _validateUser({
    required String username,
    required String password,
    required String requestToken,
  }) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }

    final parameters = <String, dynamic>{
      'username': username,
      'password': password,
      'request_token': requestToken,
    };
    final result = _client.post(
      "/authentication/token/validate_with_login",
      parameters,
      parser,
      <String, dynamic>{'api_key': apiKey},
    );
    return result;
  }

  Future<String> _makeSession({
    required String requestToken,
  }) async {
    String parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final sessionId = jsonMap['session_id'] as String;
      return sessionId;
    }

    final parameters = <String, dynamic>{
      'request_token': requestToken,
    };
    final result = _client.post(
      "/authentication/session/new",
      parameters,
      parser,
      <String, dynamic>{'api_key': apiKey},
    );
    return result;
  }
}
