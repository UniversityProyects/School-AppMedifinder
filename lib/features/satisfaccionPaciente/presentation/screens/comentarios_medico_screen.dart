import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/presentation/providers/providers.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:intl/intl.dart';

class ComentariosMedicoScreen extends ConsumerWidget {
  final String idMedico;

  const ComentariosMedicoScreen({super.key, required this.idMedico});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final comentariosMedicoState =
        ref.watch(ComentariosMedicoProvider(idMedico));

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text('Comentarios Médico'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Flecha de retroceso
          onPressed: () {
            Navigator.pop(context); // Regresar a la pantalla anterior
          },
        ),
      ),
      body: comentariosMedicoState.estaCargando
          ? const FullScreenLoader()
          : (comentariosMedicoState.comentariosMedico.isEmpty
              ? const Center(
                  child: Text("Parece que el médico no tiene calificaciones."),
                )
              : _ComentariosView(
                  comentariosMedico: comentariosMedicoState.comentariosMedico)),
    );
  }
}

class _ComentariosView extends StatelessWidget {
  final List<ComentarioMedico> comentariosMedico;

  const _ComentariosView({super.key, required this.comentariosMedico});

  String _formatDate(String date) {
    final parsedDate = DateTime.parse(date);
    return DateFormat('dd MMMM yyyy, hh:mm a').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: comentariosMedico.length,
      itemBuilder: (context, index) {
        final comentario = comentariosMedico[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10.0),
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.blue.shade100,
                      child: const Icon(
                        Icons.person,
                        size: 30,
                        color: Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    Expanded(
                      child: Text(
                        '${comentario.nombrePaciente} ${comentario.apellidoPaciente}',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0),
                Text(
                  comentario.comentarios,
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Puntuación: ${comentario.puntuacion}/5',
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.orange,
                      ),
                    ),
                    Text(
                      _formatDate(
                          comentario.fechaPuntuacion.toLocal().toString()),
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
