import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';

class SatisfaccionPacienteRespositoryImpl
    extends SatisfaccionPacienteRepository {
  //Se necesita recibir un datasource (no debe de ser de la implementacion - SatisfaccionPacienteDatasourceImpl)
  final SatisfaccionPacienteDatasource datasource;

  SatisfaccionPacienteRespositoryImpl({required this.datasource});

  @override
  Future<List<CalificacionMedico>> obtenerCalificacionesMedicos() {
    return datasource.obtenerCalificacionesMedicos();
  }

  @override
  Future<ComentarioMedico> obtenerComentarioPorIdCita(String idCita) {
    return datasource.obtenerComentarioPorIdCita(idCita);
  }

  @override
  Future<List<ComentarioMedico>> obtenerComentariosPorIdMedico(
      String idMedico) {
    return datasource.obtenerComentariosPorIdMedico(idMedico);
  }
}
