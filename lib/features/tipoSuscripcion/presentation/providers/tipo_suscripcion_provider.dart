import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/tipoSuscripcion/domain/domain.dart';
import 'tipo_suscripcion_repository_provider.dart';

//StateNotifierProvider
final tipoSuscripcionProvider =
    StateNotifierProvider<TipoSuscripcionNotifier, TipoSuscripcionState>((ref) {
  final tipoSuscripcionRepository =
      ref.watch(tipoSuscripcionRepositoryProvider);

  return TipoSuscripcionNotifier(
      tipoSuscripcionRepository: tipoSuscripcionRepository);
});

//Notifier
class TipoSuscripcionNotifier extends StateNotifier<TipoSuscripcionState> {
  //Principalmente necesito el repositorio, no el impl
  final TipoSuscripcionRepository tipoSuscripcionRepository;

  //Se crea el constructor con un parametro requerido del repositorio, tambien se inicializa el estado
  TipoSuscripcionNotifier({required this.tipoSuscripcionRepository})
      : super(TipoSuscripcionState());

  //Funciones del provider
  Future obtenerTiposSuscripciones() async {
    //Cambia el estado para notificar que esta cargando
    state = state.copyWith(
      estaCargando: true,
    );

    //ejecutamos la funcion del repositorio
    final responseTiposSuscripciones =
        await tipoSuscripcionRepository.obtenerTiposSuscripciones();

    //Validamos si esta vacia
    if (responseTiposSuscripciones.isEmpty) {
      state = state.copyWith(
        estaCargando: false,
      );
      return;
    }

    //Sino actualizamos el estado
    state = state.copyWith(
      estaCargando: false,
      tiposSuscripcion: responseTiposSuscripciones,
    );
  }
}

//State
class TipoSuscripcionState {
  //Colocamos el tipo de variables que manejaran el estado de mi provider
  final bool estaCargando;
  final List<TipoSuscripcion> tiposSuscripcion;

  //Las inicializamos
  TipoSuscripcionState({
    this.estaCargando = false,
    this.tiposSuscripcion = const [],
  });

  //La funcion copyWith sirve para hacer la actualizacion del estado
  //Todos los campos deben de ser opcionales
  TipoSuscripcionState copyWith({
    bool? estaCargando,
    List<TipoSuscripcion>? tiposSuscripcion,
  }) =>
      TipoSuscripcionState(
        //Evaluamos si se reciobio un parametro, sino colocamos el que actualmente esta
        estaCargando: estaCargando ?? this.estaCargando,
        tiposSuscripcion: tiposSuscripcion ?? this.tiposSuscripcion,
      );
}
