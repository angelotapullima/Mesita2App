import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';

class LineaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarLinea(LineaModel linea) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Lineas (idLinea,idNegocio,lineaNombre,lineaEstado) "
          "VALUES ('${linea.idLinea}','${linea.idNegocio}','${linea.lineaNombre}','${linea.lineaEstado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<LineaModel>> obtenerLineasPorNegocio(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Lineas WHERE idNegocio='$idNegocio'");

    List<LineaModel> list = res.isNotEmpty ? res.map((c) => LineaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteLinea() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Lineas');

    return res;
  }
}
