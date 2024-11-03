import 'dart:io';
import 'package:medifinder_crm/config/config.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';
import 'package:dio/dio.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/infrastructure/infrastructure.dart';

class TipoSuscripcionDatasourceImpl extends TipoSuscripcionDatasource {
  //Configuramos la libreria para consultar la api
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<List<TipoSuscripcion>> obtenerTiposSuscripciones() async {
    try {
      final respuesta =
          await dio.get<List>("/CMRMovil/ObtenerTiposSuscripcionActivos");
      final List<TipoSuscripcion> listaTiposSuscripcion = [];
      for (var tipoSuscripcion in respuesta.data ?? []) {
        listaTiposSuscripcion
            .add(TipoSuscripcionMapper.JsonToEntity(tipoSuscripcion));
      }

      return listaTiposSuscripcion;
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
            e.response?.data['mensaje'] ?? 'Ocurrió un error en el servidor');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
