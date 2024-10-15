import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/auth/providers/providers.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class SideMenu extends ConsumerStatefulWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const SideMenu({super.key, required this.scaffoldKey});

  @override
  SideMenuState createState() => SideMenuState();
}

class SideMenuState extends ConsumerState<SideMenu> {
  int navDrawerIndex = 0;

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

          // Sección: Gestión de Doctores
          const NavigationDrawerDestination(
            icon: Icon(Icons.medical_services_outlined),
            label: Text('Gestión de Doctores'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.assignment_outlined),
            label: Text('Validación de Perfiles'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.credit_card_outlined),
            label: Text('Suscripciones y Pagos'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.schedule_outlined),
            label: Text('Agenda de Citas'),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),

          // Sección: Gestión de Pacientes
          const NavigationDrawerDestination(
            icon: Icon(Icons.person_outline),
            label: Text('Gestión de Pacientes'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.history_outlined),
            label: Text('Historial de Citas'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.receipt_long_outlined),
            label: Text('Pagos y Facturación'),
          ),

          const Padding(
            padding: EdgeInsets.fromLTRB(28, 16, 28, 10),
            child: Divider(),
          ),

          // Sección: Reportes y Analítica
          const NavigationDrawerDestination(
            icon: Icon(Icons.analytics_outlined),
            label: Text('Reportes y Análisis'),
          ),
          const NavigationDrawerDestination(
            icon: Icon(Icons.bar_chart_outlined),
            label: Text('Rendimiento de Médicos'),
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
