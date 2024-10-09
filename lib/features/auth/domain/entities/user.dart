class User {
  final String nombreCompleto;
  final String direccion;
  final String telefono;
  final List<String> especialidades;

  User(
      {required this.nombreCompleto,
      required this.direccion,
      required this.telefono,
      required this.especialidades});
}
