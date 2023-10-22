import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/domain/api_client/auth_api_client.dart';
import 'package:themoviedb/src/common/data/provider/session/session_storage.dart';
import 'package:themoviedb/src/common/data/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required SessionStorage sessionStorage,
    required AuthApiClient authApiClient,
    required AccountApiClient accountApiClient,
  })  : _sessionStorage = sessionStorage,
        _accountApiClient = accountApiClient,
        _authApiClient = authApiClient;

  final AuthApiClient _authApiClient;
  final AccountApiClient _accountApiClient;
  final SessionStorage _sessionStorage;

  @override
  Future<bool> isAuth() async {
    final sessionId = await _sessionStorage.getSessionId();
    final isAuth = sessionId != null;
    return isAuth;
  }

  @override
  Future<void> login(String login, String password) async {
    final sessionId = await _authApiClient.auth(
      username: login,
      password: password,
    );
    final accountId = await _accountApiClient.getAccountInfo(sessionId);

    await _sessionStorage.setSessionId(sessionId);
    await _sessionStorage.setAccountId(accountId);
  }

  @override
  Future<void> logout() async {
    await _sessionStorage.deleteSessionId();
    await _sessionStorage.deleteAccountId();
  }
}
