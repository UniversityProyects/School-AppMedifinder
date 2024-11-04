import '../entities/administrador.dart';

abstract class AdministradorRepository {
  Future<List<Administrador>> obtenerAdministradores();
  Future<bool> activarAdministrador(String id);
  Future<bool> desactivarAdministrador(String id);
}
