import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/auth/presentation/providers/providers.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:go_router/go_router.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;

  @override
  void initState() {
    super.initState();
    _updateNavDrawerIndex(); // Inicializa el índice del menú
  }

  void _updateNavDrawerIndex() {
    final currentPath =
        GoRouter.of(context).routerDelegate.currentConfiguration.uri.toString();

    switch (currentPath) {
      case '/':
        navDrawerIndex = 0;
        break;
      case '/satisfaccionPaciente':
        navDrawerIndex = 1;
        break;
      case '/tipo-suscripcion':
        navDrawerIndex = 2;
        break;
      case '/suscripcion-medico':
        navDrawerIndex = 3;
        break;
      case '/usuarios':
        navDrawerIndex = 4;
        break;
      case '/solicitud-medico':
        navDrawerIndex = 5;
        break;
      default:
        navDrawerIndex = -1; // Opción no seleccionada
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;
    final estadoSesion = ref.watch(authProvider);

    return NavigationDrawer(
        elevation: 1,
        selectedIndex: navDrawerIndex,
        onDestinationSelected: (value) {
          setState(() {
            navDrawerIndex = value;
          });

          switch (value) {
            case 0: // Satisfacción Pacientes
              context.go('/');
              break;
            case 1: // Satisfacción Pacientes
              context.go('/satisfaccionPaciente');
              break;
            case 2:
              context.go('/tipo-suscripcion');
              break;
            case 3:
              context.go('/suscripcion-medico');
              break;
            case 4:
              context.go('/usuarios');
              break;
            case 5:
              context.go('/solicitud-medico');
              break;
            default:
              break;
          }

          // Aquí podrías navegar a cada pantalla del CRM según el índice seleccionado
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
                /*gradient:
                    LinearGradient(colors: [Colors.teal, Colors.tealAccent])*/
                color: Theme.of(context).primaryColor),
            accountName: Text('${estadoSesion.usuario?.nombreCompleto}'),
            accountEmail: Text('${estadoSesion.usuario?.email}'),
            currentAccountPicture: CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 40,
                color: Theme.of(context).primaryColor,
              ),
            ),
            onDetailsPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Detalles de la cuenta'),
                    content: const Text(
                        'Aquí podrías mostrar más detalles del usuario.'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('Cerrar'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.home_outlined),
            label: Text('Home'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.sentiment_satisfied_alt_outlined),
            label: Text('Satisfacción del Paciente'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.subscriptions_outlined),
            label: Text('Tipos Suscripciones'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.local_hospital_outlined),
            label: Text('Suscripción Médico'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.person_outline),
            label: Text('Usuario'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.assignment),
            label: Text('Solicitud Médico'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),

          // Sección: Opciones Generales
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 20),
            child: CustomFilledButton(
              isLoading: false,
              onPressed: () {
                ref.read(authProvider.notifier).logout('');
              },
              text: 'Cerrar sesión',
            ),
          ),
        ]);
  }
}
