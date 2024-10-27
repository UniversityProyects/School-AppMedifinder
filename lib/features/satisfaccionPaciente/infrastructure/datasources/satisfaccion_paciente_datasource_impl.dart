import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:medifinder_crm/config/config.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/infrastructure/errors/satisfaccion_paciente_errors.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/infrastructure/mappers/mappers.dart';

class SatisfaccionPacienteDatasourceImpl
    extends SatisfaccionPacienteDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<List<CalificacionMedico>> obtenerCalificacionesMedicos() async {
    try {
      final respuesta =
          await dio.get<List>("/CMRMovil/PromedioCalificacionMedico");
      final List<CalificacionMedico> listaCalificacionesMedicos = [];
      for (var comentario in respuesta.data ?? []) {
        listaCalificacionesMedicos
            .add(CalificacionMedicoMapper.JsonToEntity(comentario));
      }

      return listaCalificacionesMedicos;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw ErrorPersonalizado(
            'Error de red: No se pudo establecer conexión con el servidor. Verifica tu conexión a internet.');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ErrorPersonalizado(
            'Error de servidor: No se pudo establecer conexión con el servidor. Verifica tu conexión a internet.');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw ErrorPersonalizado(
            'Error de servidor: El servidor tardó demasiado en responder');
      }
      if (e.response!.statusCode == 500) {
        throw ErrorPersonalizado(
            e.response?.data['mensaje'] ?? 'Credenciales incorrectas');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<ComentarioMedico> obtenerComentarioPorIdCita(String idCita) {
    // TODO: implement obtenerComentarioPorIdCita
    throw UnimplementedError();
  }

  @override
  Future<List<ComentarioMedico>> obtenerComentariosPorIdMedico(
      String idMedico) async {
    try {
      final response =
          await dio.get('/CMRMovil/ListadoComentariosPorMedico/${idMedico}');
      final List<ComentarioMedico> listaComentariosMedico = [];
      for (var comentario in response.data ?? []) {
        listaComentariosMedico
            .add(ComentarioMedicoMapper.JsonToEntity(comentario));
      }

      return listaComentariosMedico;
    } on DioException catch (e) {
      if (e.error is SocketException) {
        throw ErrorPersonalizado(
            'Error de red: No se pudo establecer conexión con el servidor. Verifica tu conexión a internet.');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ErrorPersonalizado(
            'Error de servidor: No se pudo establecer conexión con el servidor. Verifica tu conexión a internet.');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw ErrorPersonalizado(
            'Error de servidor: El servidor tardó demasiado en responder');
      }
      if (e.response!.statusCode == 404) throw MedicoNoEncontrado();
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
