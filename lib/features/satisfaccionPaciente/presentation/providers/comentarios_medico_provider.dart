import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/domain/domain.dart';
import 'package:medifinder_crm/features/satisfaccionPaciente/presentation/providers/providers.dart';

//El autodispose limpia cada vez que ya no se utiliza
//El family es para esperar un valor obligatorio al cargar
final ComentariosMedicoProvider = StateNotifierProvider.autoDispose
    .family<ComentariosMedicoNotifier, ComentariosMedicoState, String>(
        (ref, idMedico) {
  final satisfaccionPacienteRepository =
      ref.watch(satisfaccionPacienteRepositoryProvider);

  return ComentariosMedicoNotifier(
      satisfaccionPacienteRepository: satisfaccionPacienteRepository,
      idMedico: idMedico);
});

//Notifier del provider
class ComentariosMedicoNotifier extends StateNotifier<ComentariosMedicoState> {
  final SatisfaccionPacienteRepository satisfaccionPacienteRepository;

  ComentariosMedicoNotifier({
    required this.satisfaccionPacienteRepository,
    required idMedico,
  }) : super(ComentariosMedicoState(idMedico: idMedico)) {
    cargarComentariosMedico();
  }

  //Funcion para cargar el listado de comentarios
  Future<void> cargarComentariosMedico() async {
    try {
      final comentariosMedico = await satisfaccionPacienteRepository
          .obtenerComentariosPorIdMedico(state.idMedico);

      state = state.copyWith(
        estaCargando: false,
        comentariosMedico: comentariosMedico,
      );
    } catch (e) {
      print(e);
    }
  }
}

//Estado de nuestro provider
class ComentariosMedicoState {
  final String idMedico;
  final List<ComentarioMedico> comentariosMedico;
  final bool estaCargando;

  ComentariosMedicoState({
    required this.idMedico,
    this.comentariosMedico = const [],
    this.estaCargando = true,
  });

  ComentariosMedicoState copyWith({
    String? idMedico,
    List<ComentarioMedico>? comentariosMedico,
    bool? estaCargando,
  }) =>
      ComentariosMedicoState(
        idMedico: idMedico ?? this.idMedico,
        comentariosMedico: comentariosMedico ?? this.comentariosMedico,
        estaCargando: estaCargando ?? this.estaCargando,
      );
}
