import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/infrastructure/mappers/tipoSuscripcionDTO.dart';

class TipoSuscripcionRepositoryImpl extends TipoSuscripcionRepository {
  final TipoSuscripcionDatasource datasource;

  TipoSuscripcionRepositoryImpl({required this.datasource});

  @override
  Future<List<TipoSuscripcion>> obtenerTiposSuscripciones() {
    return datasource.obtenerTiposSuscripciones();
  }

  @override
  Future<String> activarTipoSuscripcion(int id) {
    return datasource.activarTipoSuscripcion(id);
  }

  @override
  Future<String> desactivarTipoSuscripcion(int id) {
    return datasource.desactivarTipoSuscripcion(id);
  }

  @override
  Future<String> modificarTipoSuscripcion(
      int id, TipoSuscripcionDTO tipoSuscripcionDTO) {
    return datasource.modificarTipoSuscripcion(id, tipoSuscripcionDTO);
  }

  @override
  Future<String> registrarTipoSuscripcion(
      TipoSuscripcionDTO tipoSuscripcionDTO) {
    return datasource.registrarTipoSuscripcion(tipoSuscripcionDTO);
  }
}
