import '../entities/solicutud_medico.dart';

//Este archivo solo contiene la estructura base de las clases que se utilizarán en el modulo.
abstract class SolicitudMedicoDatasource {
  /// Estructura
  /// Future: Es porque la mayoria se utilizaran como async
  /// <SolicitudMedico>: es el tipo de respuesta que se recibira
  /// obtenerSolicitudesMedico(): es el nombre del metodo que se utilizará para obtener los datos

  Future<List<SolicutudMedico>> obtenerSolicitudesMedico();
  Future<SolicutudMedico> obtenerDetallesSolicitudMedico(String idSolicitud);
  Future<bool> confirmarSolicitudMedico(String idSolicitud);
  Future<bool> rechazarSolicituMedico(String idSolicitud);
}
