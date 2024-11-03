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
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
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
    final comentarioPrimero = comentariosMedico.first;

    return Column(
      children: [
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
                '${comentarioPrimero.nombreMedico} ${comentarioPrimero.apellidoMedico}',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8.0),
              _StarRating(puntuacion: _calcularPuntuacionPromedio()),
              const SizedBox(height: 6.0),
              Text(
                'Calificacion ${_calcularPuntuacionPromedio()}',
                style: const TextStyle(
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 16.0),

        // Lista de comentarios
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
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
                            'Puntuación: ${comentario.puntuacion} / 5',
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.orange,
                            ),
                          ),
                          Text(
                            _formatDate(comentario.fechaPuntuacion
                                .toLocal()
                                .toString()),
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
          ),
        ),
      ],
    );
  }

  // Calcula la puntuación promedio de los comentarios
  double _calcularPuntuacionPromedio() {
    if (comentariosMedico.isEmpty) return 0.0;
    final totalPuntos = comentariosMedico
        .map((comentario) => comentario.puntuacion)
        .reduce((a, b) => a + b);
    return (totalPuntos / comentariosMedico.length).toDouble();
  }
}

// Widget personalizado para mostrar las estrellas de puntuación
class _StarRating extends StatelessWidget {
  final double puntuacion;

  const _StarRating({super.key, required this.puntuacion});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final icon =
            index < puntuacion.round() ? Icons.star : Icons.star_border;
        return Icon(
          icon,
          color: Colors.yellow[600],
          size: 30,
        );
      }),
    );
  }
}
