import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/shared/shared.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/presentation/widgets/widget.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/presentation/providers/tipo_suscripcion_provider.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/infrastructure/mappers/tipoSuscripcionDTO.dart';

class TipoSuscripcionScreen extends StatelessWidget {
  const TipoSuscripcionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Tipos Suscripción"),
      ),
      body: const _TipoSuscripcionView(),
    );
  }
}

class _TipoSuscripcionView extends ConsumerStatefulWidget {
  const _TipoSuscripcionView();

  @override
  _TipoSuscripcionViewState createState() => _TipoSuscripcionViewState();
}

class _TipoSuscripcionViewState extends ConsumerState<_TipoSuscripcionView> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(tipoSuscripcionProvider.notifier).obtenerTiposSuscripciones();
    });
  }

  Future<void> _toggleTipoSuscripcion(int id, bool esActivo) async {
    try {
      String mensaje;
      if (esActivo) {
        mensaje = await ref
            .read(tipoSuscripcionProvider.notifier)
            .desactivarTipoSuscripcion(id);
      } else {
        mensaje = await ref
            .read(tipoSuscripcionProvider.notifier)
            .activarTipoSuscripcion(id);
      }

      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(mensaje)));
      ref.refresh(tipoSuscripcionProvider.notifier).obtenerTiposSuscripciones();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al cambiar el estado: $e')));
    }
  }

  Future<void> _modificarTipoSuscripcion(
      int id, TipoSuscripcionDTO tipoSuscripcionDTO) async {
    try {
      String mensaje = await ref
          .read(tipoSuscripcionProvider.notifier)
          .modificarTipoSuscripcion(id, tipoSuscripcionDTO);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(mensaje)));
      ref.refresh(tipoSuscripcionProvider.notifier).obtenerTiposSuscripciones();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error al modificar la suscripción: $e')));
    }
  }

  Future<void> _registrarTipoSuscripcion() async {
    final nombreController = TextEditingController();
    final descripcionController = TextEditingController();
    final precioController = TextEditingController();
    final duracionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Añadir Tipo de Suscripción'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: descripcionController,
                  decoration: const InputDecoration(labelText: 'Descripción'),
                ),
                TextField(
                  controller: precioController,
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: duracionController,
                  decoration:
                      const InputDecoration(labelText: 'Duración (meses)'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cerrar el diálogo
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                final nombre = nombreController.text.trim();
                final descripcion = descripcionController.text.trim();
                final precio = double.tryParse(precioController.text);
                final duracion = int.tryParse(duracionController.text);

                // Validar campos
                if (nombre.isEmpty ||
                    descripcion.isEmpty ||
                    precio == null ||
                    precio <= 0 ||
                    duracion == null ||
                    duracion <= 0) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Todos los campos son obligatorios.')),
                  );
                  return;
                }

                final nuevoTipoSuscripcion = TipoSuscripcionDTO(
                  nombre: nombre,
                  descripcion: descripcion,
                  precio: precio,
                  duracion: duracion,
                );

                try {
                  final mensaje = await ref
                      .read(tipoSuscripcionProvider.notifier)
                      .registrarTipoSuscripcion(nuevoTipoSuscripcion);
                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(mensaje)));
                  ref
                      .refresh(tipoSuscripcionProvider.notifier)
                      .obtenerTiposSuscripciones();
                  Navigator.of(context)
                      .pop(); // Cerrar el diálogo después de registrar
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Error al registrar: $e')));
                }
              },
              child: const Text('Añadir'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final tipoSuscripcionState = ref.watch(tipoSuscripcionProvider);

    if (tipoSuscripcionState.estaCargando) {
      return const FullScreenLoader();
    }

    return Column(
      children: [
        // Botón "Añadir Suscripción"
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Align(
            alignment: Alignment
                .centerRight, // Cambia a Alignment.centerLeft o Alignment.centerRight si prefieres otra alineación
            child: ElevatedButton(
              onPressed: _registrarTipoSuscripcion,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF006443),
                foregroundColor: Colors.white,
              ),
              child: const Text('Añadir Suscripción'),
            ),
          ),
        ),

        // Lista de tarjetas de suscripciones
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: tipoSuscripcionState.tiposSuscripcion.length,
            itemBuilder: (context, index) {
              final tipoSuscripcion =
                  tipoSuscripcionState.tiposSuscripcion[index];

              return TipoSuscripcionCard(
                tipoSuscripcion: tipoSuscripcion,
                onToggle: (id) => _toggleTipoSuscripcion(
                    id, tipoSuscripcion.estatus == 'Activo'),
                onModify: (id, tipoSuscripcionDTO) =>
                    _modificarTipoSuscripcion(id, tipoSuscripcionDTO),
              );
            },
          ),
        ),
      ],
    );
  }
}
