import 'package:medifinder_crm/features/administrador/domain/domain.dart';
import 'package:dio/dio.dart';
import 'dart:io';
import 'package:medifinder_crm/config/config.dart';
import 'package:medifinder_crm/features/administrador/infrastructure/infrastructure.dart';

class AdministradorDatasourceImpl extends AdministradorDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<List<Administrador>> obtenerAdministradores() async {
    try {
      final respuesta = await dio.get<List>("/CMRMovil/ListadoAdministradores");
      final List<Administrador> listaAdministradores = [];
      for (var administrador in respuesta.data ?? []) {
        listaAdministradores
            .add(AdministradorMapper.JsonToEntity(administrador));
      }

      return listaAdministradores;
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
            e.response?.data['mensaje'] ?? 'Error inesperado del servidor');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
