class CredencialesIncorrectas implements Exception {}

class TiempoEsperaConexion implements Exception {}

class TokenInvalido implements Exception {}

class ErrorPersonalizado implements Exception {
  final String mensaje;
  ErrorPersonalizado(this.mensaje);
}
