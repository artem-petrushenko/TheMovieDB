abstract class SessionStorage {
  Future<String?> getSessionId();

  Future<void> setSessionId(String value);

  Future<void> deleteSessionId();

  Future<int?> getAccountId();

  Future<void> setAccountId(int value);

  Future<void> deleteAccountId();
}
