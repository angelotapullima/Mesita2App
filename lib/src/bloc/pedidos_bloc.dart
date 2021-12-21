import 'package:mesita_aplication_2/src/api/mesa_api.dart';
import 'package:mesita_aplication_2/src/database/pedidos_database.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:rxdart/rxdart.dart';

class PedidosBloc {
  final pedidosDatabase = PedidosDatabase();
  final _mesaApi = MesaApi();

  final _pedidosPorMesaController = BehaviorSubject<List<PedidoModel>>();
  final _pedidosParaLlevarController = BehaviorSubject<List<PedidoModel>>();
  final _pedidosDeliveryController = BehaviorSubject<List<PedidoModel>>();

  Stream<List<PedidoModel>> get pedidosPorMesaStream => _pedidosPorMesaController.stream;
  Stream<List<PedidoModel>> get pedidosParaLlevarStream => _pedidosParaLlevarController.stream;
  Stream<List<PedidoModel>> get pedidosDeliveryStream => _pedidosDeliveryController.stream;

  void obtenerPedidosPorIdMesa(String idMesa) async {
    _pedidosPorMesaController.sink.add(null);
    await _mesaApi.obtenerMesasPorNegocio();
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
    _pedidosPorMesaController.sink.add(pedixt);
  }

  void obtenerPedidosPorIdMesaParaLlevarYDelivery(String idMesa, String tipo) async {
    _pedidosPorMesaController.sink.add(null);

    await _mesaApi.obtenerMesasPorNegocio();

    final List<PedidoModel> pedixt = [];

    final pedido = await await pedidosDatabase.obtenerPedidosPorIdMesa(idMesa);

    if (pedido.length > 0) {
      print('Hay pedidos');
      for (var x = 0; x < pedido.length; x++) {
        final List<DetallePedidoModel> details = [];
        PedidoModel pedidoModel = PedidoModel();

        final detallePedido = await pedidosDatabase.obtenerDetallesPedidoPorIdPedido(pedido[x].idPedido);

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
          pedidoModel.idPedido = pedido[x].idPedido;
          pedidoModel.idMesa = pedido[x].idMesa;
          pedidoModel.fecha = pedido[x].fecha;
          pedidoModel.estado = pedido[x].estado;
          pedidoModel.detallesPedido = details;
          pedidoModel.total = pedido[x].total;
          pedidoModel.nombre = pedido[x].nombre;
          pedidoModel.direccion = pedido[x].direccion;
          pedidoModel.telefono = pedido[x].telefono;

          pedixt.add(pedidoModel);
        }
      }
    }
    if (tipo == '1') {
      _pedidosParaLlevarController.sink.add(pedixt);
    } else {
      _pedidosDeliveryController.sink.add(pedixt);
    }
  }
}
