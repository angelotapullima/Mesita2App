import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/database/pedidos_database.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:rxdart/rxdart.dart';

class PedidosBloc {
  //final _pedidosApi = PedidosApi();
  final pedidosDatabase = PedidosDatabase();

  final _pedidosPorMesaController = BehaviorSubject<List<PedidoModel>>();

  Stream<List<PedidoModel>> get pedidosPorMesaStream => _pedidosPorMesaController.stream;

  void obtenerPedidosPorIdMesa(String idMesa) async {
    final List<PedidoModel> pedixt = [];

    final pedido = await await pedidosDatabase.obtenerPedidosPorIdMesa(idMesa);

    if (pedido.length > 0) {
      final List<DetallePedidoModel> details = [];
      PedidoModel pedidoModel = PedidoModel();

      final detallePedido = await pedidosDatabase.obtenerDetallesPedidoPorIdPedido(pedido[0].idPedido);

      if (detallePedido.length > 0) {
        for (int i = 0; i < detallePedido.length; i++) {
          DetallePedidoModel detallePedidoModel = DetallePedidoModel();

          detallePedidoModel.idPedido = detallePedido[i].idPedido;
          detallePedidoModel.idDetalle = detallePedido[i].idDetalle;
          detallePedidoModel.idProducto = detallePedido[i].idProducto;
          detallePedidoModel.cantidad = detallePedido[i].cantidad;
          detallePedidoModel.subtotal = detallePedido[i].subtotal;
          detallePedidoModel.totalDetalle = detallePedido[i].totalDetalle;
          detallePedidoModel.observaciones = detallePedido[i].observaciones;
          detallePedidoModel.estado = detallePedido[i].estado;
          detallePedidoModel.llevar = detallePedido[i].llevar;
          detallePedidoModel.nombreProducto = detallePedido[i].nombreProducto;
          detallePedidoModel.fotoProducto = detallePedido[i].fotoProducto;

          details.add(detallePedidoModel);
        }
      }

      pedidoModel.idPedido = pedido[0].idPedido;
      pedidoModel.idMesa = pedido[0].idMesa;
      pedidoModel.fecha = pedido[0].fecha;
      pedidoModel.estado = pedido[0].estado;
      pedidoModel.detallesPedido = details;
      pedidoModel.total = pedido[0].total;

      pedixt.add(pedidoModel);
    }

    print('jfjf');
    _pedidosPorMesaController.sink.add(pedixt);
  }
}
