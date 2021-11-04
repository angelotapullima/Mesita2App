import 'package:mesita_aplication_2/src/api/buscar_usuario_api.dart';
import 'package:mesita_aplication_2/src/models/buscar_user_model.dart';
import 'package:rxdart/rxdart.dart';

class BuscarUserBloc {
  final _buscarApi = BuscarUserApi();
  final _busquedaController = BehaviorSubject<List<BuscarUserModel>>();

  Stream<List<BuscarUserModel>> get busquedaStream => _busquedaController.stream;

  void buscarUsers(String query) async {
    _busquedaController.sink.add(null);
    _busquedaController.sink.add(await _buscarApi.busacarUser(query));
  }
}
