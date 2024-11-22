import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  late TipoSuscripcion tipoSuscripcion;

  @override
  void initState() {
    super.initState();
    tipoSuscripcion = widget.tipoSuscripcion;
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool esActivo = tipoSuscripcion.estatus == 'Activo';

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
                Text(
                  tipoSuscripcion.nombre,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                const SizedBox(height: 8),
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
    final _nombreController =
        TextEditingController(text: tipoSuscripcion.nombre);
    final _descripcionController =
        TextEditingController(text: tipoSuscripcion.descripcion);
    final _precioController =
        TextEditingController(text: tipoSuscripcion.precio.toString());
    final _duracionController =
        TextEditingController(text: tipoSuscripcion.duracion.toString());

    String? errorMessage;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Modificar Suscripción'),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [
                    if (errorMessage != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 0),
                        child: Text(
                          errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Nombre'),
                      controller: _nombreController,
                      maxLength: 20,
                    ),
                    TextField(
                      decoration:
                          const InputDecoration(labelText: 'Descripción'),
                      controller: _descripcionController,
                      maxLength: 20,
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Precio'),
                      controller: _precioController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: [
                        DecimalInputFormatter(),
                      ],
                    ),
                    TextField(
                      decoration: const InputDecoration(labelText: 'Duración'),
                      keyboardType: TextInputType.number,
                      controller: _duracionController,
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(3),
                      ],
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    final nombre = _nombreController.text.trim();
                    final descripcion = _descripcionController.text.trim();
                    final precio = double.tryParse(_precioController.text);
                    final duracion = int.tryParse(_duracionController.text);

                    // Validar campos
                    if (nombre.isEmpty ||
                        descripcion.isEmpty ||
                        precio == null ||
                        duracion == null) {
                      setState(() {
                        errorMessage = 'Todos los campos son obligatorios.';
                      });
                      return;
                    }

                    if (precio <= 0) {
                      setState(() {
                        errorMessage = 'El precio tiene que ser mayor a 0.';
                      });
                      return;
                    }

                    if (!RegExp(r'^\d{1,8}(\.\d{1,2})?$')
                        .hasMatch(precio.toString())) {
                      setState(() {
                        errorMessage =
                            'El precio debe ser un número válido con máximo 8 dígitos y 2 decimales.';
                      });
                      return;
                    }

                    if (duracion <= 0) {
                      setState(() {
                        errorMessage = 'La duración tiene que ser mayor a 0.';
                      });
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
      },
    );
  }
}

class DecimalInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final regex = RegExp(r'^\d{0,8}(\.\d{0,2})?$');

    if (regex.hasMatch(newValue.text)) {
      return newValue;
    }

    return oldValue;
  }
}
