import '../entities/administrador.dart';

abstract class AdministradorDatasource {
  Future<List<Administrador>> obtenerAdministradores();
}
