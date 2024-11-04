import '../entities/administrador.dart';

abstract class AdministradorDatasource {
  Future<List<Administrador>> obtenerAdministradores();

  Future<bool> activarAdministrador(String id);
  Future<bool> desactivarAdministrador(String id);
}
