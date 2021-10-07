import 'package:mesita_aplication_2/src/api/categoria_api.dart';
import 'package:mesita_aplication_2/src/database/categoria_database.dart';
import 'package:mesita_aplication_2/src/models/categoria_model.dart';
import 'package:rxdart/rxdart.dart';

class CategoriaBloc {
  final _categoriaDatabase = CategoriaDatabase();
  final _categoriaApi = CategoriaApi();
  final _categoriasController = BehaviorSubject<List<CategoriaModel>>();

  Stream<List<CategoriaModel>> get categoriasStream => _categoriasController.stream;

  void obtenerCategoriasb() async {
    _categoriasController.sink.add(await _categoriaDatabase.obtenerCategorias());
    await _categoriaApi.obtenerCategorias();
    _categoriasController.sink.add(await _categoriaDatabase.obtenerCategorias());
  }

  dispose() {
    _categoriasController?.close();
  }
}
