import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/miembros_model.dart';

class MiembrosDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarMiembroPlan(MiembrosModel miembro) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO MiembrosPlan (idMiembro,idPlan,idUser,nombre,imagen,apellidoMaterno,apellidoPaterno,puesto,fechaCreacion,estado) "
          "VALUES ('${miembro.idMiembro}','${miembro.idPlan}','${miembro.idUser}','${miembro.nombre}','${miembro.imagen}','${miembro.apellidoMaterno}','${miembro.apellidoPaterno}','${miembro.puesto}','${miembro.fechaCreacion}','${miembro.estado}')");

      return res;
    } catch (exception) {
      return exception;
    }
  }

  Future<List<MiembrosModel>> obtenerMiembrosPlan(String idPlan) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM MiembrosPlan WHERE idPlan='$idPlan' AND estado='1'");

    List<MiembrosModel> list = res.isNotEmpty ? res.map((c) => MiembrosModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteMiembrosPlan() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM MiembrosPlan');

    return res;
  }

  deleteMiembroPlanPorId(String id) async {
    final db = await dbprovider.database;

    final res = await db.rawDelete("DELETE FROM MiembrosPlan WHERE idMiembro='$id' ");

    return res;
  }
}
