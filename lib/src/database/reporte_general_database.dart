import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_general_model.dart';

class ReporteGeneralDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarReporteGeneral(ReporteGeneralModel reporte) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO ReporteGeneral (id,cantidad,sumaTotal) "
          "VALUES ('${reporte.id}','${reporte.cantidad}','${reporte.sumaTotal}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ReporteGeneralModel>> obtenerReporteGeneralPorId(String id) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM ReporteGeneral WHERE id='$id'");

    List<ReporteGeneralModel> list = res.isNotEmpty ? res.map((c) => ReporteGeneralModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteReporteGeneral() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM ReporteGeneral');

    return res;
  }
}
