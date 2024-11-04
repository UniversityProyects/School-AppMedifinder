class TipoSuscripcionDTO {
  final String nombre;
  final String descripcion;
  final double precio;
  final int duracion;

  TipoSuscripcionDTO({
    required this.nombre,
    required this.descripcion,
    required this.precio,
    required this.duracion,
  });

  Map<String, dynamic> toJson() {
    return {
      'Nombre': nombre,
      'Descripcion': descripcion,
      'Precio': precio,
      'Duracion': duracion,
    };
  }
}
