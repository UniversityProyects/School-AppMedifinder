import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/administrador/domain/domain.dart';
import 'package:medifinder_crm/features/administrador/presentation/providers/administrador_repository_provider.dart';

//StateNotifierProvider
final administradorProvider =
    StateNotifierProvider<AdministradorNotifier, AdministradorState>((ref) {
  final administradorRepository = ref.watch(AdministradorRepositoryProvider);

  return AdministradorNotifier(
      administradorRepository: administradorRepository);
});

//Notifier
class AdministradorNotifier extends StateNotifier<AdministradorState> {
  final AdministradorRepository administradorRepository;

  AdministradorNotifier({required this.administradorRepository})
      : super(AdministradorState()) {
    obtenerAdministradores();
  }

  Future obtenerAdministradores() async {
    state = state.copyWith(estaCargando: true);

    final responseAdministradores =
        await administradorRepository.obtenerAdministradores();

    if (responseAdministradores.isEmpty) {
      state = state.copyWith(estaCargando: false);
      return;
    }

    state = state.copyWith(
        estaCargando: false, listaAdministradores: responseAdministradores);
  }
}

//State
class AdministradorState {
  final bool estaCargando;
  final List<Administrador> listaAdministradores;

  AdministradorState({
    this.estaCargando = false,
    this.listaAdministradores = const [],
  });

  AdministradorState copyWith(
          {bool? estaCargando, List<Administrador>? listaAdministradores}) =>
      AdministradorState(
          estaCargando: estaCargando ?? this.estaCargando,
          listaAdministradores:
              listaAdministradores ?? this.listaAdministradores);
}
