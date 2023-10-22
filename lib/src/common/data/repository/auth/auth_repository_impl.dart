import 'package:themoviedb/src/common/data/repository/auth/auth_repository.dart';

import 'package:themoviedb/src/common/data/provider/account/remove/account_network_data_provider.dart';
import 'package:themoviedb/src/common/data/provider/auth/remote/auth_network_data_provider.dart';
import 'package:themoviedb/src/common/data/provider/session/local/session_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  const AuthRepositoryImpl({
    required SessionStorage sessionStorage,
    required AuthNetworkDataProvider authNetworkDataProvider,
    required AccountNetworkDataProvider accountNetworkDataProvider,
  })  : _sessionStorage = sessionStorage,
        _accountNetworkDataProvider = accountNetworkDataProvider,
        _authNetworkDataProvider = authNetworkDataProvider;

  final AuthNetworkDataProvider _authNetworkDataProvider;
  final AccountNetworkDataProvider _accountNetworkDataProvider;
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
    final accountId =
        await _accountNetworkDataProvider.getAccountInfo(sessionId);

    await _sessionStorage.setSessionId(sessionId);
    await _sessionStorage.setAccountId(accountId);
  }

  @override
  Future<void> logout() async {
    await _sessionStorage.deleteSessionId();
    await _sessionStorage.deleteAccountId();
  }
}
