import '../entities/comentario_medico.dart';
import '../entities/calificacion_medico.dart';

abstract class SatisfaccionPacienteDatasource {
  Future<List<CalificacionMedico>> obtenerCalificacionesMedicos();
  Future<List<ComentarioMedico>> obtenerComentariosPorIdMedico(String idMedico);
  Future<ComentarioMedico> obtenerComentarioPorIdCita(String idCita);
}