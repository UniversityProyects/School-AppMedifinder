import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';

abstract class TipoSuscripcionRepository {
  Future<List<TipoSuscripcion>> obtenerTiposSuscripciones();
}
