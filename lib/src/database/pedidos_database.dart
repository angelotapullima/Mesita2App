import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';

class PedidosDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarMesa(PedidoModel pedido) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Pedidos (idPedido,idMesa,total,fecha, estado) "
          "VALUES ('${pedido.idPedido}','${pedido.idMesa}','${pedido.total}','${pedido.fecha}','${pedido.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<PedidoModel>> obtenerPedidosPorMesa(String idMesa) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Pedidos WHERE idMesa='$idMesa'");

    List<PedidoModel> list = res.isNotEmpty ? res.map((c) => PedidoModel.fromJson(c)).toList() : [];
    return list;
  }

  // Future<List<PedidoModel>> obtenerMesaPorIdMesa(String idMesa) async {
  //   final db = await dbprovider.database;
  //   final res = await db.rawQuery("SELECT * FROM Mesas WHERE idMesa='$idMesa'");

  //   List<PedidoModel> list = res.isNotEmpty ? res.map((c) => PedidoModel.fromJson(c)).toList() : [];
  //   return list;
  // }

  deletePedidos() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Pedidos');

    return res;
  }
}
