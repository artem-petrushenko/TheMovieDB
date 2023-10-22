import '../../../../utils/extension/media_type_as_string.dart';

abstract interface class AccountNetworkDataProvider {
  Future<int> getAccountInfo(String sessionId);

  Future<int> markAsFavorite({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  });

  Future<int> markAsWatchlist({
    required int accountId,
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isWatchlist,
  });
}
