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
      margin: const EdgeInsets.all(2.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Alinear en el centro
          crossAxisAlignment:
              CrossAxisAlignment.center, // Alinear al centro horizontalmente
          mainAxisSize: MainAxisSize.min, // Limitar tamaño al contenido
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              child: const Icon(
                Icons.person,
                size: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8), // Espacio entre el avatar y el nombre
            Text(
              '${calificacionMedico.nombre} ${calificacionMedico.apellido}',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            _buildEstrellas(calificacionMedico.promedioPuntuacion),
            const SizedBox(height: 2),
            Text(
              calificacionMedico.promedioPuntuacion > 0
                  ? '${calificacionMedico.promedioPuntuacion}'
                  : 'Sin calificación',
            ),
            const SizedBox(height: 4),
            Text(
              calificacionMedico.cantidadComentarios > 0
                  ? 'Comentarios: ${calificacionMedico.cantidadComentarios}'
                  : 'No hay comentarios',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEstrellas(double calificacion) {
    int estrellasLlenas = calificacion.floor();
    bool tieneMediaEstrella = (calificacion - estrellasLlenas) >= 0.5;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
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
