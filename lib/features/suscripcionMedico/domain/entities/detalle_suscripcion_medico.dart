class DetalleSuscripcionMedico {
  int idSuscripcion;
  int idMedico;
  String nombreMedico;
  String apellidoMedico;
  String estatusMedico;
  int idTipoSuscripcion;
  String nombreTipoSuscripcion;
  String descripcionTipoSuscripcion;
  double precioTipoSuscripcion;
  int duracionTipoSuscripcion;
  DateTime fechaInicio;
  DateTime fechaFin;
  String estatusPago;
  dynamic fechaPago;

  DetalleSuscripcionMedico({
    required this.idSuscripcion,
    required this.idMedico,
    required this.nombreMedico,
    required this.apellidoMedico,
    required this.estatusMedico,
    required this.idTipoSuscripcion,
    required this.nombreTipoSuscripcion,
    required this.descripcionTipoSuscripcion,
    required this.precioTipoSuscripcion,
    required this.duracionTipoSuscripcion,
    required this.fechaInicio,
    required this.fechaFin,
    required this.estatusPago,
    required this.fechaPago,
  });
}
