import 'package:mesita_aplication_2/src/api/linea_api.dart';
import 'package:mesita_aplication_2/src/database/productos_linea_database.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:rxdart/rxdart.dart';

class ProductosLineaBloc {
  final _productoDatabase = ProductoLineaDatabase();
  final _lineaApi = LineaApi();

  final _productosLineaController = BehaviorSubject<List<ProductoLineaModel>>();
  final _productoController = BehaviorSubject<List<ProductoLineaModel>>();
  final _productosPedidosController = BehaviorSubject<List<ProductoLineaModel>>();

  final _productosBusquedaController = BehaviorSubject<List<ProductoLineaModel>>();

  Stream<List<ProductoLineaModel>> get productosLineaStream => _productosLineaController.stream;
  Stream<List<ProductoLineaModel>> get productoStream => _productoController.stream;
  Stream<List<ProductoLineaModel>> get productoPedidosStream => _productosPedidosController.stream;
  Stream<List<ProductoLineaModel>> get productoBusquedaStream => _productosBusquedaController.stream;

  void obtenerProductosPorLinea(String idLinea) async {
    _productosLineaController.sink.add([]);
    _productosLineaController.sink.add(await _productoDatabase.obtenerProductosPorIdLinea(idLinea));
  }

  void updateProductosPorLinea(String idLinea) async {
    _productosLineaController.sink.add([]);
    await _lineaApi.obtenerLineasPorNegocio();
    _productosLineaController.sink.add(await _productoDatabase.obtenerProductosPorIdLinea(idLinea));
  }

  void obtenerProductoPorIdProducto(String idProducto, String idLinea) async {
    _productoController.sink.add(await _productoDatabase.obtenerProductosPorIdProducto(idProducto));
  }

  void updateProductoPorIdProducto(String idProducto, String idLinea) async {
    _productoController.sink.add(await _productoDatabase.obtenerProductosPorIdProducto(idProducto));
    await _lineaApi.obtenerLineasPorNegocio();
    _productoController.sink.add(await _productoDatabase.obtenerProductosPorIdProducto(idProducto));
  }

  void obtenerProductosPorLineaParaPedidos(String idLinea) async {
    _productosPedidosController.sink.add(await _productoDatabase.obtenerProductosPorIdLinea(idLinea));
  }

  void obtenerProductosPorQuery(String query) async {
    _productosBusquedaController.sink.add(await _productoDatabase.buscarProducto(query));
  }

  dispose() {
    _productosLineaController?.close();
    _productoController?.close();
    _productosPedidosController?.close();
    _productosBusquedaController?.close();
  }
}
