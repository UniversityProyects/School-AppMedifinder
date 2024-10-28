import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/administrador/domain/domain.dart';
import 'package:medifinder_crm/features/administrador/infrastructure/infrastructure.dart';

final AdministradorRepositoryProvider =
    Provider<AdministradorRepository>((ref) {
  final administradorRepository =
      AdministradorRepositoryImpl(datasource: AdministradorDatasourceImpl());
  return administradorRepository;
});
