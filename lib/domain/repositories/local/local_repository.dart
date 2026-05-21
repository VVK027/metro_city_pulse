import 'package:metro_city_pulse/core/config/environment.dart';
abstract class LocalRepository {

  Future<String?> getSavedLocale();

  Future<void> saveLocale(String languageCode);

  Future<bool> isLoggedIn();

  Future<String?> getAccessToken();

  Future<bool> closeDb();

  Future<bool> clearData();

  Future<Env> getEnv();

  Future<bool> setEnv(Env env);


// Future<UserEntity?> getUser();
//
// Future<bool> saveUser(UserEntity userEntity);

}