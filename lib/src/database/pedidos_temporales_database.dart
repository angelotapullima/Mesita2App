import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';

class PedidosTemporalDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarDetallePedidoTemporal(DetallePedidoTemporalModel detalle) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO DetallePedidosTemporales (idMesa,idProducto,foto,nombre,cantidad,subtotal,observaciones,estado, llevar) "
          "VALUES ('${detalle.idMesa}','${detalle.idProducto}','${detalle.foto}','${detalle.nombre}','${detalle.cantidad}','${detalle.subtotal}','${detalle.observaciones}','${detalle.estado}','${detalle.llevar}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<DetallePedidoTemporalModel>> obtenerDetallesPedidoTemporales(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetallePedidosTemporales WHERE idMesa='$idMesa'");

    List<DetallePedidoTemporalModel> list = res.isNotEmpty ? res.map((c) => DetallePedidoTemporalModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteDetallesPedidoTemporal() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetallePedidosTemporales');

    return res;
  }
}
