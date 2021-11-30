import 'package:mesita_aplication_2/src/database/pedidos_temporales_database.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';

class ComandaTemporalApi {
  final _comandaTemporalDatabase = PedidosTemporalDatabase();
  Future<int> updateDetalle(DetallePedidoTemporalModel dato, int cantidad) async {
    try {
      if (int.parse(dato.cantidad) == 1 && cantidad < 0) {
        final res = await _comandaTemporalDatabase.deleteDetallesPedidoTemporalPorId(dato.id);
        if (res > 0) {
          return 1;
        } else {
          return 2;
        }
      } else {
        int newCant = int.parse(dato.cantidad) + cantidad;

        double total = double.parse(dato.subtotal) + (cantidad * (double.parse(dato.subtotal) / int.parse(dato.cantidad)));
        DetallePedidoTemporalModel detalle = DetallePedidoTemporalModel();
        detalle.id = dato.id;
        detalle.idMesa = dato.idMesa;
        detalle.nombre = dato.nombre;
        detalle.idProducto = dato.idProducto;
        detalle.foto = dato.foto;
        detalle.cantidad = newCant.toString();
        detalle.subtotal = total.toStringAsFixed(2);
        detalle.observaciones = dato.observaciones;
        detalle.llevar = dato.llevar;
        final res = await _comandaTemporalDatabase.updateDetallePorIdPedidoDetalle(detalle);
        if (res > 0) {
          return 1;
        } else {
          return 2;
        }
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> guardarDetallePedidoTemporal(DetallePedidoTemporalModel comanda) async {
    try {
      final _listProducto = await _comandaTemporalDatabase.obtenerDetallePedidoTemporalePorId(comanda.idProducto, comanda.llevar, comanda.idMesa);
      if (_listProducto.length > 0) {
        print('YA HAY AHORA A ACTUALIZAR');
        DetallePedidoTemporalModel detalle = DetallePedidoTemporalModel();
        detalle.id = _listProducto[0].id;
        detalle.idMesa = _listProducto[0].idMesa;
        detalle.nombre = comanda.nombre;
        detalle.idProducto = _listProducto[0].idProducto;
        detalle.foto = _listProducto[0].foto;
        detalle.cantidad = (int.parse(comanda.cantidad) + int.parse(_listProducto[0].cantidad)).toString();

        detalle.subtotal = (double.parse(_listProducto[0].subtotal) +
                (int.parse(comanda.cantidad) * (double.parse(_listProducto[0].subtotal) / int.parse(_listProducto[0].cantidad))))
            .toStringAsFixed(2);
        detalle.observaciones = _listProducto[0].observaciones;
        detalle.llevar = _listProducto[0].llevar;
        detalle.estado = _listProducto[0].estado;
        final res = await _comandaTemporalDatabase.updateDetallePorIdPedidoDetalle(detalle);
        if (res > 0) {
          return 1;
        } else {
          return 2;
        }
      } else {
        print('NO HAY AHORA A GENERAL NUEVO');
        final res = await _comandaTemporalDatabase.insertarDetallePedidoTemporal(comanda);
        if (res > 0) {
          return 1;
        } else {
          return 2;
        }
      }
    } catch (e) {
      return 2;
    }
  }
}
