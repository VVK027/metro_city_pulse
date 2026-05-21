
import 'package:metro_city_pulse/core/config/environment.dart';
import 'package:metro_city_pulse/core/constants/shared_pref_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

extension SharePrefExtension on SharedPreferences {

  Future<Env> getEnv() async {
    final String? envName = getString(keyEnvironment);
    return Env.getEnvFromName(envName ?? Env.defaultEnv().name);
  }

  Future<bool> setEnv(Env env) async {
    return await setString(keyEnvironment, env.name);
  }

  Future<String?> getSavedLocale() async {
    return getString(localeKey);
  }

  Future<bool> saveLocale(String languageCode) async {
    return await setString(localeKey, languageCode);
  }


  Future<bool> saveAccessToken(String accessToken) async {
    return await setString(keyAccessToken, accessToken);
  }

  Future<String?> getAccessToken() async {
    return getString(keyAccessToken);
  }

  Future<bool> clearAll() {
    return clear();
  }

  // Future<UserEntity?> getUser() async {
  //   final data = await getMap(keyUser);
  //   if(data?.isNotEmpty == true) {
  //     return UserEntity.fromJson(data as Map<String, dynamic>);
  //   } else {
  //     return null;
  //   }
  // }

  // Future<bool> saveUser(UserEntity userEntity) async {
  //   if(userEntity.accessToken != null) {
  //     await saveAccessToken(userEntity.accessToken!);
  //   }
  //   await putMap(keyUser, userEntity.toJson());
  //   return true;
  // }


}