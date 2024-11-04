import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
import 'package:medifinder_crm/features/solicitudMedico/presentation/providers/solicitud_medico_repository_provider.dart';

// Este archivo es nuestro manejador de estados, es donde se encuentran todas las funciones que manejan los estados del módulo
// Qué información se encuentra actualmente en el módulo, y qué acciones se pueden realizar en el módulo
// Es muy parecido al que se realiza en React

// Paso 3: Crear el StateNotifierProvider
// StateNotifierProvider
// Este nos sirve para conectar el repositorio y el front
// El autoDispose limpia la información cada vez que se cierra el módulo o, en su defecto, cuando se deja de utilizar el provider
final solicitudMedicoProvider = StateNotifierProvider.autoDispose<
    SolicitudMedicoNotifier, SolicitudMedicoState>((ref) {
  // El ref.watch sirve para escuchar lo que se realiza en el provider
  final solicitudMedicoRepository =
      ref.watch(SolicitudMedicoRepositoryProvider);

  return SolicitudMedicoNotifier(solicitudMedicoRepository);
});

// Paso 2: crear el notifier
// Notifier
class SolicitudMedicoNotifier extends StateNotifier<SolicitudMedicoState> {
  final SolicitudMedicoRepository solicitudMedicoRepository;

  SolicitudMedicoNotifier(this.solicitudMedicoRepository)
      : super(SolicitudMedicoState()) {
    // Aquí puedes mandar a llamar un método que se ejecutará cada vez que se acceda al módulo,
    // o en su defecto, cada que se cree este manejador de estados
    obtenerSolicitudes(); // Llama al método para cargar solicitudes al iniciar
  }

  // Este método es el que carga la lista inicial de solicitudes
  // Es el que puedes mandar a llamar aquí arriba
  Future<void> obtenerSolicitudes() async {
    // Cambiamos el parámetro de "esta cargando" a true
    state = state.copyWith(estaCargando: true);

    try {
      final response =
          await solicitudMedicoRepository.obtenerSolicitudesMedico();
      state = state.copyWith(estaCargando: false, listaSolicitudes: response);
    } catch (e) {
      state = state.copyWith(estaCargando: false);
    }
  }

  Future<bool> confirmarSolicitudMedico(String idSolicitud) async {
    try {
      final success =
          await solicitudMedicoRepository.confirmarSolicitudMedico(idSolicitud);
      if (success) {
        await obtenerSolicitudes();
      }
      return success;
    } catch (e) {
      return false;
    }
  }
}

// Paso 1: Crear el state
// State
class SolicitudMedicoState {
  // Los parámetros que tendrá el estado
  final bool estaCargando;
  final List<SolicutudMedico> listaSolicitudes;

  // Constructor que inicializa la información
  SolicitudMedicoState({
    this.estaCargando = false,
    this.listaSolicitudes = const [],
  });

  // Método que realiza el cambio de estado
  SolicitudMedicoState copyWith(
          {bool? estaCargando, List<SolicutudMedico>? listaSolicitudes}) =>
      SolicitudMedicoState(
          estaCargando: estaCargando ?? this.estaCargando,
          listaSolicitudes: listaSolicitudes ?? this.listaSolicitudes);
}
