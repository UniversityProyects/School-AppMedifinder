import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:medifinder_crm/config/router/app_router.dart';
import 'package:medifinder_crm/features/auth/presentation/screens/login_screen.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import 'package:medifinder_crm/features/suscripcionMedico/presentation/providers/suscripciones_medico_provider.dart';

class SucripcionesMedicoScreen extends ConsumerWidget {
  //Variable que forzosamente tiene que recibir el widget
  final String idMedico;

  const SucripcionesMedicoScreen({super.key, required this.idMedico});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final suscripcionesMedicoState =
        ref.watch(SuscripcionesMedicoProvider(idMedico));
    return Scaffold(
        drawer: SideMenu(scaffoldKey: scaffoldKey),
        appBar: AppBar(
          title: const Text("Suscripción del médico"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        body: suscripcionesMedicoState.estaCargando
            ? const FullScreenLoader()
            : (suscripcionesMedicoState.listaSuscripcionesMedico.isEmpty
                ? const Center(
                    child: Text("Parece que el médico no tiene suscripciones"),
                  )
                : _SuscripcionesMedicoView(
                    suscripcionesMedico:
                        suscripcionesMedicoState.listaSuscripcionesMedico,
                  )));
  }
}

class _SuscripcionesMedicoView extends StatelessWidget {
  //Tenemos que recibir una lista de suscripciones del medico
  final List<SuscripcionesMedico> suscripcionesMedico;
  const _SuscripcionesMedicoView(
      {super.key, required this.suscripcionesMedico});

  @override
  Widget build(BuildContext context) {
    final primerSuscripcion = suscripcionesMedico.first;
    return Column(children: [
      // Header con ícono del usuario, nombre del médico y estrellas de puntuación
      Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16.0),
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            const CircleAvatar(
              radius: 40,
              backgroundColor: Colors.white,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              '${primerSuscripcion.nombreMedico} ${primerSuscripcion.apellidoMedico}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
      const SizedBox(height: 16.0),
      // Lista de comentarios
      Expanded(
        child: ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          itemCount: primerSuscripcion.suscripciones.length,
          itemBuilder: (context, index) {
            final suscripcion = primerSuscripcion.suscripciones[index];
            return GestureDetector(
              onTap: () => context.push(
                  '/detalle-suscripcion-medico/${suscripcion.idSuscripcion}'),
              child: Card(
                elevation: 4,
                margin: const EdgeInsets.only(bottom: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        suscripcion.nombreTipoSuscripcion,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        suscripcion.descripcionTipoSuscripcion,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                        ),
                      ),
                      const Divider(height: 20, color: Colors.grey),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Precio: \$${suscripcion.precioTipoSuscripcion.toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 8,
                            ),
                            decoration: BoxDecoration(
                              color: suscripcion.estatusPago == "PAGADA"
                                  ? Colors.green.withOpacity(0.2)
                                  : Colors.red.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              suscripcion.estatusPago,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: suscripcion.estatusPago == "PAGADA"
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      if (suscripcion.fechaPago != null)
                        Row(
                          children: [
                            const Icon(Icons.calendar_today,
                                size: 16, color: Colors.blue),
                            const SizedBox(width: 4),
                            Text(
                              'Fecha de pago: ${suscripcion.fechaPago}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ]);
  }
}
