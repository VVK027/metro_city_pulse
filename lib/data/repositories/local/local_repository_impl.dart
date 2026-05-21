import 'package:metro_city_pulse/core/config/environment.dart';
import 'package:metro_city_pulse/data/data_source/local/db_manager.dart';
import 'package:metro_city_pulse/data/data_source/local/shared_pref_extension.dart';
import 'package:metro_city_pulse/domain/repositories/local/local_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalRepositoryImpl extends LocalRepository {

  final DbManager _dbManager;
  final SharedPreferences _sharedPref;

  LocalRepositoryImpl(this._dbManager, this._sharedPref);

  @override
  Future<String?> getSavedLocale() => _sharedPref.getSavedLocale();

  @override
  Future<void> saveLocale(String languageCode) => _sharedPref.saveLocale(languageCode);

  @override
  Future<bool> isLoggedIn() async {
    return await _sharedPref.getAccessToken() != null;
  }

  // @override
  // Future<UserEntity?> getUser() async {
  //   return _sharedPref.getUser();
  // }
  //
  // @override
  // Future<bool> saveUser(UserEntity userEntity) async {
  //   return await _sharedPref.saveUser(userEntity);
  // }

  @override
  Future<bool> closeDb() async {
    await _dbManager.closeDb();
    return true;
  }

  @override
  Future<bool> clearData() async {
    await _sharedPref.clearAll();
    await _dbManager.clearData();
    return true;
  }

  @override
  Future<Env> getEnv() async {
    return _sharedPref.getEnv();
  }

  @override
  Future<bool> setEnv(Env env) async {
    return await _sharedPref.setEnv(env);
  }

  @override
  Future<String?> getAccessToken() async {
    return await _sharedPref.getAccessToken();
  }


}