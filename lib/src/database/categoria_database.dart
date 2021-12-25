import 'package:mesita_aplication_2/src/database/database_provider.dart';
import 'package:mesita_aplication_2/src/models/categoria_model.dart';

class CategoriaDatabase {
  final dbprovider = DatabaseProvider.db;

  insertarCategoria(CategoriaModel categoria) async {
    try {
      final db = await dbprovider.database;

      final res = await db.rawInsert("INSERT OR REPLACE INTO Categorias (idCategoria,categoriaNombre,categoriaEstado) "
          "VALUES ('${categoria.idCategoria}','${categoria.categoriaNombre}','${categoria.categoriaEstado}')");

      return res;
    } catch (exception) {
      return exception;
    }
  }

  Future<List<CategoriaModel>> obtenerCategorias() async {
    final db = await dbprovider.database;
    final res = await db.rawQuery("SELECT * FROM Categorias");

    List<CategoriaModel> list = res.isNotEmpty ? res.map((c) => CategoriaModel.fromJson(c)).toList() : [];
    return list;
  }

  deleteCategorias() async {
    final db = await dbprovider.database;

    final res = await db.rawDelete('DELETE FROM Categorias');

    return res;
  }
}
