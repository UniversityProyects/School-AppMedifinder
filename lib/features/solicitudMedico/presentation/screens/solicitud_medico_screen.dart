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
      ),
      body: solicitudMedicoState.estaCargando
          ? const FullScreenLoader()
          : _SolicitudMedicoView(
              listaSolicitudes: solicitudMedicoState.listaSolicitudes,
              ref: ref, // Pasa el ref aquí
            ),
    );
  }
}

class _SolicitudMedicoView extends StatelessWidget {
  final List<SolicutudMedico> listaSolicitudes;
  final WidgetRef ref; // Agrega ref aquí

  const _SolicitudMedicoView(
      {super.key, required this.listaSolicitudes, required this.ref});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: listaSolicitudes.map((solicitud) {
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${solicitud.nombre} ${solicitud.apellido}',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text('País: ${solicitud.pais}'),
                  Text('Teléfono: ${solicitud.telefono}'),
                  Text('Estatus: ${solicitud.estatus}'),
                  Text(
                      'Fecha de Registro: ${solicitud.fechaRegistro.toString()}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => _showModal(context, solicitud),
                    child: const Text('Autorizar'),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showModal(BuildContext context, SolicutudMedico solicitud) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('${solicitud.nombre} ${solicitud.apellido}'),
          content: Container(
            width: double.maxFinite, // Asegura que ocupe todo el ancho
            constraints: BoxConstraints(
              maxHeight: 400,
            ),
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
                  Text(
                    'Especialidades:',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  ...solicitud.especialidades.map((especialidad) {
                    return _buildSpecialtyField(especialidad);
                  }).toList(),
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
              child: const Text('Autorizar Solicitud'),
              onPressed: () async {
                try {
                  final success = await ref
                      .read(solicitudMedicoProvider.notifier)
                      .confirmarSolicitudMedico(solicitud.id.toString());

                  if (success) {
                    Navigator.of(context).pop(); // Cierra el modal
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
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey),
      ),
      width: double.infinity, // Ocupa el 100% del ancho
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildFieldEspecialidad('Especialidad:', especialidad.especialidad,
              backgroundColor: Colors.blue[50]),
          const SizedBox(height: 2),
          _buildFieldEspecialidad('Cédula:', especialidad.numCedula,
              backgroundColor: Colors.blue[50]),
          const SizedBox(height: 2),
          _buildFieldEspecialidad('Honorarios:', '\$${especialidad.honorarios}',
              backgroundColor: Colors.blue[50]),
        ],
      ),
    );
  }

  Widget _buildFieldEspecialidad(String label, String value,
      {Color? backgroundColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2.0), // Margen blanco
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFC0F2E9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFC0F2E9)),
      ),
      width: double.infinity, // Ocupa el 100% del ancho
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 2), // Espacio entre la etiqueta y el valor
          Text(value),
        ],
      ),
    );
  }

  Widget _buildField(String label, String value, {Color? backgroundColor}) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0), // Margen blanco
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: backgroundColor ?? const Color(0xFFC0F2E9),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Color(0xFFC0F2E9)),
      ),
      width: double.infinity, // Ocupa el 100% del ancho
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4), // Espacio entre la etiqueta y el valor
          Text(value),
        ],
      ),
    );
  }
}
