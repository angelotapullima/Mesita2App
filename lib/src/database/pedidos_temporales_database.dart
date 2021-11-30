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

  Future<List<DetallePedidoTemporalModel>> obtenerDetallePedidoTemporalePorId(String idProducto, String llevar, String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetallePedidosTemporales WHERE idProducto='$idProducto' AND llevar='$llevar' AND idMesa='$idMesa'");

    List<DetallePedidoTemporalModel> list = res.isNotEmpty ? res.map((c) => DetallePedidoTemporalModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteDetallesPedidoTemporal() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetallePedidosTemporales');

    return res;
  }

  updateDetallePorIdPedidoDetalle(DetallePedidoTemporalModel detalle) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawUpdate("UPDATE DetallePedidosTemporales SET idMesa='${detalle.idMesa}',"
          "idProducto='${detalle.idProducto}',"
          "foto='${detalle.foto}',"
          "nombre='${detalle.nombre}',"
          "cantidad='${detalle.cantidad}',"
          "subtotal='${detalle.subtotal}',"
          "observaciones='${detalle.observaciones}',"
          "llevar='${detalle.llevar}',"
          "estado='${detalle.estado}' WHERE id='${detalle.id}' AND idMesa='${detalle.idMesa}'");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  deleteDetallesPedidoTemporalPorId(int id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DetallePedidosTemporales WHERE id='$id'");

    return res;
  }
}
