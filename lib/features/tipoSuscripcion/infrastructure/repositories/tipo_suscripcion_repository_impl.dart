import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';

class TipoSuscripcionRepositoryImpl extends TipoSuscripcionRepository {
  final TipoSuscripcionDatasource datasource;

  TipoSuscripcionRepositoryImpl({required this.datasource});

  @override
  Future<List<TipoSuscripcion>> obtenerTiposSuscripciones() {
    return datasource.obtenerTiposSuscripciones();
  }
}
