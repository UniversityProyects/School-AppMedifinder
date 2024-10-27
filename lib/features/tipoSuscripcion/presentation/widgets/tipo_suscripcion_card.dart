import 'package:flutter/material.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';

class TipoSuscripcionCard extends StatelessWidget {
  final TipoSuscripcion tipoSuscripcion;

  const TipoSuscripcionCard({
    super.key,
    required this.tipoSuscripcion,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Nombre de la suscripción
            Text(
              tipoSuscripcion.nombre,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).primaryColor,
              ),
            ),
            const SizedBox(height: 8),

            // Descripción
            Text(
              tipoSuscripcion.descripcion,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),

            // Precio y duración
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Precio
                Row(
                  children: [
                    const Icon(Icons.attach_money, color: Colors.green),
                    Text(
                      tipoSuscripcion.precio.toString(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
                // Duración
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.blue),
                    const SizedBox(width: 4),
                    Text(
                      '${tipoSuscripcion.duracion} meses',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
