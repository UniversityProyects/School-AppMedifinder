import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';

class SuscripcionMedicoMapper {
  //Funcion que retorna la respuesta mapeada a JSON
  static JsonToEntity(Map<String, dynamic> json) => SuscripcionMedico(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        estatus: json['estatus'],
        cantidadSuscripciones: json['cantidadSuscripciones'],
      );
}
