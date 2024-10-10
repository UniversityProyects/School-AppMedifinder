import 'package:medifinder_crm/features/auth/domain/domain.dart';

class UserMapper {
  static User userJsonToEntity(Map<String, dynamic> json) => User(
        nombreCompleto: json['nombreCompleto'],
        email: json['email'],
        id: json['id'],
        estatus: json['estatus'],
      );
}
