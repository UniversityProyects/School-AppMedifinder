import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
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
  Future<bool> confirmarSolicitudMedico(String idSolicitud) {
    // TODO: implement confirmarSolicitudMedico
    throw UnimplementedError();
  }

  @override
  Future<SolicutudMedico> obtenerDetallesSolicitudMedico(String idSolicitud) {
    // TODO: implement obtenerDetallesSolicitudMedico
    throw UnimplementedError();
  }

  @override
  Future<List<SolicutudMedico>> obtenerSolicitudesMedico() {
    // TODO: implement obtenerSolicitudesMedico
    throw UnimplementedError();
  }

  @override
  Future<bool> rechazarSolicituMedico(String idSolicitud) {
    // TODO: implement rechazarSolicituMedico
    throw UnimplementedError();
  }
}
