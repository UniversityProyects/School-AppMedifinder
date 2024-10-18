import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/presentation/providers/providers.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class SatisfaccionpacienteScreen extends StatelessWidget {
  const SatisfaccionpacienteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Satisfacción Paciente'),
      ),
      body: const _SatisfaccionPacienteView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Nuevo producto'),
        icon: const Icon(Icons.add),
        onPressed: () {},
      ),
    );
  }
}

class _SatisfaccionPacienteView extends ConsumerStatefulWidget {
  const _SatisfaccionPacienteView();

  @override
  _SatisfaccionPacienteViewState createState() =>
      _SatisfaccionPacienteViewState();
}

class _SatisfaccionPacienteViewState extends ConsumerState {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .refresh(satisfaccionPacienteProvider.notifier)
          .obtenerCalificacionesMedico();
    });
  }

  @override
  Widget build(BuildContext context) {
    final satisfaccionPacienteState = ref.watch(satisfaccionPacienteProvider);

    if (satisfaccionPacienteState.estaCargando) {
      return const Center(child: CircularProgressIndicator());
    }

    if (satisfaccionPacienteState.calificacionesMedico.isEmpty) {
      return const Center(child: Text('No hay calificaciones disponibles.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: satisfaccionPacienteState.calificacionesMedico.length,
      itemBuilder: (context, index) {
        final calificacion =
            satisfaccionPacienteState.calificacionesMedico[index];

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
                        '${calificacion.nombre} ${calificacion.apellido}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      const SizedBox(height: 8),
                      _buildEstrellas(calificacion.promedioPuntuacion),
                      const SizedBox(height: 4),
                      Text(
                        calificacion.promedioPuntuacion > 0
                            ? '${calificacion.promedioPuntuacion}'
                            : 'Sin calificación',
                      ),
                      const SizedBox(height: 8),
                      Text(
                        calificacion.cantidadComentarios > 0
                            ? 'Comentarios: ${calificacion.cantidadComentarios}'
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
      },
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
