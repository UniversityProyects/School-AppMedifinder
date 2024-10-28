import 'package:medifinder_crm/features/administrador/domain/domain.dart';

class AdministradorRepositoryImpl extends AdministradorRepository {
  final AdministradorDatasource datasource;

  AdministradorRepositoryImpl({required this.datasource});

  @override
  Future<List<Administrador>> obtenerAdministradores() {
    return datasource.obtenerAdministradores();
  }
}
