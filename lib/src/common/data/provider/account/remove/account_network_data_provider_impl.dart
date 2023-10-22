import 'package:themoviedb/src/common/data/client/rest_client/rest_client.dart';
import 'package:themoviedb/src/common/data/provider/account/remove/account_network_data_provider.dart';
import 'package:themoviedb/src/common/utils/extension/media_type_as_string.dart';

import '../../../../constants/string.dart';

class AccountNetworkDataProviderImpl implements AccountNetworkDataProvider {
  const AccountNetworkDataProviderImpl({
    required RestClient client,
  }) : _client = client;

  final RestClient _client;

  @override
  Future<int> getAccountInfo(
    String sessionId,
  ) async {
    int parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }

    final result = _client.get(
      '/account',
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  @override
  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    int parser(dynamic json) {
      return 1;
    }

    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'favorite': isFavorite,
    };
    final result = _client.post(
      "/account/$accountId/favorite",
      parameters,
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }

  @override
  Future<int> markAsWatchlist({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isWatchlist,
  }) async {
    int parser(dynamic json) {
      return 1;
    }

    final parameters = <String, dynamic>{
      'media_type': mediaType.asString(),
      'media_id': mediaId,
      'watchlist': isWatchlist,
    };
    final result = _client.post(
      "/account/$accountId/watchlist",
      parameters,
      parser,
      <String, dynamic>{
        'api_key': apiKey,
        'session_id': sessionId,
      },
    );
    return result;
  }
}
