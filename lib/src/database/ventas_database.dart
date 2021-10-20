import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/venta_model.dart';

class VentasDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarVenta(VentaModel venta) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO Ventas (idVenta,idNegocio,idMesa,idPedido,envio,direccion,tipoDoc,serie,correlativo,igv,incluyeIGV,descuento,total,fecha,hora,estado) "
          "VALUES ('${venta.idVenta}','${venta.idNegocio}','${venta.idMesa}','${venta.idPedido}','${venta.envio}','${venta.direccion}','${venta.tipoDoc}','${venta.serie}','${venta.correlativo}','${venta.igv}','${venta.incluyeIGV}','${venta.descuento}','${venta.total}','${venta.fecha}','${venta.hora}','${venta.estado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<VentaModel>> obtenerVentas(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Ventas WHERE idNegocio='$idNegocio'");

    List<VentaModel> list = res.isNotEmpty ? res.map((c) => VentaModel.fromJson(c)).toList() : [];
    return list;
  }

  Future<List<VentaModel>> obtenerVentasPorFecha(String idNegocio, String fechaI, String fechaF) async {
    final db = await dbprovider.database;
    final res =
        await db.rawQuery("SELECT * FROM Ventas WHERE fecha BETWEEN '$fechaI' AND '$fechaF' AND idNegocio='$idNegocio' ORDER BY idVenta DESC");

    List<VentaModel> list = res.isNotEmpty ? res.map((c) => VentaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteVentas() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Ventas');

    return res;
  }
}
