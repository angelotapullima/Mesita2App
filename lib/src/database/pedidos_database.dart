import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';

class PedidosDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarPedido(PedidoModel pedido) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Pedidos (idPedido,idMesa,total,fecha,estado,nombre,direccion,telefono) "
          "VALUES ('${pedido.idPedido}','${pedido.idMesa}','${pedido.total}','${pedido.fecha}','${pedido.estado}','${pedido.nombre}','${pedido.direccion}','${pedido.telefono}')");

      return res;
    } catch (exception) {
      return exception;
    }
  }

  insertarDetallePedido(DetallePedidoModel detalle) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO DetallePedidos (idDetalle,idPedido,idProducto,nombreProducto,fotoProducto,"
          "cantidad,subtotal,"
          "totalDetalle,observaciones,estado,llevar) "
          "VALUES ('${detalle.idDetalle}','${detalle.idPedido}','${detalle.idProducto}','${detalle.nombreProducto}',"
          "'${detalle.fotoProducto}','${detalle.cantidad}','${detalle.subtotal}','${detalle.totalDetalle}','${detalle.observaciones}',"
          "'${detalle.estado}','${detalle.llevar}')");

      return res;
    } catch (exception) {
      return exception;
    }
  }

  Future<List<PedidoModel>> obtenerPedidosPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Pedidos WHERE idMesa='$idMesa'");

    List<PedidoModel> list = res.isNotEmpty ? res.map((c) => PedidoModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<DetallePedidoModel>> obtenerDetallesPedidoPorIdPedido(String idPedido) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM DetallePedidos WHERE idPedido='$idPedido'");

    List<DetallePedidoModel> list = res.isNotEmpty ? res.map((c) => DetallePedidoModel.fromJson(c)).toList() : [];
    return list;
  }

  deletePedidos() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Pedidos');

    return res;
  }

  deleteDetallesPedido() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM DetallePedidos');

    return res;
  }

  deletePedidoPorIdMesa(String idMesa) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Pedidos WHERE idMesa='$idMesa'");

    return res;
  }

  deletePedidoPorIdPedido(String idPedido) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Pedidos WHERE idPedido='$idPedido'");

    return res;
  }

  deleteDetallesPedidoPorId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DetallePedidos WHERE idDetalle='$id'");

    return res;
  }

  deleteDetallesPedidoPorIdPedido(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM DetallePedidos WHERE idPedido='$id'");

    return res;
  }
}
