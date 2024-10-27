import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import 'package:medifinder_crm/features/suscripcionMedico/infrastructure/infrastructure.dart';

final suscripcionMedicoRepositoryProvider =
    Provider<SuscripcionMedicoRepository>((ref) {
  final suscripcionMedicoRepository = SuscripcionMedicoRepositoryImpl(
      datasource: SuscripcionMedicoDatasourceImpl());

  return suscripcionMedicoRepository;
});
