import 'package:medifinder_crm/features/auth/domain/domain.dart';

class UsuarioMapper {
  static Usuario userJsonToEntity(Map<String, dynamic> json) => Usuario(
        nombreCompleto: json['nombreCompleto'],
        email: json['email'],
        id: json['id'],
        estatus: json['estatus'],
      );
}
