class TipoSuscripcion {
  int id;
  String nombre;
  String descripcion;
  double precio;
  int duracion;
  String estatus;

  TipoSuscripcion(
      {required this.id,
      required this.nombre,
      required this.descripcion,
      required this.precio,
      required this.duracion,
      required this.estatus});
}
