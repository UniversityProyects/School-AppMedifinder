import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';

//Esta clase sirve para conectar los provider con nuestra fuente de datos, en este caso
//nuestra fuente de datos es el datasource (SolicitudMedicoDatasource)
class SolicitudMedicoRepositoryImpl extends SolicitudMedicoRepository {
  //Se define de donde se obtendra la informacion
  final SolicitudMedicoDatasource datasource;

  //Contructor
  SolicitudMedicoRepositoryImpl({required this.datasource});

  //En cada metodo le tenemos que especificar que funcion va a utilizar del datasource
  @override
  Future<bool> confirmarSolicitudMedico(String idSolicitud) {
    return datasource.confirmarSolicitudMedico(idSolicitud);
  }

  @override
  Future<SolicutudMedico> obtenerDetallesSolicitudMedico(String idSolicitud) {
    return datasource.obtenerDetallesSolicitudMedico(idSolicitud);
  }

  @override
  Future<List<SolicutudMedico>> obtenerSolicitudesMedico() {
    return datasource.obtenerSolicitudesMedico();
  }

  @override
  Future<bool> rechazarSolicituMedico(String idSolicitud) {
    return datasource.rechazarSolicituMedico(idSolicitud);
  }
}
