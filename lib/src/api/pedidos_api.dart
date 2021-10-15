import 'package:mesita_aplication_2/src/database/pedidos_database.dart';
import 'package:mesita_aplication_2/src/database/productos_linea_database.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';

class PedidosApi {
  final _pedidosDatabase = PedidosDatabase();
  final _productosDatabase = ProductoLineaDatabase();

  Future<List<PedidoModel>> obtenerPedidosPorIdMesa(String idMesa) async {
    final List<PedidoModel> listaReturnPedidos = [];

    final listaPedidos = await _pedidosDatabase.obtenerPedidosPorIdMesa(idMesa);

    if (listaPedidos.length > 0) {
      for (var i = 0; i < listaPedidos.length; i++) {
        PedidoModel pedidos = PedidoModel();

        pedidos.idPedido = listaPedidos[i].idPedido;
        pedidos.idMesa = listaPedidos[i].idMesa;
        pedidos.total = listaPedidos[i].total;
        pedidos.fecha = listaPedidos[i].fecha;
        pedidos.estado = listaPedidos[i].fecha;

        final List<DetallePedidoModel> listDetalles = [];
        final listaDetallesPedido = await _pedidosDatabase.obtenerDetallesPedidoPorIdPedido(listaPedidos[i].idPedido);

        for (var x = 0; x < listaDetallesPedido.length; x++) {
          DetallePedidoModel detalles = DetallePedidoModel();

          detalles.idDetalle = listaDetallesPedido[x].idDetalle;
          detalles.idPedido = listaDetallesPedido[x].idPedido;
          detalles.idProducto = listaDetallesPedido[x].idProducto;
          detalles.cantidad = listaDetallesPedido[x].cantidad;
          detalles.totalDetalle = listaDetallesPedido[x].totalDetalle;
          detalles.observaciones = listaDetallesPedido[x].observaciones;
          detalles.estado = listaDetallesPedido[x].estado;
          detalles.llevar = listaDetallesPedido[x].llevar;

          final productoDB = await _productosDatabase.obtenerProductosPorIdProducto(listaDetallesPedido[x].idProducto);

          if (productoDB.length > 0) {
            detalles.subtotal = productoDB[0].productoPrecio;
            detalles.nombreProducto = productoDB[0].productoNombre;
            detalles.fotoProducto = productoDB[0].productoFoto;
          }

          listDetalles.add(detalles);
        }

        pedidos.detallesPedido = listDetalles;

        listaReturnPedidos.add(pedidos);
      }
    }
    return listaReturnPedidos;
  }
}
