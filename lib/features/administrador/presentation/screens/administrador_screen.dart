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
              listaAdministradores: administradorState.listaAdministradores,
              ref: ref, // Pasamos ref aquí
              scaffoldContext: context, // Pasamos el contexto aquí
            ),
    );
  }
}

class _AdministradorView extends StatelessWidget {
  final List<Administrador> listaAdministradores;
  final WidgetRef ref;
  final BuildContext
      scaffoldContext; // Contexto principal para mostrar el SnackBar

  const _AdministradorView({
    super.key,
    required this.listaAdministradores,
    required this.ref,
    required this.scaffoldContext,
  });

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
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _toggleEstatus(
                          scaffoldContext, // Usamos el contexto principal aquí
                          administrador.id,
                          administrador.estatus != "1",
                          ref,
                        );
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
                        style: const TextStyle(color: Colors.white),
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

  void _toggleEstatus(
      BuildContext scaffoldContext, int id, bool activar, WidgetRef ref) {
    final mensaje = activar
        ? "¿Desea activar este administrador?"
        : "¿Desea desactivar este administrador?";

    showDialog(
      context: scaffoldContext,
      builder: (context) {
        return AlertDialog(
          title: const Text("Confirmar"),
          content: Text(mensaje),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Cancelar"),
            ),
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  if (activar) {
                    await ref
                        .read(administradorProvider.notifier)
                        .activarAdministrador(id.toString());
                    _showSnackBar(scaffoldContext, "Administrador activado");
                  } else {
                    await ref
                        .read(administradorProvider.notifier)
                        .desactivarAdministrador(id.toString());
                    _showSnackBar(scaffoldContext, "Administrador desactivado");
                  }
                } catch (e) {
                  _showSnackBar(scaffoldContext, "Error: $e");
                }
              },
              child: const Text("Aceptar"),
            ),
          ],
        );
      },
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
  }
}
