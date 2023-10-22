import 'package:themoviedb/domain/api_client/account_api_client.dart';
import 'package:themoviedb/src/common/data/provider/auth/remote/auth_network_data_provider.dart';
import 'package:themoviedb/src/common/data/provider/session/local/session_storage.dart';
import 'package:themoviedb/src/common/data/repository/auth/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required SessionStorage sessionStorage,
    required AuthNetworkDataProvider authNetworkDataProvider,
    required AccountApiClient accountApiClient,
  })  : _sessionStorage = sessionStorage,
        _accountApiClient = accountApiClient,
        _authNetworkDataProvider = authNetworkDataProvider;

  final AuthNetworkDataProvider _authNetworkDataProvider;
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
    final sessionId =
        await _authNetworkDataProvider.signInWithUsernameAndPassword(
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
