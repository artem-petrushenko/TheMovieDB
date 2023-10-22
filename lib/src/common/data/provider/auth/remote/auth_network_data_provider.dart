abstract interface class AuthNetworkDataProvider {
  Future<String> signInWithUsernameAndPassword({
    required String username,
    required String password,
  });
}
