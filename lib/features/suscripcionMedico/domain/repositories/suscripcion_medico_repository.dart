import '../entities/suscripcion_medico.dart';
import '../entities/suscripciones_medico.dart';
import '../entities/detalle_suscripcion_medico.dart';

abstract class SuscripcionMedicoRepository {
  Future<List<SuscripcionMedico>> obtenerListadoSuscripcionesMedicos();
  Future<List<SuscripcionesMedico>> obtenerListadoSuscripcionesPorIdMedico(
      String idMedico);
  Future<DetalleSuscripcionMedico> obtenerDetallesSuscripcionPorId(
      String idSuscripcion);
}
