import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/plan_user_model.dart';

class PlanUserDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarPlanUser(PlanUserModel plan) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO PlanUser (idUserPlan,idUser,idNegocio,idPlan,inicioFecha,finFecha,voucher,estado) "
          "VALUES ('${plan.idUserPlan}','${plan.idUser}','${plan.idNegocio}','${plan.idPlan}','${plan.inicioFecha}','${plan.finFecha}','${plan.voucher}','${plan.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<PlanUserModel>> obtenerPlanUser(String idUser) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM PlanUser WHERE idUser='$idUser' AND estado='1'");

    List<PlanUserModel> list = res.isNotEmpty ? res.map((c) => PlanUserModel.fromJson(c)).toList() : [];
    return list;
  }

  deletePlanUser() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM PlanUser');

    return res;
  }
}
