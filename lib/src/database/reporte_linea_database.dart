import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_linea_model.dart';

class ReporteLineaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarReportLinea(ReporteLineaModel linea) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO ReportesLineas (idLinea,idNegocio,idCategoria,nombre,estado,cantidad,suma) "
          "VALUES ('${linea.idLinea}','${linea.idNegocio}','${linea.idCategoria}','${linea.nombre}','${linea.estado}','${linea.cantidad}','${linea.suma}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ReporteLineaModel>> obtenerReportLinea(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM ReportesLineas WHERE idNegocio='$idNegocio' ORDER BY cast(cantidad as int) DESC");

    List<ReporteLineaModel> list = res.isNotEmpty ? res.map((c) => ReporteLineaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteReportLinea() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM ReportesLineas');

    return res;
  }
}
