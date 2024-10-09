import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_crm/config/router/app_router_notifier.dart';
import 'package:medifinder_crm/features/auth/auth.dart';
import 'package:medifinder_crm/features/auth/providers/auth_provider.dart';
import 'package:medifinder_crm/features/principal/principal.dart';

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
      ],

      ///! TODO: Bloquear si no se está autenticado de alguna manera
      redirect: (context, state) {
        final rutaDestino = state.fullPath;
        final authStatus = goRouteNotifier.authStatus;

        if (rutaDestino == '/splash' && authStatus == AuthStatus.checking)
          return null;

        if (authStatus == AuthStatus.notAuthenticated) {
          if (rutaDestino == '/login' || rutaDestino == '/register')
            return null;

          return '/login';
        }

        if (authStatus == AuthStatus.authenticated) {
          if (rutaDestino == '/login' ||
              rutaDestino == '/register' ||
              rutaDestino == '/splash') return '/';
        }

        return null;
      });
});
