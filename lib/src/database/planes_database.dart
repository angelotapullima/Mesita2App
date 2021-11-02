import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';

class PlanesDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarPlan(PlanesModel plan) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Planes (idPlan,nombre,descripcion,costo,estado) "
          "VALUES ('${plan.idPlan}','${plan.nombre}','${plan.descripcion}','${plan.costo}','${plan.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<PlanesModel>> obtenerPlanes() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Planes WHERE estado='1'");

    List<PlanesModel> list = res.isNotEmpty ? res.map((c) => PlanesModel.fromJson(c)).toList() : [];
    return list;
  }

  deletePlanes() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Planes');

    return res;
  }
}
