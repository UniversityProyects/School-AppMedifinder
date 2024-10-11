import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/auth/domain/domain.dart';
import 'package:medifinder_crm/features/auth/infrastructure/infrastructure.dart';
import 'package:medifinder_crm/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:medifinder_crm/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, EstadoSesion>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<EstadoSesion> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(EstadoSesion()) {
    checarEstatusSesion();
  }

  Future<void> loginUsuario(String email, String contrasena) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      final usuario = await authRepository.login(email, contrasena);
      _setLogeoUsuario(usuario);
    } on ErrorPersonalizado catch (e) {
      logout(e.mensaje);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registroUsuario(
      String email, String contrasena, String nombre, String apellido) async {
    try {
      await authRepository.registro(email, contrasena, nombre, apellido);
      _setRegistroUsuario();
    } on ErrorPersonalizado catch (e) {
      logout(e.mensaje);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void checarEstatusSesion() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout('');

    try {
      final usuario = await authRepository.checarEstatusSesion(token);
      _setLogeoUsuario(usuario);
    } catch (e) {
      logout('');
    }
  }

  void _setLogeoUsuario(Usuario usuario) async {
    //TODO: Aqui debo de guardar el token real
    await keyValueStorageService.setKeyValue('token', '123456789');

    state = state.copyWith(
      usuario: usuario,
      estatusSesion: EstatusSesion.autenticado,
      mensajeError: '',
    );
  }

  void _setRegistroUsuario() {
    state = state.copyWith(
      estatusRegistro: true,
      mensajeError: 'Registro Exitoso',
    );
  }

  Future<void> logout(String? mensajeError) async {
    //TODO: limpiar token

    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      estatusSesion: EstatusSesion.noAutenticado,
      usuario: null,
      mensajeError: mensajeError,
      estatusRegistro: false,
    );
  }
}

enum EstatusSesion { revisando, autenticado, noAutenticado }

class EstadoSesion {
  final EstatusSesion estatusSesion;
  final Usuario? usuario;
  final String mensajeError;
  final bool estatusRegistro;

  EstadoSesion({
    this.estatusSesion = EstatusSesion.revisando,
    this.usuario,
    this.mensajeError = '',
    this.estatusRegistro = false,
  });

  EstadoSesion copyWith({
    EstatusSesion? estatusSesion,
    Usuario? usuario,
    String? mensajeError,
    bool? estatusRegistro,
  }) =>
      EstadoSesion(
        estatusSesion: estatusSesion ?? this.estatusSesion,
        usuario: usuario ?? this.usuario,
        mensajeError: mensajeError ?? this.mensajeError,
        estatusRegistro: estatusRegistro ?? this.estatusRegistro,
      );
}
