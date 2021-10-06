import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';

class ProductoLineaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarProducto(ProductoLineaModel producto) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert(
          "INSERT OR REPLACE INTO ProductosLinea (idProducto,idLinea,productoNombre,productoDescripcion,productoFoto,productoPrecio,productoEstado) "
          "VALUES ('${producto.idProducto}','${producto.idLinea}','${producto.productoNombre}','${producto.productoDescripcion}','${producto.productoFoto}','${producto.productoPrecio}','${producto.productoEstado}')");

      return res;
    } catch (exception) {
      print(exception);
    }
  }

  Future<List<ProductoLineaModel>> obtenerProductosPorIdLinea(String idLinea) async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM ProductosLinea WHERE idLinea='$idLinea'");

    List<ProductoLineaModel> list = res.isNotEmpty ? res.map((c) => ProductoLineaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteLineas() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM ProductosLinea');

    return res;
  }
}
