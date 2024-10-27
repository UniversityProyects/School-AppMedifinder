import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import 'package:medifinder_crm/features/suscripcionMedico/presentation/providers/suscripcion_medico_repository_provider.dart';

//StateNotifierProvider
//Autodispose para limpiar cada que ya no se utiliza
//Famlily para esperar un valor obligatorio al cargar, en este caso idMedico
final SuscripcionesMedicoProvider = StateNotifierProvider.autoDispose
    .family<SuscripcionesMedicoNotifier, SuscripcionesMedicoState, String>(
        (ref, idMedico) {
  //Variable que estará monitoreando el estado
  final suscripcionMedicoRepository =
      ref.watch(suscripcionMedicoRepositoryProvider);

  return SuscripcionesMedicoNotifier(
      suscripcionMedicoRepository: suscripcionMedicoRepository,
      idMedico: idMedico);
});

//Notifier
class SuscripcionesMedicoNotifier
    extends StateNotifier<SuscripcionesMedicoState> {
  //Repositorio de donde se obtiene la informacion
  final SuscripcionMedicoRepository suscripcionMedicoRepository;

  //Constructor del notifier
  SuscripcionesMedicoNotifier(
      {required this.suscripcionMedicoRepository, required idMedico})
      : super(SuscripcionesMedicoState(idMedico: idMedico)) {
    obtenerListadoSuscripcionesMedicos();
  }

  //Metodo que obtiene el listado y cambia el state
  Future obtenerListadoSuscripcionesMedicos() async {
    state = state.copyWith(estaCargando: true);

    //Llamada al metodo que obtiene los resultados
    final resultado = await suscripcionMedicoRepository
        .obtenerListadoSuscripcionesPorIdMedico(state.idMedico);

    //Si el resultado es exitoso
    state = state.copyWith(
        estaCargando: false, listaSuscripcionesMedico: resultado);
  }
}

//Paso 1: State
class SuscripcionesMedicoState {
  //Variables que manejaran el estado
  final String idMedico;
  final bool estaCargando;
  final List<SuscripcionesMedico> listaSuscripcionesMedico;

  SuscripcionesMedicoState({
    required this.idMedico,
    this.estaCargando = false,
    this.listaSuscripcionesMedico = const [],
  });

  //Copywith para manejar el estado
  SuscripcionesMedicoState copyWith({
    String? idMedico,
    bool? estaCargando,
    List<SuscripcionesMedico>? listaSuscripcionesMedico,
  }) =>
      SuscripcionesMedicoState(
          idMedico: idMedico ?? this.idMedico,
          estaCargando: estaCargando ?? this.estaCargando,
          listaSuscripcionesMedico:
              listaSuscripcionesMedico ?? this.listaSuscripcionesMedico);
}
