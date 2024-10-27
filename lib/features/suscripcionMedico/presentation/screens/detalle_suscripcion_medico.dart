import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart'; // Importa esta librería para formatear fechas
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import 'package:medifinder_crm/features/suscripcionMedico/presentation/providers/detalle_suscripcion_medico_provider.dart';

class DetalleSuscripcionMedicoScreen extends ConsumerWidget {
  final String idSuscripcion;

  const DetalleSuscripcionMedicoScreen(
      {super.key, required this.idSuscripcion});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final detalleSuscripcionMedicoState =
        ref.watch(DetalleSuscripcionMedicoProvider(idSuscripcion));

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Detalle de Suscripción"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: detalleSuscripcionMedicoState.estaCargando
          ? const FullScreenLoader()
          : detalleSuscripcionMedicoState.detalleSuscripcionMedico == null
              ? const Center(child: Text("No se encontró información"))
              : _DetalleSuscripcionMedicoView(
                  detalleSuscripcion:
                      detalleSuscripcionMedicoState.detalleSuscripcionMedico!),
    );
  }
}

class _DetalleSuscripcionMedicoView extends StatelessWidget {
  final DetalleSuscripcionMedico detalleSuscripcion;

  const _DetalleSuscripcionMedicoView(
      {super.key, required this.detalleSuscripcion});

  String _formatearFecha(DateTime fecha) {
    final formato = DateFormat("dd 'de' MMMM 'del' yyyy"); // Formato deseado
    return formato.format(fecha);
  }

  String _obtenerEstatusMedico(int estatus) {
    switch (estatus) {
      case 1:
        return "Nuevo/Sin Validar";
      case 2:
        return "Activo/Validado";
      case 3:
        return "Activo/Pago Realizado";
      case 4:
        return "Inactivo";
      default:
        return "Desconocido";
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorPrimario =
        Theme.of(context).primaryColor; // Obtiene el color primario del tema

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Encabezado
          _buildHeader(context, colorPrimario),

          const SizedBox(height: 20),

          // Información del Médico
          _buildDoctorInfo(colorPrimario),

          const SizedBox(height: 20),

          // Información de la Suscripción
          _buildSubscriptionInfo(colorPrimario),

          const SizedBox(height: 20),

          // Fechas de la Suscripción
          _buildSubscriptionDates(colorPrimario),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context, Color colorPrimario) {
    return Card(
      elevation: 4,
      color: Colors.blueAccent[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Suscripción",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: colorPrimario), // Color primario
            ),
            Chip(
              label: Text(
                detalleSuscripcion.estatusPago,
                style: const TextStyle(color: Colors.white),
              ),
              backgroundColor: detalleSuscripcion.estatusPago == 'PAGADA'
                  ? Colors.green
                  : Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDoctorInfo(Color colorPrimario) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Información del Médico",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorPrimario), // Color primario
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.person,
                  color: colorPrimario, size: 30), // Color primario
              title: Text(
                  "${detalleSuscripcion.nombreMedico} ${detalleSuscripcion.apellidoMedico}"),
              subtitle: Text(
                  "Estatus Médico: ${_obtenerEstatusMedico(int.parse(detalleSuscripcion.estatusMedico))}"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionInfo(Color colorPrimario) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Información de la Suscripción",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorPrimario), // Color primario
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.subscriptions,
                  color: colorPrimario, size: 30), // Color primario
              title: Text(detalleSuscripcion.nombreTipoSuscripcion),
              subtitle: Text(detalleSuscripcion.descripcionTipoSuscripcion),
            ),
            ListTile(
              leading: Icon(Icons.attach_money,
                  color: colorPrimario, size: 30), // Color primario
              title: Text(
                  "Precio: \$${detalleSuscripcion.precioTipoSuscripcion.toStringAsFixed(2)}"),
              subtitle: Text(
                  "Duración: ${detalleSuscripcion.duracionTipoSuscripcion} meses"),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSubscriptionDates(Color colorPrimario) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Fechas de la Suscripción",
              style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: colorPrimario), // Color primario
            ),
            const SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.calendar_today,
                  color: colorPrimario, size: 30), // Color primario
              title: Text("Fecha de inicio"),
              subtitle: Text(_formatearFecha(detalleSuscripcion.fechaInicio)),
            ),
            ListTile(
              leading: Icon(Icons.calendar_today,
                  color: colorPrimario, size: 30), // Color primario
              title: Text("Fecha de fin"),
              subtitle: Text(_formatearFecha(detalleSuscripcion.fechaFin)),
            ),
            ListTile(
              leading: Icon(Icons.payment,
                  color: colorPrimario, size: 30), // Color primario
              title: Text("Fecha de Pago"),
              subtitle: Text(
                detalleSuscripcion.fechaPago != null
                    ? _formatearFecha(detalleSuscripcion.fechaPago!)
                    : "Pendiente de pago",
                style: TextStyle(
                  color: detalleSuscripcion.fechaPago != null
                      ? Colors.black
                      : Colors.red,
                  fontStyle: detalleSuscripcion.fechaPago == null
                      ? FontStyle.italic
                      : FontStyle.normal,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
