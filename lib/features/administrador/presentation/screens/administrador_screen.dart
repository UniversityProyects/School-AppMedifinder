import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/administrador/domain/domain.dart';
import 'package:medifinder_crm/features/administrador/presentation/providers/administrador_provider.dart';
import 'package:medifinder_crm/features/shared/shared.dart';

class AdministradorScreen extends ConsumerWidget {
  const AdministradorScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scaffoldKey = GlobalKey<ScaffoldState>();
    final administradorState = ref.watch(administradorProvider);

    return Scaffold(
      drawer: SideMenu(scaffoldKey: scaffoldKey),
      appBar: AppBar(
        title: const Text("Usuarios"),
      ),
      body: administradorState.estaCargando
          ? const FullScreenLoader()
          : _AdministradorView(
              listaAdministradores: administradorState.listaAdministradores),
    );
  }
}

class _AdministradorView extends StatelessWidget {
  final List<Administrador> listaAdministradores;

  const _AdministradorView({super.key, required this.listaAdministradores});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: listaAdministradores.length,
      itemBuilder: (context, index) {
        final administrador = listaAdministradores[index];

        return Card(
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
          elevation: 8,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        "${administrador.nombre} ${administrador.apellido}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Icon(
                      administrador.estatus == "1"
                          ? Icons.check_circle
                          : Icons.error,
                      color: administrador.estatus == "1"
                          ? Colors.green
                          : Colors.red,
                      size: 28,
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Text("Email: ${administrador.email}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 8),
                Text("Estatus: ${_getEstatus(administrador.estatus)}",
                    style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment:
                      MainAxisAlignment.end, // Alineación a la derecha
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        if (administrador.estatus == "1") {
                          _toggleEstatus(context, administrador.id, false);
                        } else {
                          _toggleEstatus(context, administrador.id, true);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: administrador.estatus == "1"
                            ? Colors.red
                            : Colors.green,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: Text(
                        administrador.estatus == "1" ? "Desactivar" : "Activar",
                        style: const TextStyle(
                            color: Colors.white), // Texto en blanco
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

  String _getEstatus(String estatus) {
    switch (estatus) {
      case "0":
        return "Nuevo/Sin Validar";
      case "1":
        return "Activo/Validado";
      case "2":
        return "Activo/Pago Realizado";
      case "3":
        return "Inactivo";
      default:
        return "Desconocido";
    }
  }

  void _toggleEstatus(BuildContext context, int id, bool activar) {
    final mensaje = activar
        ? "¿Desea activar este administrador?"
        : "¿Desea desactivar este administrador?";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Cierra el diálogo
                // Lógica para realizar la acción (activar/desactivar)
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }
}
