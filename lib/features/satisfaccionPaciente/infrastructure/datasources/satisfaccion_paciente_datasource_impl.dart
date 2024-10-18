import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:medifinder_crm/config/config.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/infrastructure/mappers/calificacion_medico_mapper.dart';

class SatisfaccionPacienteDatasourceImpl
    extends SatisfaccionPacienteDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<List<CalificacionMedico>> obtenerCalificacionesMedicos() async {
    final respuesta =
        await dio.get<List>("/CMRMovil/PromedioCalificacionMedico");
    final List<CalificacionMedico> listaCalificacionesMedicos = [];
    for (var comentario in respuesta.data ?? []) {
      listaCalificacionesMedicos
          .add(CalificacionMedicoMapper.JsonToEntity(comentario));
    }

    return listaCalificacionesMedicos;
  }

  @override
  Future<ComentarioMedico> obtenerComentarioPorIdCita(String idCita) {
    // TODO: implement obtenerComentarioPorIdCita
    throw UnimplementedError();
  }

  @override
  Future<List<ComentarioMedico>> obtenerComentariosPorIdMedico(
      String idMedico) {
    // TODO: implement obtenerComentariosPorIdMedico
    throw UnimplementedError();
  }
}
