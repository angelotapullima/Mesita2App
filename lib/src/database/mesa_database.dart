import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';

class MesaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarMesa(MesaModel mesa) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Mesas (idMesa,idNegocio,mesaNombre,mesaEstado) "
          "VALUES ('${mesa.idMesa}','${mesa.idNegocio}','${mesa.mesaNombre}','${mesa.mesaEstado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<MesaModel>> obtenerMesasPorNegocio(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Mesas WHERE idNegocio='$idNegocio'");

    List<MesaModel> list = res.isNotEmpty ? res.map((c) => MesaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteMesas() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Mesas');

    return res;
  }
}
