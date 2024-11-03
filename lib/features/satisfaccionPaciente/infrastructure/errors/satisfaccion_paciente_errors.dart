class MedicoNoEncontrado implements Exception {}

class ErrorPersonalizado implements Exception{
  final String mensaje;
  ErrorPersonalizado(this.mensaje);
}
