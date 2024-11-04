import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/infrastructure/mappers/tipoSuscripcionDTO.dart';

abstract class TipoSuscripcionRepository {
  Future<List<TipoSuscripcion>> obtenerTiposSuscripciones();

  Future<String> activarTipoSuscripcion(int id);
  Future<String> desactivarTipoSuscripcion(int id);
  Future<String> modificarTipoSuscripcion(
      int id, TipoSuscripcionDTO tipoSuscripcionDTO);
  Future<String> registrarTipoSuscripcion(
      TipoSuscripcionDTO tipoSuscripcionDTO);
}
