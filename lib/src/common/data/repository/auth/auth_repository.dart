abstract interface class AuthRepository {
  Future<bool> isAuth();

  Future<void> login(String login, String password);

  Future<void> logout();
}
