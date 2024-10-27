import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import 'package:medifinder_crm/features/suscripcionMedico/presentation/providers/suscripcion_medico_repository_provider.dart';

//stateNotifierProvider
final DetalleSuscripcionMedicoProvider = StateNotifierProvider.autoDispose
    .family<DetalleSuscripcionMedicoNotifier, DetalleSuscripcionMedicoState,
        String>((ref, idSuscripcion) {
  //Variable que estará monitoreando el estado
  final suscripcionMedicoRepository =
      ref.watch(suscripcionMedicoRepositoryProvider);

  return DetalleSuscripcionMedicoNotifier(
      suscripcionMedicoRepository, idSuscripcion);
});

//Notifier
class DetalleSuscripcionMedicoNotifier
    extends StateNotifier<DetalleSuscripcionMedicoState> {
  final SuscripcionMedicoRepository suscripcionMedicoRepository;

  DetalleSuscripcionMedicoNotifier(
      this.suscripcionMedicoRepository, String idSuscripcion)
      : super(DetalleSuscripcionMedicoState(idSuscripcion: idSuscripcion)) {
    obtenerDetalleSuscripcionMedico();
  }

  //Metodo para cargar el detalle en la pantalla
  Future obtenerDetalleSuscripcionMedico() async {
    state = state.copyWith(estaCargando: true);

    //Llamada al metodo que obtiene eldetalle
    final detalleSuscripcionMedico = await suscripcionMedicoRepository
        .obtenerDetallesSuscripcionPorId(state.idSuscripcion);

    state = state.copyWith(
        estaCargando: false,
        detalleSuscripcionMedico: detalleSuscripcionMedico);
  }
}

//State
class DetalleSuscripcionMedicoState {
  //Variables que manejara el estado
  final String idSuscripcion;
  final bool estaCargando;
  final DetalleSuscripcionMedico? detalleSuscripcionMedico;

  //Constructor
  DetalleSuscripcionMedicoState({
    required this.idSuscripcion,
    this.estaCargando = false,
    this.detalleSuscripcionMedico,
  });

  //Copywith para cambiar el estado

  DetalleSuscripcionMedicoState copyWith({
    String? idSuscripcion,
    bool? estaCargando,
    DetalleSuscripcionMedico? detalleSuscripcionMedico,
  }) =>
      DetalleSuscripcionMedicoState(
          idSuscripcion: idSuscripcion ?? this.idSuscripcion,
          estaCargando: estaCargando ?? this.estaCargando,
          detalleSuscripcionMedico:
              detalleSuscripcionMedico ?? this.detalleSuscripcionMedico);
}
