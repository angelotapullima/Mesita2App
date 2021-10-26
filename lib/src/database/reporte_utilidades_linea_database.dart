import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_utilidades_linea_model.dart';

class ReporteUtilidadesLineaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarReportUtilidadLinea(ReporteUtilidadesLineaModel linea) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO ReportesUtilidadesLineas (idLinea,idNegocio,idCategoria,nombre,estado,cantidad,suma) "
          "VALUES ('${linea.idLinea}','${linea.idNegocio}','${linea.idCategoria}','${linea.nombre}','${linea.estado}','${linea.cantidad}','${linea.suma}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ReporteUtilidadesLineaModel>> obtenerReportUtilidadLinea(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM ReportesUtilidadesLineas WHERE idNegocio='$idNegocio' ORDER BY cast(cantidad as int) DESC");

    List<ReporteUtilidadesLineaModel> list = res.isNotEmpty ? res.map((c) => ReporteUtilidadesLineaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteReportUtilidadLinea() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM ReportesUtilidadesLineas');

    return res;
  }
}
