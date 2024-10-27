import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_crm/config/router/app_router_notifier.dart';
import 'package:medifinder_crm/features/auth/auth.dart';
import 'package:medifinder_crm/features/auth/presentation/providers/auth_provider.dart';
import 'package:medifinder_crm/features/home/principal.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/satisfaccionPaciente.dart';

final goRouterProvider = Provider((ref) {
  final goRouteNotifier = ref.read(GoRouterNotifierProvider);

  return GoRouter(
      initialLocation: '/Splash',
      refreshListenable: goRouteNotifier,
      routes: [
        ///* Auth Routes
        GoRoute(
          path: '/splash',
          builder: (context, state) => const CheckAuthStatusScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => const LoginScreen(),
        ),
        GoRoute(
          path: '/register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        //Rutas  de satisfaccionPaciente
        GoRoute(
          path: '/satisfaccionPaciente',
          builder: (context, state) => const SatisfaccionpacienteScreen(),
        ),
        GoRoute(
          path: '/comentarios-medico/:idMedico',
          builder: (context, state) => ComentariosMedicoScreen(
            idMedico: state.pathParameters['idMedico'] ?? 'no-id-medico',
          ),
        )
      ],

      ///! TODO: Bloquear si no se está autenticado de alguna manera
      redirect: (context, state) {
        final rutaDestino = state.fullPath;
        final authStatus = goRouteNotifier.authStatus;

        if (rutaDestino == '/splash' && authStatus == EstatusSesion.revisando)
          return null;

        if (authStatus == EstatusSesion.noAutenticado) {
          if (rutaDestino == '/login' || rutaDestino == '/register')
            return null;

          return '/login';
        }

        if (authStatus == EstatusSesion.autenticado) {
          if (rutaDestino == '/login' ||
              rutaDestino == '/register' ||
              rutaDestino == '/splash') return '/';
        }

        return null;
      });
});
