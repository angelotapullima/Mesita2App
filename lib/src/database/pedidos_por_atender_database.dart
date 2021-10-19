import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_atender_model.dart';

class PedidosAtenderDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarPedidoAtender(PedidosAtenderModel detalle) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO PedidosPorAtender (idPedidoDetalle,idNegocio,idMesa,idProducto,nombreProducto,mesaNombre,fotoProducto,cantidad,fecha,estado) "
          "VALUES ('${detalle.idPedidoDetalle}','${detalle.idNegocio}','${detalle.idMesa}','${detalle.idProducto}','${detalle.nombreProducto}','${detalle.mesaNombre}','${detalle.fotoProducto}','${detalle.cantidad}','${detalle.fecha}','${detalle.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<PedidosAtenderModel>> obtenerPedidoAtender(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM PedidosPorAtender WHERE idNegocio='$idNegocio'");

    List<PedidosAtenderModel> list = res.isNotEmpty ? res.map((c) => PedidosAtenderModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<PedidosAtenderModel>> obtenerPedidoAtenderPorId(String idPedidoDetalle) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM PedidosPorAtender WHERE idPedidoDetalle='$idPedidoDetalle'");

    List<PedidosAtenderModel> list = res.isNotEmpty ? res.map((c) => PedidosAtenderModel.fromJson(c)).toList() : [];
    return list;
  }

  deletePedidoAtender() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM PedidosPorAtender');

    return res;
  }
}
