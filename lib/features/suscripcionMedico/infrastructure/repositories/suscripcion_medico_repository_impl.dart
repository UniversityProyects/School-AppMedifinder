import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';

class SuscripcionMedicoRepositoryImpl extends SuscripcionMedicoRepository {
  final SuscripcionMedicoDatasource datasource;

  SuscripcionMedicoRepositoryImpl({required this.datasource});

  @override
  Future<DetalleSuscripcionMedico> obtenerDetallesSuscripcionPorId(
      String idSuscripcion) {
    return datasource.obtenerDetallesSuscripcionPorId(idSuscripcion);
  }

  @override
  Future<List<SuscripcionMedico>> obtenerListadoSuscripcionesMedicos() {
    return datasource.obtenerListadoSuscripcionesMedicos();
  }

  @override
  Future<List<SuscripcionesMedico>> obtenerListadoSuscripcionesPorIdMedico(
      String idMedico) {
    return datasource.obtenerListadoSuscripcionesPorIdMedico(idMedico);
  }
}
