import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';

class SolicutudMedicoMapper {
  static JsonToEntity(Map<String, dynamic> json) => SolicutudMedico(
        id: json['id'],
        nombre: json['nombre'],
        apellido: json['apellido'],
        email: json['email'],
        telefono: json['telefono'],
        calle: json['calle'],
        colonia: json['colonia'],
        numero: json['numero'],
        ciudad: json['ciudad'],
        pais: json['pais'],
        codigoPostal: json['codigoPostal'],
        estatus: json['estatus'],
        fechaRegistro: DateTime.parse(json['fechaRegistro']),
        especialidades: (json['especialidades'] as List)
            .map((especialidadJson) =>
                EspecialidadesMapper.fromJson(especialidadJson))
            .toList(),
      );
}

class EspecialidadesMapper {
  static Especialidades fromJson(Map<String, dynamic> json) => Especialidades(
        idEspecialidad: json['idEspecialidad'],
        numCedula: json['numCedula'],
        honorarios: json['honorarios'],
        especialidad: json['especialidad'],
      );
}
