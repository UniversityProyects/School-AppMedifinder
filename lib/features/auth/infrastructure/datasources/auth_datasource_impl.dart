import 'package:dio/dio.dart';
import 'package:medifinder_crm/config/config.dart';
import 'package:medifinder_crm/features/auth/domain/domain.dart';
import 'package:medifinder_crm/features/auth/infrastructure/infrastructure.dart';

class AuthDatasourceImpl extends AuthDatasource {
  final dio = Dio(BaseOptions(baseUrl: Environment.apiUrl));

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
        throw CustomError('Token incorrecto');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
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
        throw CustomError(e.response?.data ?? 'Credenciales incorrectas');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
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
        throw CustomError('Respuesta inesperada de la API');
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 400) {
        throw CustomError(e.response?.data ?? 'Error de petición');
      }
      if (e.type == DioExceptionType.connectionTimeout) {
        throw CustomError('Revisar conexión a internet');
      }
      throw Exception();
    } catch (e) {
      throw Exception();
    }
  }
}
