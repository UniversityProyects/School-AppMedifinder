import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/infrastructure/infrastructure.dart';

final tipoSuscripcionRepositoryProvider =
    Provider<TipoSuscripcionRepository>((ref) {
  final tipoSuscripcionRepository = TipoSuscripcionRepositoryImpl(
      datasource: TipoSuscripcionDatasourceImpl());

  return tipoSuscripcionRepository;
});
