import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/presentation/widgets/widget.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/presentation/providers/tipo_suscripcion_provider.dart';

class TipoSuscripcionScreen extends StatelessWidget {
  const TipoSuscripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Tipos Suscripción"),
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
      ref.refresh(tipoSuscripcionProvider.notifier).obtenerTiposSuscripciones();
    });
  }

  @override
  Widget build(BuildContext context) {
    final tipoSuscripcionState = ref.watch(tipoSuscripcionProvider);

    if (tipoSuscripcionState.estaCargando) {
      return const FullScreenLoader();
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: tipoSuscripcionState.tiposSuscripcion.length,
      itemBuilder: (context, index) {
        final tipoSuscripcion = tipoSuscripcionState.tiposSuscripcion[index];

        return TipoSuscripcionCard(
          tipoSuscripcion: tipoSuscripcion,
        );
      },
    );
  }
}
