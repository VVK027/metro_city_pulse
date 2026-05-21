import 'package:metro_city_pulse/domain/entities/user.dart';

abstract class AuthRepository {
  Future<User> login(String email, String password);
}
