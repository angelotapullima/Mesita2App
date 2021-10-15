import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';

class PedidosDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarDetallePedidoTemporal(DetallePedidoTemporalModel detalle) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO DetallePedidosTemporales (id,idMesa,idProducto,cantidad,subtotal,observaciones,estado, llevar) "
          "VALUES ('${detalle.id}','${detalle.idMesa}','${detalle.idProducto}','${detalle.cantidad}','${detalle.subtotal}','${detalle.observaciones}','${detalle.estado}',,'${detalle.llevar}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<DetallePedidoTemporalModel>> obtenerDetallesPedidoTemporales() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetallePedidosTemporales");

    List<DetallePedidoTemporalModel> list = res.isNotEmpty ? res.map((c) => DetallePedidoTemporalModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteDetallesPedidoTemporal() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetallePedidosTemporales');

    return res;
  }
}
