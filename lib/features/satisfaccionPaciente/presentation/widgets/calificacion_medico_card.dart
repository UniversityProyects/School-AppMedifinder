import 'package:flutter/material.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';

class CalificacionMedicoCard extends StatelessWidget {
  final CalificacionMedico calificacionMedico;

  const CalificacionMedicoCard({
    super.key,
    required this.calificacionMedico,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.medical_services,
                color: Theme.of(context).primaryColor,
                size: 40), // Ícono de médico con color primario
            const SizedBox(width: 16), // Espacio entre el ícono y el texto
            Expanded(
              // Se usa Expanded para que el contenido ocupe el resto del espacio
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${calificacionMedico.nombre} ${calificacionMedico.apellido}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildEstrellas(calificacionMedico.promedioPuntuacion),
                  const SizedBox(height: 4),
                  Text(
                    calificacionMedico.promedioPuntuacion > 0
                        ? '${calificacionMedico.promedioPuntuacion}'
                        : 'Sin calificación',
                  ),
                  const SizedBox(height: 8),
                  Text(
                    calificacionMedico.cantidadComentarios > 0
                        ? 'Comentarios: ${calificacionMedico.cantidadComentarios}'
                        : 'No hay comentarios',
                    style: const TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para construir las estrellas según la calificación
  Widget _buildEstrellas(double calificacion) {
    int estrellasLlenas = calificacion.floor();
    bool tieneMediaEstrella = (calificacion - estrellasLlenas) >= 0.5;

    return Row(
      children: List.generate(5, (index) {
        if (index < estrellasLlenas) {
          return const Icon(Icons.star, color: Colors.amber);
        } else if (index == estrellasLlenas && tieneMediaEstrella) {
          return const Icon(Icons.star_half, color: Colors.amber);
        } else {
          return const Icon(Icons.star_border, color: Colors.amber);
        }
      }),
    );
  }
}
