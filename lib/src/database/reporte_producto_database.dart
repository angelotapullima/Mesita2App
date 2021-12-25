import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_producto_model.dart';

class ReporteProductoDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarReportProducto(ReporteProductoModel product) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO ReportesProductos (idProducto,idNegocio,estado,cantidad,suma) "
          "VALUES ('${product.idProducto}','${product.idNegocio}','${product.estado}','${product.cantidad}','${product.suma}')");

      return res;
    } catch (exception) {
      return exception;
    }
  }

  Future<List<ReporteProductoModel>> obtenerProductoMasVendidos(String idNegocio) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM ReportesProductos WHERE idNegocio='$idNegocio' ORDER BY cast(cantidad as int) DESC");

    List<ReporteProductoModel> list = res.isNotEmpty ? res.map((c) => ReporteProductoModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteReportProduct() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM ReportesProductos');

    return res;
  }
}
