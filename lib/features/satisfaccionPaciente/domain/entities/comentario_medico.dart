class ComentarioMedico {
  int idCita;
  int idMedico;
  String nombreMedico;
  String apellidoMedico;
  int idPaciente;
  String nombrePaciente;
  String apellidoPaciente;
  DateTime fechaInicio;
  DateTime fechaFin;
  int puntuacion;
  DateTime fechaPuntuacion;
  String comentarios;

  ComentarioMedico({
    required this.idCita,
    required this.idMedico,
    required this.nombreMedico,
    required this.apellidoMedico,
    required this.idPaciente,
    required this.nombrePaciente,
    required this.apellidoPaciente,
    required this.fechaInicio,
    required this.fechaFin,
    required this.puntuacion,
    required this.fechaPuntuacion,
    required this.comentarios,
  });
}
