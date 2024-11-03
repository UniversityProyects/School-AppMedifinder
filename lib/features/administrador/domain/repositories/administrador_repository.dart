import '../entities/administrador.dart';

abstract class AdministradorRepository {
  Future<List<Administrador>> obtenerAdministradores();
}
