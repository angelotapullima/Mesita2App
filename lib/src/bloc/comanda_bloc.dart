import 'package:mesita_aplication_2/src/database/pedidos_temporales_database.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';
import 'package:rxdart/rxdart.dart';

class ComandaBloc {
  final _comandaDatabase = PedidosTemporalDatabase();

  final _comandaController = BehaviorSubject<List<DetallePedidoTemporalModel>>();

  Stream<List<DetallePedidoTemporalModel>> get comandaStream => _comandaController.stream;

  void obtenerComandaPorMesa(String idMesa) async {
    _comandaController.sink.add(await _comandaDatabase.obtenerDetallesPedidoTemporales(idMesa));
  }

  dispose() {
    _comandaController?.close();
  }
}
