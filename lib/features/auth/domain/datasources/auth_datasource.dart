import '../entities/usuario.dart';

abstract class AuthDatasource {
  Future<Usuario> login(String email, String contrasena);
  Future<String> registro(
      String email, String contrasena, String nombre, String apellido);
  Future<Usuario> checarEstatusSesion(String token);
}
