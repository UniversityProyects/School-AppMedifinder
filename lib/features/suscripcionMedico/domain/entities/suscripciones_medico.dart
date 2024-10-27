class SuscripcionesMedico {
  int idMedico;
  String nombreMedico;
  String apellidoMedico;
  String estatusMedico;
  List<Suscripcion> suscripciones;

  SuscripcionesMedico({
    required this.idMedico,
    required this.nombreMedico,
    required this.apellidoMedico,
    required this.estatusMedico,
    required this.suscripciones,
  });
}

class Suscripcion {
  int idSuscripcion;
  int idTipoSuscripcion;
  String nombreTipoSuscripcion;
  String descripcionTipoSuscripcion;
  double precioTipoSuscripcion;
  String estatusPago;
  dynamic fechaPago;

  Suscripcion({
    required this.idSuscripcion,
    required this.idTipoSuscripcion,
    required this.nombreTipoSuscripcion,
    required this.descripcionTipoSuscripcion,
    required this.precioTipoSuscripcion,
    required this.estatusPago,
    required this.fechaPago,
  });
}
