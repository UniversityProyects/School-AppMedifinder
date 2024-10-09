import 'package:medifinder_crm/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        nombreCompleto: json['nombreCompleto'],
        direccion: json['direccion'],
        telefono: json['telefono'],
        especialidades: List<String>.from(
          json['especialidades']
              .map((especialidad) => especialidad['especialidad']),
        ),
      );
}
