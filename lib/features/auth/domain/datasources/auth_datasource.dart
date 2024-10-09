import '../entities/user.dart';

abstract class AuthDatasource {
  Future<User> login(String email, String password);
  Future<String> register(
      String email, String password, String nombre, String apellido);
  Future<User> checkAuthStatus(String token);
}
