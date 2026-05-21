import 'package:metro_city_pulse/data/repositories/base/base_api_repository.dart';
import 'package:metro_city_pulse/domain/entities/user.dart';
import 'package:metro_city_pulse/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl  extends BaseApiRepository implements AuthRepository {
  @override
  Future<User> login(String email, String password) async {
    // TODO: implement login with api
    await Future.delayed(Duration(seconds: 2));
    // Simple fake validation
    if (email == 'test@example.com' && password == '123456') {
      return User(id: '1', email: email);
    } else {
      throw Exception('Invalid credentials');
    }
  }
}
