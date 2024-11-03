import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medifinder_crm/features/suscripcionMedico/domain/domain.dart';
import '../providers/suscripcion_medico_repository_provider.dart';

//Paso3: StateNotifierProvider
final suscripcionMedicoProvider =
    StateNotifierProvider<SuscripcionMedicoNotifier, SuscripcionMedicoState>(
        (ref) {
  //Variable que estará monitoreando el estado
  final suscripcionMedicoRepository =
      ref.watch(suscripcionMedicoRepositoryProvider);

  //Retorno de provider
  return SuscripcionMedicoNotifier(
      suscripcionMedicoRepository: suscripcionMedicoRepository);
});

//Paso2: Notifier
class SuscripcionMedicoNotifier extends StateNotifier<SuscripcionMedicoState> {
  //Reposotorio donde se obtendrán los datos
  final SuscripcionMedicoRepository suscripcionMedicoRepository;

  //Constructor e inicializador del estado
  SuscripcionMedicoNotifier({required this.suscripcionMedicoRepository})
      : super(SuscripcionMedicoState());

  //Funcion para cargar los datos iniciales del modulo
  Future obtenerListadoSuscripcionesMedicos() async {
    //Cambio de estado para notificar que se esta cargando
    state = state.copyWith(
      estCargando: true,
    );

    //Llamada al metodo que obtiene el listado de suscripciones
    final respuestaSuscripcionMedico =
        await suscripcionMedicoRepository.obtenerListadoSuscripcionesMedicos();

    //Verificacion si la lista esta vacia
    if (respuestaSuscripcionMedico.isEmpty) {
      state = state.copyWith(
        estCargando: false,
      );
      return;
    }

    //Cambiamos el estado y colocamos los resultados en la lista
    state = state.copyWith(
      estCargando: false,
      listaSuscripcionMedico: respuestaSuscripcionMedico,
    );
  }
}

//Paso 1: State
class SuscripcionMedicoState {
  //Variables que manejaran el estado de mi provider
  final bool estCargando;
  final List<SuscripcionMedico> listaSuscripcionMedico;

  //Constructor para inicializar los parametros
  SuscripcionMedicoState({
    this.estCargando = false,
    this.listaSuscripcionMedico = const [],
  });

  //Copywith para cambiar el valor de nuestro estado
  SuscripcionMedicoState copyWith({
    bool? estCargando,
    List<SuscripcionMedico>? listaSuscripcionMedico,
  }) =>
      SuscripcionMedicoState(
        estCargando: estCargando ?? this.estCargando,
        listaSuscripcionMedico:
            listaSuscripcionMedico ?? this.listaSuscripcionMedico,
      );
}
