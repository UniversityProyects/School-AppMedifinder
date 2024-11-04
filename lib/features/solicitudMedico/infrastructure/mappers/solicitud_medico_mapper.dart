import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';

class SolicutudMedicoMapper {
  static SolicutudMedico JsonToEntity(Map<String, dynamic> json) =>
      SolicutudMedico(
        id: json['id'] as int, // ID como int
        nombre: json['nombre'] as String,
        apellido: json['apellido'] as String,
        email: json['email'] as String,
        telefono: json['telefono'] as String,
        calle: json['calle'] as String,
        colonia: json['colonia'] as String,
        numero: int.tryParse(json['numero']) ?? 0, // Convierte a int
        ciudad: json['ciudad'] as String,
        pais: json['pais'] as String,
        codigoPostal: json['codigoPostal'] as String,
        estatus: int.tryParse(json['estatus']) ?? 0, // Convierte a int
        fechaRegistro: DateTime.parse(json['fechaRegistro'] as String),
        especialidades: (json['especialidades'] as List<dynamic>)
            .map((especialidadJson) => EspecialidadesMapper.fromJson(
                especialidadJson as Map<String, dynamic>))
            .toList(),
      );
}

class EspecialidadesMapper {
  static Especialidades fromJson(Map<String, dynamic> json) => Especialidades(
        idEspecialidad: json['idEspecialidad'] as int,
        numCedula: json['numCedula'] as String,
        honorarios: (json['honorarios'] as num)
            .toDouble(), // Asegúrate de que honorarios sea un double
        especialidad: json['especialidad'] as String,
      );
}
