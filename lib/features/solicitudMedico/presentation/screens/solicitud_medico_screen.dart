import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
import 'package:medifinder_crm/features/solicitudMedico/presentation/providers/solicitud_medico_provider.dart';

class SolicitudMedicoScreen extends ConsumerStatefulWidget {
  const SolicitudMedicoScreen({super.key});

  @override
  _SolicitudMedicoScreenState createState() => _SolicitudMedicoScreenState();
}

class _SolicitudMedicoScreenState extends ConsumerState<SolicitudMedicoScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(solicitudMedicoProvider.notifier).obtenerSolicitudes();
    });
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final solicitudMedicoState = ref.watch(solicitudMedicoProvider);

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Solicitudes Médicos"),
        backgroundColor: Colors.teal,
      ),
      body: solicitudMedicoState.estaCargando
          ? const FullScreenLoader()
          : _SolicitudMedicoView(
              listaSolicitudes: solicitudMedicoState.listaSolicitudes,
              ref: ref,
            ),
    );
  }
}

class _SolicitudMedicoView extends StatelessWidget {
  final List<SolicutudMedico> listaSolicitudes;
  final WidgetRef ref;

  const _SolicitudMedicoView(
      {super.key, required this.listaSolicitudes, required this.ref});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
        child: Column(
          children: listaSolicitudes.map((solicitud) {
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8.0),
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${solicitud.nombre} ${solicitud.apellido}',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('País: ${solicitud.pais}'),
                    Text('Teléfono: ${solicitud.telefono}'),
                    Text('Estatus: ${solicitud.estatus}'),
                    Text(
                        'Fecha de Registro: ${solicitud.fechaRegistro.toString()}'),
                    const SizedBox(height: 16),
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                        ),
                        onPressed: () => _showModal(context, solicitud),
                        child: const Text(
                          'Autorizar',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }

  void _showModal(BuildContext context, SolicutudMedico solicitud) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            '${solicitud.nombre} ${solicitud.apellido}',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          content: Container(
            width: double.maxFinite,
            constraints: const BoxConstraints(maxHeight: 400),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildField('Email:', solicitud.email),
                  _buildField('Calle:', solicitud.calle),
                  _buildField('Colonia:', solicitud.colonia),
                  _buildField('Número:', '${solicitud.numero}'),
                  _buildField('Ciudad:', solicitud.ciudad),
                  _buildField('Código Postal:', solicitud.codigoPostal),
                  _buildField('Estatus:', '${solicitud.estatus}'),
                  const SizedBox(height: 10),
                  const Text(
                    'Especialidades:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Column(
                    children: solicitud.especialidades.map((especialidad) {
                      return _buildSpecialtyField(especialidad);
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Cerrar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              child: const Text(
                'Autorizar Solicitud',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () async {
                try {
                  final success = await ref
                      .read(solicitudMedicoProvider.notifier)
                      .confirmarSolicitudMedico(solicitud.id.toString());

                  if (success) {
                    Navigator.of(context).pop();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Solicitud autorizada')),
                    );
                  }
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                        content: Text('Error al autorizar la solicitud: $e')),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  Widget _buildSpecialtyField(especialidad) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal[200]!),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            especialidad.especialidad,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          Text('Cédula: ${especialidad.numCedula}'),
          Text('Honorarios: \$${especialidad.honorarios}'),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.teal[50],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.teal[200]!),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
          const SizedBox(height: 2),
          Text(value),
        ],
      ),
    );
  }
}
