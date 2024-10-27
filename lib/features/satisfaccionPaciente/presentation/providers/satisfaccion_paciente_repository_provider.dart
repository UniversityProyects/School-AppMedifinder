import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/infrastructure/infrastructure.dart';

final satisfaccionPacienteRepositoryProvider =
    Provider<SatisfaccionPacienteRepository>((ref) {
  final satisfaccionPacienteRepository = SatisfaccionPacienteRespositoryImpl(
      datasource: SatisfaccionPacienteDatasourceImpl());

  return satisfaccionPacienteRepository;
});
