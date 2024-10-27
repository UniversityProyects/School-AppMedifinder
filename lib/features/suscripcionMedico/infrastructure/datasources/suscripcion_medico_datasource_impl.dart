import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import 'dart:io';
import 'package:medifinder_crm/config/config.dart';
import 'package:dio/dio.dart';
import 'package:medifinder_crm/features/suscripcionMedico/infrastructure/mappers/detalle_suscripcion_medico_mapper.dart';
import 'package:medifinder_crm/features/suscripcionMedico/infrastructure/mappers/suscripcion_medico_mapper.dart';
import 'package:medifinder_crm/features/suscripcionMedico/infrastructure/mappers/suscripciones_medico_mapper.dart';

class SuscripcionMedicoDatasourceImpl extends SuscripcionMedicoDatasource {
  //Configuramos la libreria para consultar la api
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<DetalleSuscripcionMedico> obtenerDetallesSuscripcionPorId(
      String idSuscripcion) async {
    //Peticion a la api
    final respuesta =
        await dio.get('/CMRMovil/DetalleSuscripcionMedico/$idSuscripcion');
    //Lista para almacenar los datos
    final DetalleSuscripcionMedico detalleSuscripcionMedico;
    //Iteracion para mapear y guardar los resultados en la lista
    detalleSuscripcionMedico =
        DetalleSuscripcionMedicoMapper.jsonToEntity(respuesta.data.first);

    print(respuesta.data.first);
    //Retorno de la lista
    return detalleSuscripcionMedico;
  }

  @override
  Future<List<SuscripcionMedico>> obtenerListadoSuscripcionesMedicos() async {
    //Peticion a api
    final respuesta = await dio.get('/CMRMovil/ObtenerSuscripcionesMedicos');
    //Lista para almacenar la respuesta
    final List<SuscripcionMedico> listaSuscripcionesMedicos = [];
    //Iteracion para mapear y guardar los resultados en una lista
    for (var suscripcion in respuesta.data ?? []) {
      listaSuscripcionesMedicos
          .add(SuscripcionMedicoMapper.JsonToEntity(suscripcion));
    }
    //Retorno de la lista
    return listaSuscripcionesMedicos;
  }

  @override
  Future<List<SuscripcionesMedico>> obtenerListadoSuscripcionesPorIdMedico(
      String idMedico) async {
    //Peticion a api
    final respuesta =
        await dio.get('/CMRMovil/ListadoSuscripcionesPorMedico/$idMedico');
    //Lista para almacenar el listado de suscripciones por medico
    final List<SuscripcionesMedico> listaSuscripcionesMedico = [];
    //Iteracion para mapear y uardar los resultados en una lista
    for (var suscripcion in respuesta.data ?? []) {
      listaSuscripcionesMedico
          .add(SuscripcionesMedicoMapper.jsonToEntity(suscripcion));
    }
    //Retorno de la lista
    return listaSuscripcionesMedico;
  }
}
