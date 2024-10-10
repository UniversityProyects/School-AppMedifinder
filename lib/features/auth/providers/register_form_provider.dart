//Paso 1. crear el state del provider
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:formz/formz.dart';
import 'package:medifinder_crm/features/auth/providers/auth_provider.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class RegisterFormState {
  final bool estaPosteado;
  final bool estaFormularioPosteado;
  final bool esValido;
  final StringInput nombre;
  final StringInput apellido;
  final Email email;
  final Password contrasena;
  final Password confirmacionContrasena;

  RegisterFormState(
      {required this.estaPosteado,
      required this.estaFormularioPosteado,
      required this.esValido,
      required this.nombre,
      required this.apellido,
      required this.email,
      required this.contrasena,
      required this.confirmacionContrasena});

  RegisterFormState copyWith(
          {bool? estaPosteado,
          bool? estaFormularioPosteado,
          bool? esValido,
          StringInput? nombre,
          StringInput? apellido,
          Email? email,
          Password? contrasena,
          Password? confirmacionContrasena}) =>
      RegisterFormState(
          estaPosteado: estaPosteado ?? this.estaPosteado,
          estaFormularioPosteado:
              estaFormularioPosteado ?? this.estaFormularioPosteado,
          esValido: esValido ?? this.esValido,
          nombre: nombre ?? this.nombre,
          apellido: apellido ?? this.apellido,
          email: email ?? this.email,
          contrasena: contrasena ?? this.contrasena,
          confirmacionContrasena:
              confirmacionContrasena ?? this.confirmacionContrasena);

  @override
  String toString() {
    return '''
      RegisterFormState:
        estaPosteado: $estaPosteado
        estaFormularioPosteado: $estaFormularioPosteado
        esValido: $esValido
        nombre: $nombre
        apellido: $apellido
        email: $email
        contrasena: $contrasena
        confirmacionContrasena: $confirmacionContrasena
    ''';
  }
}

//Paso 2. como implementar un notifier
class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  final Function(String, String, String, String) RegisterUserCallback;

  RegisterFormNotifier({required this.RegisterUserCallback})
      : super(RegisterFormState(
            estaPosteado: false,
            estaFormularioPosteado: false,
            esValido: false,
            nombre: const StringInput.pure(),
            apellido: const StringInput.pure(),
            email: const Email.pure(),
            contrasena: const Password.pure(),
            confirmacionContrasena: const Password.pure()));

  void onNombreChange(String value) {
    final newNombre = StringInput.dirty(value);
    state = state.copyWith(
      nombre: newNombre,
      esValido: Formz.validate([
        newNombre,
        state.apellido,
        state.email,
        state.contrasena,
        state.confirmacionContrasena
      ]),
    );
  }

  void onApellidoChange(String value) {
    final newApellido = StringInput.dirty(value);
    state = state.copyWith(
      apellido: newApellido,
      esValido: Formz.validate([
        state.nombre,
        newApellido,
        state.email,
        state.contrasena,
        state.confirmacionContrasena
      ]),
    );
  }

  void onEmailChange(String value) {
    final newEmail = Email.dirty(value);
    state = state.copyWith(
      email: newEmail,
      esValido: Formz.validate([
        state.nombre,
        state.apellido,
        newEmail,
        state.contrasena,
        state.confirmacionContrasena
      ]),
    );
  }

  void onPasswordChange(String value) {
    final newPassword = Password.dirty(value);
    state = state.copyWith(
      contrasena: newPassword,
      esValido: Formz.validate([
        state.nombre,
        state.apellido,
        state.email,
        newPassword,
        state.confirmacionContrasena
      ]),
    );
  }

  void onConfirmPasswordChange(String value) {
    final newConfirmPassword = Password.dirty(value);

    state = state.copyWith(
      confirmacionContrasena: newConfirmPassword,
      esValido: Formz.validate([
        state.nombre,
        state.apellido,
        state.email,
        state.contrasena,
        newConfirmPassword
      ]), // Es válido solo si ambas contraseñas coinciden
    );

    if (state.contrasena.value != state.confirmacionContrasena.value) {
      state = state.copyWith(
        esValido: false,
      );
    }
  }

  String? get confirmPasswordErrorMessage {
    if (state.contrasena.value != state.confirmacionContrasena.value) {
      return 'Las contraseñas no coinciden';
    }
    return null;
  }

  Future<void> onFormSubmit() async {
    _touchEveryField();

    if (state.contrasena.value != state.confirmacionContrasena.value) {
      // Mostrar mensaje de error si las contraseñas no coinciden
      state = state.copyWith(
        esValido: false,
      );
      return;
    }

    if (!state.esValido) return;

    state = state.copyWith(estaPosteado: true);

    await RegisterUserCallback(state.email.value, state.contrasena.value,
        state.nombre.value, state.apellido.value);

    state = state.copyWith(estaPosteado: false);
  }

  void _touchEveryField() {
    final nombre = StringInput.dirty(state.nombre.value);
    final apellido = StringInput.dirty(state.apellido.value);
    final email = Email.dirty(state.email.value);
    final contrasena = Password.dirty(state.contrasena.value);
    final confirmacionContrasena =
        Password.dirty(state.confirmacionContrasena.value);

    state = state.copyWith(
      estaFormularioPosteado: true,
      nombre: nombre,
      apellido: apellido,
      email: email,
      contrasena: contrasena,
      confirmacionContrasena: confirmacionContrasena,
      esValido: Formz.validate([email, contrasena, confirmacionContrasena]),
    );
  }
}

//paso 3. como consumir el state
final RegisterFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
        (ref) {
  final RegisterUserCallback = ref.watch(authProvider.notifier).registerUser;

  return RegisterFormNotifier(RegisterUserCallback: RegisterUserCallback);
});
