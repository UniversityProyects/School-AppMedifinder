import 'package:flutter/material.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/infrastructure/mappers/tipoSuscripcionDTO.dart';

class TipoSuscripcionCard extends StatefulWidget {
  final TipoSuscripcion tipoSuscripcion;
  final Function(int) onToggle;
  final Function(int, TipoSuscripcionDTO) onModify;

  const TipoSuscripcionCard({
    super.key,
    required this.tipoSuscripcion,
    required this.onToggle,
    required this.onModify,
  });

  @override
  _TipoSuscripcionCardState createState() => _TipoSuscripcionCardState();
}

class _TipoSuscripcionCardState extends State<TipoSuscripcionCard> {
  late TextEditingController _nombreController;
  late TextEditingController _descripcionController;
  late TextEditingController _precioController;
  late TextEditingController _duracionController;

  late TipoSuscripcion tipoSuscripcion; // Declara la variable aquí

  @override
  void initState() {
    super.initState();
    tipoSuscripcion = widget.tipoSuscripcion; // Asigna el valor aquí
    _nombreController = TextEditingController(text: tipoSuscripcion.nombre);
    _descripcionController =
        TextEditingController(text: tipoSuscripcion.descripcion);
    _precioController =
        TextEditingController(text: tipoSuscripcion.precio.toString());
    _duracionController =
        TextEditingController(text: tipoSuscripcion.duracion.toString());
  }

  @override
  void dispose() {
    _nombreController.dispose();
    _descripcionController.dispose();
    _precioController.dispose();
    _duracionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool esActivo = tipoSuscripcion.estatus == 'Activo'; // Usa la variable aquí

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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                // Estatus Actual
                Text(
                  tipoSuscripcion.estatus,
                  style: TextStyle(
                    fontSize: 16,
                    color: esActivo ? Colors.green : Colors.red,
                  ),
                ),
              ],
            ),

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
                      '${tipoSuscripcion.duracion} ${tipoSuscripcion.duracion == 1 ? 'mes' : 'meses'}',
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
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () => widget.onToggle(tipoSuscripcion.id),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: esActivo ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(
                    esActivo ? 'Desactivar' : 'Activar',
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () => _showModifyModal(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Modificar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showModifyModal(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Modificar Suscripción'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                TextField(
                  decoration: const InputDecoration(labelText: 'Nombre'),
                  controller: _nombreController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Descripción'),
                  controller: _descripcionController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Precio'),
                  keyboardType: TextInputType.number,
                  controller: _precioController,
                ),
                TextField(
                  decoration: const InputDecoration(labelText: 'Duración'),
                  keyboardType: TextInputType.number,
                  controller: _duracionController,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Validación de campos
                if (_nombreController.text.isEmpty ||
                    _descripcionController.text.isEmpty ||
                    _precioController.text.isEmpty ||
                    _duracionController.text.isEmpty) {
                  // Muestra un mensaje de error
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Todos los campos son obligatorios')),
                  );
                  return;
                }

                final tipoSuscripcionDTO = TipoSuscripcionDTO(
                  nombre: _nombreController.text,
                  descripcion: _descripcionController.text,
                  precio: double.tryParse(_precioController.text) ?? 0.0,
                  duracion: int.tryParse(_duracionController.text) ?? 0,
                );

                widget.onModify(tipoSuscripcion.id, tipoSuscripcionDTO);
                Navigator.pop(context);
              },
              child: const Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }
}
