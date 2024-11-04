import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
import 'package:medifinder_crm/features/solicitudMedico/presentation/providers/solicitud_medico_provider.dart';

class SolicitudMedicoScreen extends ConsumerWidget {
  const SolicitudMedicoScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    //Escucha de nuestro provider
    final solicitudMedicoState = ref.watch(solicitudMedicoProvider);

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Salicitudes Médico"),
      ),
      body: solicitudMedicoState.estaCargando
          ? const FullScreenLoader()
          : _SolicitudMedicoView(
              listaSolicitudes: solicitudMedicoState
                  .listaSolicitudes // Pasamos el contexto aquí
              ),
    );
  }
}

//Aqui es donde se puede iterar para mostrar las solicitudes
class _SolicitudMedicoView extends StatelessWidget {
  final List<SolicutudMedico> listaSolicitudes;
  const _SolicitudMedicoView({super.key, required this.listaSolicitudes});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text("Solicitudes"),
      ),
    );
  }
}
