import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_crm/config/router/app_router.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/suscripcionMedico/presentation/providers/suscripcion_medico_provider.dart';
import 'package:medifinder_crm/features/suscripcionMedico/presentation/widgets/suscripcion_medico_card.dart';

class SuscripcionMedicoScreen extends StatelessWidget {
  const SuscripcionMedicoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Suscripción Medico'),
      ),
      body: const _TipoSuscripcionView(),
    );
  }
}

class _TipoSuscripcionView extends ConsumerStatefulWidget {
  const _TipoSuscripcionView();

  @override
  _TipoSuscripcionViewState createState() => _TipoSuscripcionViewState();
}

class _TipoSuscripcionViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .refresh(suscripcionMedicoProvider.notifier)
          .obtenerListadoSuscripcionesMedicos();
    });
  }

  @override
  Widget build(BuildContext context) {
    final suscripcionesMedicosState = ref.watch(suscripcionMedicoProvider);

    if (suscripcionesMedicosState.estCargando) {
      return const FullScreenLoader();
    }

    final listaSuscripcionMedico =
        suscripcionesMedicosState.listaSuscripcionMedico;

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: listaSuscripcionMedico.length,
      itemBuilder: (context, index) {
        final suscripcion = listaSuscripcionMedico[index];

        return GestureDetector(
          onTap: () => context.push('/suscripciones-medico/${suscripcion.id}'),
          child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SuscripcionMedicoCard(suscripcionMedico: suscripcion)),
        );
      },
    );
  }
}
