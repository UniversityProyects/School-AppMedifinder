import 'package:medifinder_crm/features/auth/domain/domain.dart';
import 'package:medifinder_crm/features/auth/infrastructure/infrastructure.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthDatasource datasource;

  AuthRepositoryImpl({AuthDatasource? datasource})
      : datasource = datasource ?? AuthDatasourceImpl();

  @override
  Future<Usuario> checarEstatusSesion(String token) {
    return datasource.checarEstatusSesion(token);
  }

  @override
  Future<Usuario> login(String email, String contrasena) {
    return datasource.login(email, contrasena);
  }

  @override
  Future<String> registro(
      String email, String contrasena, String nombre, String apellido) {
    return datasource.registro(email, contrasena, nombre, apellido);
  }
}
