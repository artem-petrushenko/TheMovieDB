import 'package:themoviedb/src/common/data/client/secure_storage_dao.dart';

import 'package:themoviedb/src/common/data/provider/session/session_storage.dart';

abstract class _Keys {
  static const sessionId = 'session_id';
  static const accountId = 'account_id';
}

class SessionStorageImpl implements SessionStorage {
  const SessionStorageImpl({
    required SecureStorageDao secureStorageDao,
  }) : _secureStorageDao = secureStorageDao;

  final SecureStorageDao _secureStorageDao;

  @override
  Future<String?> getSessionId() async =>
      await _secureStorageDao.read(_Keys.sessionId);

  @override
  Future<void> setSessionId(String value) async =>
      await _secureStorageDao.write(_Keys.sessionId, value);

  @override
  Future<void> deleteSessionId() async =>
      await _secureStorageDao.delete(_Keys.sessionId);

  @override
  Future<int?> getAccountId() async {
    final id = await _secureStorageDao.read(_Keys.accountId);
    return id != null ? int.tryParse(id) : null;
  }

  @override
  Future<void> setAccountId(int value) async =>
      await _secureStorageDao.write(_Keys.accountId, value.toString());

  @override
  Future<void> deleteAccountId() async =>
      await _secureStorageDao.delete(_Keys.accountId);
}
