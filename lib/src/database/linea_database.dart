import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';

class LineaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarLinea(LineaModel linea) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Lineas (idLinea,idNegocio,idCategoria,lineaNombre,lineaEstado) "
          "VALUES ('${linea.idLinea}','${linea.idNegocio}','${linea.idCategoria}','${linea.lineaNombre}','${linea.lineaEstado}')");

      return res;
    } catch (exception) {
      return exception;
    }
  }

  Future<List<LineaModel>> obtenerLineasPorNegocio(String idNegocio, String idCategoria) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Lineas WHERE idNegocio='$idNegocio' AND idCategoria='$idCategoria' AND lineaEstado!='3'");

    List<LineaModel> list = res.isNotEmpty ? res.map((c) => LineaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<LineaModel>> obtenerLineasPorIdLinea(String idLinea) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Lineas WHERE idLinea='$idLinea'  AND lineaEstado!='3'");

    List<LineaModel> list = res.isNotEmpty ? res.map((c) => LineaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<LineaModel>> obtenerAllLines(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Lineas WHERE idNegocio='$idNegocio'  AND lineaEstado!='3'");

    List<LineaModel> list = res.isNotEmpty ? res.map((c) => LineaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteLinea() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Lineas');

    return res;
  }

  deleteLineaPorIdLinea(String idLinea) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM Lineas WHERE idLinea='$idLinea'");

    return res;
  }
}
