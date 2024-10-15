import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_crm/features/auth/providers/providers.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scaffoldBackgroundColor = Theme.of(context).scaffoldBackgroundColor;
    final textStyles = Theme.of(context).textTheme;

    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
          body: ColorBackground(
              child: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 90),
            // Icon Banner
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                    onPressed: () {
                      if (!context.canPop()) return;
                      context.pop();
                    },
                    icon: const Icon(Icons.arrow_back_rounded,
                        size: 40, color: Colors.white)),
                const Spacer(flex: 1),
                Text('Crear cuenta',
                    style:
                        textStyles.titleLarge?.copyWith(color: Colors.white)),
                const Spacer(flex: 2),
              ],
            ),

            const SizedBox(height: 50),

            Container(
              height: size.height - 180, // 80 los dos sizebox y 100 el ícono
              width: double.infinity,
              decoration: BoxDecoration(
                color: scaffoldBackgroundColor,
                borderRadius:
                    const BorderRadius.only(topLeft: Radius.circular(100)),
              ),
              child: const _RegisterForm(),
            )
          ],
        ),
      ))),
    );
  }
}

class _RegisterForm extends ConsumerWidget {
  const _RegisterForm();

  void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final registerForm = ref.watch(RegisterFormProvider);

    final textStyles = Theme.of(context).textTheme;

    ref.listen(authProvider, (previous, next) {
      if (next.mensajeError.isEmpty) return;
      showSnackBar(context, next.mensajeError);

      if (next.estatusRegistro) {
        context.go('/login'); // Redirige al login
      }
    });

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      child: Column(
        children: [
          const SizedBox(height: 15),
          Text('Nueva cuenta', style: textStyles.titleMedium),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Nombre',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(RegisterFormProvider.notifier).onNombreChange(value),
            errorMessage: registerForm.estaFormularioPosteado
                ? registerForm.nombre.errorMessage
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Apellido',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(RegisterFormProvider.notifier).onApellidoChange(value),
            errorMessage: registerForm.estaFormularioPosteado
                ? registerForm.apellido.errorMessage
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Correo',
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) =>
                ref.read(RegisterFormProvider.notifier).onEmailChange(value),
            errorMessage: registerForm.estaFormularioPosteado
                ? registerForm.email.errorMessage
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Contraseña',
            obscureText: true,
            onChanged: (value) =>
                ref.read(RegisterFormProvider.notifier).onPasswordChange(value),
            errorMessage: registerForm.estaFormularioPosteado
                ? registerForm.contrasena.errorMessage
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextFormField(
            label: 'Repita la contraseña',
            obscureText: true,
            onChanged: (value) => ref
                .read(RegisterFormProvider.notifier)
                .onConfirmPasswordChange(value),
            errorMessage: registerForm.estaFormularioPosteado
                ? ref
                        .read(RegisterFormProvider.notifier)
                        .confirmPasswordErrorMessage ??
                    registerForm.confirmacionContrasena.errorMessage
                : null,
            onFieldSubmitted: (_) =>
                ref.read(RegisterFormProvider.notifier).onFormSubmit(),
          ),
          const SizedBox(height: 10),
          SizedBox(
              width: double.infinity,
              height: 60,
              child: CustomFilledButton(
                text: 'Crear',
                buttonColor: const Color(0xFF14967F),
                isLoading: registerForm.estaPosteado,
                onPressed: registerForm.estaPosteado
                    ? null
                    : () {
                        ref.read(RegisterFormProvider.notifier).onFormSubmit();
                      },
              )),
          // const Spacer(flex: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('¿Ya tienes cuenta?'),
              TextButton(
                  onPressed: () {
                    if (context.canPop()) {
                      return context.pop();
                    }
                    context.go('/login');
                  },
                  child: const Text('Ingresa aquí'))
            ],
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
