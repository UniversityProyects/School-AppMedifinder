import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';

class SuscripcionesMedicoMapper {
  // Función que retorna la respuesta mapeada a JSON
  static SuscripcionesMedico jsonToEntity(Map<String, dynamic> json) {
    return SuscripcionesMedico(
      idMedico: json['idMedico'],
      nombreMedico: json['nombreMedico'],
      apellidoMedico: json['apellidoMedico'],
      estatusMedico: json['estatusMedico'],
      suscripciones: (json['suscripciones'] as List)
          .map((suscripcionJson) => Suscripcion(
                idSuscripcion: suscripcionJson['idSuscripcion'],
                idTipoSuscripcion: suscripcionJson['idTipoSuscripcion'],
                nombreTipoSuscripcion: suscripcionJson['nombreTipoSuscripcion'],
                descripcionTipoSuscripcion:
                    suscripcionJson['descripcionTipoSuscripcion'],
                precioTipoSuscripcion:
                    suscripcionJson['precioTipoSuscripcion'].toDouble(),
                estatusPago: suscripcionJson['estatusPago'],
                fechaPago: suscripcionJson['fechaPago'],
              ))
          .toList(),
    );
  }
}
