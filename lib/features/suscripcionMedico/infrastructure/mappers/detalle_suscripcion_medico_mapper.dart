import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';

class DetalleSuscripcionMedicoMapper {
  // Función que retorna la respuesta mapeada a un objeto DetalleSuscripcionMedico
  static DetalleSuscripcionMedico jsonToEntity(Map<String, dynamic> json) =>
      DetalleSuscripcionMedico(
        idSuscripcion: json['idSuscripcion'],
        idMedico: json['idMedico'],
        nombreMedico: json['nombreMedico'],
        apellidoMedico: json['apellidoMedico'],
        estatusMedico: json['estatusMedico'],
        idTipoSuscripcion: json['idTipoSuscripcion'],
        nombreTipoSuscripcion: json['nombreTipoSuscripcion'],
        descripcionTipoSuscripcion: json['descripcionTipoSuscripcion'],
        precioTipoSuscripcion: json['precioTipoSuscripcion'],
        duracionTipoSuscripcion: json['duracionTipoSuscripcion'],
        fechaInicio: DateTime.parse(json['fechaInicio']),
        fechaFin: DateTime.parse(json['fechaFin']),
        estatusPago: json['estatusPago'],
        // Manejo de fechaPago que puede ser null
        fechaPago: json['fechaPago'] != null
            ? DateTime.parse(json['fechaPago'])
            : null,
      );
}
