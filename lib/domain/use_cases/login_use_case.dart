import 'package:metro_city_pulse/domain/entities/user.dart';
import 'package:metro_city_pulse/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  Future<User> call(String email, String password) {
    return repository.login(email, password);
  }
}
