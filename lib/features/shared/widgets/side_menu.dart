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
      default:
        navDrawerIndex = -1; // Opción no seleccionada
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final hasNotch = MediaQuery.of(context).viewPadding.top > 35;
    final textStyles = Theme.of(context).textTheme;

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
            // Agrega más casos para otras rutas si es necesario
            default:
              break;
          }

          // Aquí podrías navegar a cada pantalla del CRM según el índice seleccionado
          widget.scaffoldKey.currentState?.closeDrawer();
        },
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(20, hasNotch ? 0 : 20, 16, 0),
            child: Text('Saludos', style: textStyles.titleMedium),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 16, 10),
            child: Text('Tony Stark', style: textStyles.titleSmall),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.medical_services_outlined),
            label: Text('Home'),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.insert_chart_outlined),
            label: Text('Satisfacción del Paciente'),
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
