import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';
import 'satisfaccion_paciente_repository_provider.dart';

//Provider
final satisfaccionPacienteProvider = StateNotifierProvider<
    SatisfaccionPacienteNotifier, SatisfaccionPacienteState>((ref) {
  final satisfaccionPacienteRepository =
      ref.watch(satisfaccionPacienteRepositoryProvider);

  return SatisfaccionPacienteNotifier(
      satisfaccionPacienteRepository: satisfaccionPacienteRepository);
});

//Notifier de mi provider
class SatisfaccionPacienteNotifier
    extends StateNotifier<SatisfaccionPacienteState> {
  final SatisfaccionPacienteRepository satisfaccionPacienteRepository;

  SatisfaccionPacienteNotifier({
    required this.satisfaccionPacienteRepository,
  }) : super(SatisfaccionPacienteState());

  Future obtenerCalificacionesMedico() async {
    state = state.copyWith(
      estaCargando: true,
    );

    final responseCalificacionesMedico =
        await satisfaccionPacienteRepository.obtenerCalificacionesMedicos();

    if (responseCalificacionesMedico.isEmpty) {
      state = state.copyWith(
        estaCargando: false,
      );
      return;
    }

    state = state.copyWith(
        estaCargando: false,
        calificacionesMedico: responseCalificacionesMedico);
  }
}

//Estado de mi provider
class SatisfaccionPacienteState {
  final bool estaCargando;
  final List<CalificacionMedico> calificacionesMedico;

  SatisfaccionPacienteState({
    this.estaCargando = false,
    this.calificacionesMedico = const [],
  });

  SatisfaccionPacienteState copyWith({
    bool? estaCargando,
    List<CalificacionMedico>? calificacionesMedico,
  }) =>
      SatisfaccionPacienteState(
        estaCargando: estaCargando ?? this.estaCargando,
        calificacionesMedico: calificacionesMedico ?? this.calificacionesMedico,
      );
}
