import 'package:mesita_aplication_2/src/api/producto_linea_api.dart';
import 'package:mesita_aplication_2/src/database/productos_linea_database.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductosLineaBloc {
  final _productoDatabase = ProductoLineaDatabase();
  final _productoApi = ProductoLineaApi();

  final _productosLineaController = BehaviorSubject<List<ProductoLineaModel>>();

  Stream<List<ProductoLineaModel>> get productosLineaStream => _productosLineaController.stream;

  void obtenerProductosPorLinea(String idLinea) async {
    _productosLineaController.sink.add(await _productoDatabase.obtenerProductosPorIdLinea(idLinea));
    await _productoApi.obtenerProductosPorLinea(idLinea);
    _productosLineaController.sink.add(await _productoDatabase.obtenerProductosPorIdLinea(idLinea));
  }

  dispose() {
    _productosLineaController?.close();
  }
}
