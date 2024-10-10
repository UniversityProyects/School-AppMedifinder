import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/auth/domain/domain.dart';
import 'package:medifinder_crm/features/auth/infrastructure/infrastructure.dart';
import 'package:medifinder_crm/features/shared/infrastructure/services/key_value_storage_service.dart';
import 'package:medifinder_crm/features/shared/infrastructure/services/key_value_storage_service_impl.dart';

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final authRepository = AuthRepositoryImpl();
  final keyValueStorageService = KeyValueStorageServiceImpl();

  return AuthNotifier(
    authRepository: authRepository,
    keyValueStorageService: keyValueStorageService,
  );
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository authRepository;
  final KeyValueStorageService keyValueStorageService;

  AuthNotifier({
    required this.authRepository,
    required this.keyValueStorageService,
  }) : super(AuthState()) {
    checkAuthStatus();
  }

  Future<void> loginUser(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 1000));

    try {
      final user = await authRepository.login(email, password);
      _setLoggedUser(user);
    } on ErrorPersonalizado catch (e) {
      logout(e.mensaje);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void registerUser(
      String email, String contrasena, String nombre, String apellido) async {
    try {
      await authRepository.register(email, contrasena, nombre, apellido);
      _setRegisterUser();
    } on ErrorPersonalizado catch (e) {
      logout(e.mensaje);
    } catch (e) {
      logout('Error no controlado');
    }
  }

  void checkAuthStatus() async {
    final token = await keyValueStorageService.getValue<String>('token');

    if (token == null) return logout('');

    try {
      final user = await authRepository.checkAuthStatus(token);
      _setLoggedUser(user);
    } catch (e) {
      logout('');
    }
  }

  void _setLoggedUser(User user) async {
    //TODO: Aqui debo de guardar el token real
    await keyValueStorageService.setKeyValue('token', '123456789');

    state = state.copyWith(
      user: user,
      authStatus: AuthStatus.authenticated,
      errorMessage: '',
    );
  }

  void _setRegisterUser() {
    state = state.copyWith(
      registerStatus: true,
      errorMessage: 'Registro Exitoso',
    );
  }

  Future<void> logout(String? errorMessage) async {
    //TODO: limpiar token

    await keyValueStorageService.removeKey('token');

    state = state.copyWith(
      authStatus: AuthStatus.notAuthenticated,
      user: null,
      errorMessage: errorMessage,
      registerStatus: false,
    );
  }
}

enum AuthStatus { checking, authenticated, notAuthenticated }

class AuthState {
  final AuthStatus authStatus;
  final User? user;
  final String errorMessage;
  final bool registerStatus;

  AuthState({
    this.authStatus = AuthStatus.checking,
    this.user,
    this.errorMessage = '',
    this.registerStatus = false,
  });

  AuthState copyWith(
          {AuthStatus? authStatus,
          User? user,
          String? errorMessage,
          bool? registerStatus}) =>
      AuthState(
        authStatus: authStatus ?? this.authStatus,
        user: user ?? this.user,
        errorMessage: errorMessage ?? this.errorMessage,
        registerStatus: registerStatus ?? this.registerStatus,
      );
}
