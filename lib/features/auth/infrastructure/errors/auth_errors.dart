class WrongCredentials implements Exception {}

class ConnectionTimeOut implements Exception {}

class InvalidToken implements Exception {}

class ErrorPersonalizado implements Exception {
  final String mensaje;
  // final int errorCode;
  ErrorPersonalizado(this.mensaje);
}
