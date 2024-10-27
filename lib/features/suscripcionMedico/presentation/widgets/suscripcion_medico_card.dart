import 'package:flutter/material.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';

class SuscripcionMedicoCard extends StatelessWidget {
  final SuscripcionMedico suscripcionMedico;

  const SuscripcionMedicoCard({super.key, required this.suscripcionMedico});

  @override
  Widget build(BuildContext context) {
    String obtenerEstatusTexto(String estatus) {
      switch (estatus) {
        case "1":
          return "Nuevo/Sin Validar";
        case "2":
          return "Activo/Validado";
        case "3":
          return "Activo/Pago Realizado";
        case "4":
          return "Inactivo";
        default:
          return "Desconocido";
      }
    }

    Color obtenerColorEstatus(String estatus) {
      switch (estatus) {
        case "1":
          return Colors.orange;
        case "2":
          return Colors.green;
        case "3":
          return Colors.blue;
        case "4":
          return Colors.red;
        default:
          return Colors.grey;
      }
    }

    final estatusTexto = obtenerEstatusTexto(suscripcionMedico.estatus);
    final colorEstatus = obtenerColorEstatus(suscripcionMedico.estatus);

    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  radius: 25,
                  child: Icon(
                    Icons.person,
                    size: 30,
                    color: Colors.blueAccent[700],
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${suscripcionMedico.nombre} ${suscripcionMedico.apellido}',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: colorEstatus.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        estatusTexto,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: colorEstatus,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4,
                    horizontal: 8,
                  ),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    'Suscripciones: ${suscripcionMedico.cantidadSuscripciones}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
