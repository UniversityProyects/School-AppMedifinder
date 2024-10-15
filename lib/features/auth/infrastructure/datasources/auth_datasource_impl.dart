import 'package:dio/dio.dart';
import 'package:medifinder_crm/config/config.dart';
import 'package:medifinder_crm/features/auth/domain/domain.dart';
import 'package:medifinder_crm/features/auth/infrastructure/infrastructure.dart';
import 'dart:io';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(
    baseUrl: Environment.apiUrl,
    connectTimeout: const Duration(seconds: 10),
    receiveTimeout: const Duration(seconds: 10),
  ));

  @override
  Future<Usuario> checarEstatusSesion(String token) async {
    try {
      //TODO: Aqui va una peticion para verificar el token del usuario
      /*final response = await dio.get("",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;*/
      return Usuario(
        nombreCompleto: 'Jose Daniel',
        email: '',
        id: 1,
        estatus: "1",
      );
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
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<Usuario> login(String email, String contrasena) async {
    try {
      final response = await dio.post('/Administradores/Login',
          data: {'email': email, 'contrasena': contrasena});

      final user = UsuarioMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ErrorPersonalizado(e.response?.data['mensaje']);
      }
      if (e.response?.statusCode == 401) {
        throw ErrorPersonalizado(
            e.response?.data['mensaje'] ?? 'Credenciales incorrectas');
      }
      if (e.response?.statusCode == 500) {
        throw ErrorPersonalizado(e.response?.data['mensaje']);
      }
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
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<String> registro(
      String email, String contrasena, String nombre, String apellido) async {
    try {
      final response = await dio.post('/Administradores/Registrar', data: {
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'contrasena': contrasena
      });

      final data = response.data as Map<String, dynamic>;

      return "Administrador registrado correctamente";
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ErrorPersonalizado(e.response?.data['mensaje']);
      }
      if (e.response?.statusCode == 500) {
        throw ErrorPersonalizado(e.response?.data['mensaje']);
      }
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
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
