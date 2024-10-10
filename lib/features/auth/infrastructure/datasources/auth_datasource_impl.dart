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
  Future<User> checkAuthStatus(String token) async {
    try {
      //TODO: Aqui va una peticion para verificar el token del usuario
      /*final response = await dio.get("",
          options: Options(headers: {'Authorization': 'Bearer $token'}));

      final user = UserMapper.userJsonToEntity(response.data);
      return user;*/
      return User(
        nombreCompleto: 'Jose Daniel',
        email: '',
        id: 1,
        estatus: "1",
      );
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) {
        throw ErrorPersonalizado('Token incorrecto');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ErrorPersonalizado('Revisar conexión a internet');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw ErrorPersonalizado('El servidor tardó demasiado en responder');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<User> login(String email, String password) async {
    try {
      final response = await dio.post('/Administradores/Login',
          data: {'email': email, 'contrasena': password});

      final user = UserMapper.userJsonToEntity(response.data);
      return user;
    } on DioException catch (e) {
      if (e.response?.statusCode == 401) {
        throw ErrorPersonalizado(
            e.response?.data ?? 'Credenciales incorrectas');
      }
      if (e.error is SocketException) {
        throw ErrorPersonalizado(
            'Error de red: No se pudo establecer conexión con el servidor. Verifica tu conexión a internet.');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ErrorPersonalizado('Revisar conexión a internet');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw ErrorPersonalizado('El servidor tardó demasiado en responder');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }

  @override
  Future<String> register(
      String email, String password, String nombre, String apellido) async {
    try {
      final response = await dio.post('/Administradores/Registrar', data: {
        'nombre': nombre,
        'apellido': apellido,
        'email': email,
        'contrasena': password
      });

      final data = response.data as Map<String, dynamic>;

      if (data.containsKey('message')) {
        return data['message']; // Aquí retornas el mensaje
      } else {
        throw ErrorPersonalizado('Respuesta inesperada de la API');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw ErrorPersonalizado(e.response?.data ?? 'Error de petición');
      }
      if (e.error is SocketException) {
        throw ErrorPersonalizado(
            'Error de red: No se pudo establecer conexión con el servidor. Verifica tu conexión a internet.');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw ErrorPersonalizado('Revisar conexión a internet');
      }
      if (e.type == DioExceptionType.receiveTimeout) {
        throw ErrorPersonalizado('El servidor tardó demasiado en responder');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
