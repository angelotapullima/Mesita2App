import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/database/pedidos_por_atender_database.dart';
import 'package:mesita_aplication_2/src/models/pedidos_atender_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class PedidosAtenderBloc {
  final _pedidosApi = PedidosApi();
  final _pedidosAtenderDatabase = PedidosAtenderDatabase();
  final _prefs = Preferences();

  final _atenderController = BehaviorSubject<List<PedidosAtenderModel>>();

  Stream<List<PedidosAtenderModel>> get atenderStream => _atenderController.stream;

  void obtenerPedidosAtenderPorEmpresa() async {
    _atenderController.sink.add(await _pedidosAtenderDatabase.obtenerPedidoAtender(_prefs.idNegocio));
    await _pedidosApi.obtenerPedidosPorAtender();
    _atenderController.sink.add(await _pedidosAtenderDatabase.obtenerPedidoAtender(_prefs.idNegocio));
  }

  dispose() {
    _atenderController?.close();
  }
}
