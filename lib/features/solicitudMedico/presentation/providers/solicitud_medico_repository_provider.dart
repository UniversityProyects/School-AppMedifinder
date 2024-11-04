import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
import 'package:medifinder_crm/features/solicitudMedico/infrastructure/infrastructure.dart';

//Este archivo sirve para conectar la capa de negocio con la capa de datos
//Indicamos que la capa de negocio depende de la capa de datos
final SolicitudMedicoRepositoryProvider =
    Provider<SolicitudMedicoRepository>((ref) {
  final solicitudMedicoRepository = SolicitudMedicoRepositoryImpl(
      datasource: SolicitudMedicoDatasourceImpl());
  return solicitudMedicoRepository;
});
