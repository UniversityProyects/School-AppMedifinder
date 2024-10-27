import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';

class TipoSuscripcionMapper {
  static JsonToEntity(Map<String, dynamic> json) => TipoSuscripcion(
      id: json['id'],
      nombre: json['nombre'],
      descripcion: json['descripcion'],
      precio: double.parse(json['precio'].toString()),
      duracion: json['duracion']);
}
