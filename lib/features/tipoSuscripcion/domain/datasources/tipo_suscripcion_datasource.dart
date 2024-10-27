import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';

abstract class TipoSuscripcionDatasource {
  Future<List<TipoSuscripcion>> obtenerTiposSuscripciones();
}
