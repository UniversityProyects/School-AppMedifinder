import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/solicitudMedico/domain/domain.dart';
import 'package:medifinder_crm/features/solicitudMedico/presentation/providers/solicitud_medico_repository_provider.dart';

//Este archivo es nuestro manejador de estados, es donde  se encuentran todas las funciones que manejan los estados del modulo
//Que informacion se encuentra actualmente en el modulo, y que acciones se pueden realizar en el modulo
//Es muy parecido al que se realiza en react

//Paso 3: Crear el statenotifierProvider
//StateNotifierProvider
//Este nos sirve para conectar el repositorio y el front
//El autodispose limpia la informacion cada que se cierra el modulo o en su defecto cuando se deja de utilizar el provider
final solicitudMedicoProvider = StateNotifierProvider.autoDispose<
    SolicitudMedicoNotifier, SolicitudMedicoState>((ref) {
  //El ref.watch sirve para escuchar lo que se realiza en el provider
  final solicitudMedicoRepository =
      ref.watch(SolicitudMedicoRepositoryProvider);

  return SolicitudMedicoNotifier(solicitudMedicoRepository);
});

//Paso 2: crear el notifier
//Notifier
class SolicitudMedicoNotifier extends StateNotifier<SolicitudMedicoState> {
  final SolicitudMedicoRepository solicitudMedicoRepository;
  SolicitudMedicoNotifier(this.solicitudMedicoRepository)
      : super(SolicitudMedicoState()) {
    //Aqui puedes mandar a llamar el un metodo que se ejecutara cada vez que se acceda al modulo, o en su defecto cada que se cree este manejador de estados
    //obtenerSolicitudes();
  }

  //Este metodo es el que carga la lista inicial de solicitudes es el que puedes mandar a llamar aqui arriba
  /*
  Future obtenerSolicitudes() async {
    //Cambiamos el parametro de esta cargando a true
    state = state.copyWith(estaCargando: true);

    //Llamada el metodo que esta definido en el repository
    final response =
        await solicitudMedicoRepository.obtenerSolicitudesMedico();

    // Asegúrate de que siempre haya un cambio en el estado
    state = state.copyWith(estaCargando: false, listaSolicitudes: []);
    state = state.copyWith(listaSolicitudes: response);
  }
  */
}

//Paso 1: Crear el state
//State
class SolicitudMedicoState {
  //Los parametros que tendra el estado
  final bool estaCargando;
  final List<SolicutudMedico> listaSolicitudes;

  //Contructor que inicializa la informacion
  SolicitudMedicoState({
    this.estaCargando = false,
    this.listaSolicitudes = const [],
  });

  //Metodo que realiza el cambio de estado
  SolicitudMedicoState copyWith(
          {bool? estaCargando, List<SolicutudMedico>? listaSolicitudes}) =>
      SolicitudMedicoState(
          estaCargando: estaCargando ?? this.estaCargando,
          listaSolicitudes: listaSolicitudes ?? this.listaSolicitudes);
}
