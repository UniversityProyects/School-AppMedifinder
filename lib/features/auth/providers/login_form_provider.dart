//Paso 1. crear el state del provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:medifinder_crm/features/auth/providers/auth_provider.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class LoginFormState {
  final bool estaPosteado;
  final bool estaFormularioPosteado;
  final bool esValido;
  final Email email;
  final Password contrasena;

  LoginFormState(
      {this.estaPosteado = false,
      this.estaFormularioPosteado = false,
      this.esValido = false,
      this.email = const Email.pure(),
      this.contrasena = const Password.pure()});

  LoginFormState copyWith(
          {bool? estaPosteado,
          bool? estaFormularioPosteado,
          bool? esValido,
          Email? email,
          Password? contrasena}) =>
      LoginFormState(
          estaPosteado: estaPosteado ?? this.estaPosteado,
          estaFormularioPosteado:
              estaFormularioPosteado ?? this.estaFormularioPosteado,
          esValido: esValido ?? this.esValido,
          email: email ?? this.email,
          contrasena: contrasena ?? this.contrasena);

  @override
  String toString() {
    return '''
      LoginFormState:
        estaPosteado: $estaPosteado
        estaFormularioPosteado: $estaFormularioPosteado
        esValido: $esValido
        email: $email
        contrasena: $contrasena
    ''';
  }
}

//Paso 2. como implementar un notifier
class LoginFormNotifier extends StateNotifier<LoginFormState> {
  final Function(String, String) loginUserCallback;

  LoginFormNotifier({
    required this.loginUserCallback,
  }) : super(LoginFormState());

  onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
        email: newEmail,
        esValido: Formz.validate([newEmail, state.contrasena]));
  }

  onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
        contrasena: newPassword,
        esValido: Formz.validate([newPassword, state.email]));
  }

  onFormSubmit() async {
    _touchEverField();

    if (!state.esValido) return;

    state = state.copyWith(estaPosteado: true);

    await loginUserCallback(state.email.value, state.contrasena.value);

    state = state.copyWith(estaPosteado: false);
  }

  _touchEverField() {
    final email = Email.dirty(state.email.value);
    final contrasena = Password.dirty(state.contrasena.value);

    state = state.copyWith(
        estaFormularioPosteado: true,
        email: email,
        contrasena: contrasena,
        esValido: Formz.validate([email, contrasena]));
  }
}

//paso 3. como consumir el state
final LoginFormProvider =
    StateNotifierProvider.autoDispose<LoginFormNotifier, LoginFormState>((ref) {
  final loginUserCallback = ref.watch(authProvider.notifier).loginUsuario;

  return LoginFormNotifier(loginUserCallback: loginUserCallback);
});
