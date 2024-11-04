class SolicutudMedico {
  int id;
  String nombre;
  String apellido;
  String email;
  String telefono;
  String calle;
  String colonia;
  String numero;
  String ciudad;
  String pais;
  String codigoPostal;
  String estatus;
  DateTime fechaRegistro;
  List<Especialidades> especialidades;

  SolicutudMedico({
    required this.id,
    required this.nombre,
    required this.apellido,
    required this.email,
    required this.telefono,
    required this.calle,
    required this.colonia,
    required this.numero,
    required this.ciudad,
    required this.pais,
    required this.codigoPostal,
    required this.estatus,
    required this.fechaRegistro,
    required this.especialidades,
  });
}

class Especialidades {
  int idEspecialidad;
  String numCedula;
  int honorarios;
  String especialidad;

  Especialidades({
    required this.idEspecialidad,
    required this.numCedula,
    required this.honorarios,
    required this.especialidad,
  });
}
