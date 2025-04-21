import 'package:foursquare_ebbok_app/core/failure/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class StatusLocalDatasource {
  Future<bool> getUserLoginStatus();

  Future<void> setUserLoginStatus(bool status);
}

const kSetStatusKey = 'isLoggedIn';

class StatusLocalDatasourceImpl implements StatusLocalDatasource {
  const StatusLocalDatasourceImpl(this._prefs);

  final SharedPreferences _prefs;

  @override
  Future<bool> getUserLoginStatus() async {
    try {
      final isLoggedIn = _prefs.getBool(kSetStatusKey);
      return isLoggedIn ?? false;
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }

  @override
  Future<void> setUserLoginStatus(bool status) async {
    try {
      await _prefs.setBool(kSetStatusKey, status);
    } on APIException {
      rethrow;
    } catch (e) {
      throw APIException(
        message: e.toString(),
        statusCode: 515,
      );
    }
  }
}
