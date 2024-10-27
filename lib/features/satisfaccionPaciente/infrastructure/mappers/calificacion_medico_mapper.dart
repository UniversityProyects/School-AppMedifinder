import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';

class CalificacionMedicoMapper {
  static JsonToEntity(Map<String, dynamic> json) => CalificacionMedico(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        promedioPuntuacion: double.parse(json['promedioPuntuacion'].toString()),
        estatus: json['estatus'],
        cantidadComentarios: json['cantidadComentarios'],
      );
}
