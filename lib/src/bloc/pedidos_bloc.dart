import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:rxdart/rxdart.dart';

class PedidosBloc {
  final _pedidosApi = PedidosApi();

  final _pedidosPorMesaController = BehaviorSubject<List<PedidoModel>>();

  Stream<List<PedidoModel>> get pedidosPorMesaStream => _pedidosPorMesaController.stream;

  void obtenerPedidosPorIdMesa(String idMesa) async {
    _pedidosPorMesaController.sink.add(await _pedidosApi.obtenerPedidosPorIdMesa(idMesa));
  }
}
