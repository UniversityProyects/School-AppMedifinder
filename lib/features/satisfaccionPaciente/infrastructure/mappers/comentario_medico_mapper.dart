import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';

class ComentarioMedicoMapper {
  static JsonToEntity(Map<String, dynamic> json) => ComentarioMedico(
        idCita: json['id_Cita'],
        idMedico: json['idMedico'],
        nombreMedico: json['nombreMedico'],
        apellidoMedico: json['apellidoMedico'],
        idPaciente: json['idPaciente'],
        nombrePaciente: json['nombrePaciente'],
        apellidoPaciente: json['apellidoPaciente'],
        fechaInicio: DateTime.parse(json['fechaInicio']),
        fechaFin: DateTime.parse(json['fechaFin']),
        puntuacion: json['puntuacion'],
        fechaPuntuacion: DateTime.parse(json['fechaPuntuacion']),
        comentarios: json['comentarios'],
      );
}
