import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_crm/config/router/app_router.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/presentation/providers/providers.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/presentation/widgets/widgets.dart';

class SatisfaccionpacienteScreen extends StatelessWidget {
  const SatisfaccionpacienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Satisfacción Paciente'),
      ),
      body: const _SatisfaccionPacienteView(),
    );
  }
}

class _SatisfaccionPacienteView extends ConsumerStatefulWidget {
  const _SatisfaccionPacienteView();

  @override
  _SatisfaccionPacienteViewState createState() =>
      _SatisfaccionPacienteViewState();
}

class _SatisfaccionPacienteViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .refresh(satisfaccionPacienteProvider.notifier)
          .obtenerCalificacionesMedico();
    });
  }

  @override
  Widget build(BuildContext context) {
    final satisfaccionPacienteState = ref.watch(satisfaccionPacienteProvider);

    if (satisfaccionPacienteState.estaCargando) {
      return const Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: satisfaccionPacienteState.calificacionesMedico.length,
      itemBuilder: (context, index) {
        final calificacion =
            satisfaccionPacienteState.calificacionesMedico[index];

        return GestureDetector(
          onTap: () => context.push('/comentarios-medico/${calificacion.id}'),
          child: CalificacionMedicoCard(
            calificacionMedico: calificacion,
          ),
        );
      },
    );
  }
}
