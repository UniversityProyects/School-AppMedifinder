import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
import 'package:medifinder_crm/features/solicitudMedico/infrastructure/mappers/solicitud_medico_mapper.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:medifinder_crm/config/config.dart';

//Esta clase extiende de SolicitudMedicoDatasource, que es el archivo que tiene la estructura de como y cuales metodos se implementaram
class SolicitudMedicoDatasourceImpl extends SolicitudMedicoDatasource {
  //Definicion del objeto que se utiliza para hacer las peticiones a la api, ya esta configurado
  //solo basta con mandarlo a llamar
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<bool> confirmarSolicitudMedico(String idSolicitud) async {
    try {
      final response =
          await dio.put('/CMRMovil/ActualizarSolicitudMedico/$idSolicitud');
      if (response.statusCode == 200) {
        return true;
      } else {
        throw Exception(
            'Error al confirmar la solicitud: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error de red: ${e.message}');
      throw Exception('Error de red: ${e.message}');
    } catch (e) {
      print('Error inesperado: $e');
      throw Exception('Error inesperado: $e');
    }
  }

  @override
  Future<SolicutudMedico> obtenerDetallesSolicitudMedico(String idSolicitud) {
    // TODO: implement obtenerDetallesSolicitudMedico
    throw UnimplementedError();
  }

  @override
  Future<bool> rechazarSolicituMedico(String idSolicitud) {
    // TODO: implement rechazarSolicituMedico
    throw UnimplementedError();
  }

  @override
  Future<List<SolicutudMedico>> obtenerSolicitudesMedico() async {
    try {
      final response = await dio.get('/CMRMovil/ObtenerMedicosRegistrados');
      print(
          'Response data: ${response.data}'); // Imprime la respuesta del servidor
      if (response.statusCode == 200) {
        List<dynamic> data = response.data['data'];
        return data
            .map<SolicutudMedico>(
                (item) => SolicutudMedicoMapper.JsonToEntity(item))
            .toList();
      } else {
        throw Exception(
            'Error al obtener la lista de médicos: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error de red: ${e.message}');
      throw Exception('Error de red: ${e.message}');
    } catch (e) {
      print('Error inesperado: $e');
      throw Exception('Error inesperado: $e');
    }
  }
}
