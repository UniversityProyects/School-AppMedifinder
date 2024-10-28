import 'package:medifinder_crm/features/administrador/domain/domain.dart';

class AdministradorMapper {
  static JsonToEntity(Map<String, dynamic> json) => Administrador(
      id: json['id'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      email: json['email'],
      estatus: json['estatus']);
}
