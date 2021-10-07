import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/productos_linea_database.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class ProductoLineaApi {
  final _prefs = Preferences();
  final _productoDatabase = ProductoLineaDatabase();

  Future<bool> obtenerProductosPorLinea(String idLinea) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_productos_por_linea');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id_linea': '$idLinea',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      if (decodedData['result'].length > 0) {
        for (var i = 0; i < decodedData['result'].length; i++) {
          ProductoLineaModel producto = ProductoLineaModel();
          producto.idProducto = decodedData['result'][i]['id_producto'];
          producto.idLinea = decodedData['result'][i]['id_linea'];
          producto.productoNombre = decodedData['result'][i]['producto_nombre'];
          producto.productoDescripcion = decodedData['result'][i]['producto_descripcion'];
          producto.productoFoto = decodedData['result'][i]['producto_foto'];
          producto.productoPrecio = decodedData['result'][i]['producto_precio'];
          producto.productoEstado = decodedData['result'][i]['producto_estado'];
          await _productoDatabase.insertarProducto(producto);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> agregarNuevoProductoPorLinea(File _image, ProductoLineaModel producto) async {
    try {
      int resp;
      final uri = Uri.parse('$apiBaseURL/api/Negocio/guardar_producto');

      var multipartFile;

      if (_image != null) {
        var stream = new http.ByteStream(Stream.castFrom(_image.openRead()));

        var length = await _image.length();

        multipartFile = new http.MultipartFile('imagen', stream, length, filename: basename(_image.path));
      }

      var request = new http.MultipartRequest("POST", uri);

      request.fields["app"] = 'true';
      request.fields["id_linea"] = '${producto.idLinea}';
      request.fields["producto_nombre"] = '${producto.productoNombre}';
      request.fields["producto_descripcion"] = '${producto.productoDescripcion}';
      request.fields["producto_precio"] = '${producto.productoPrecio}';

      if (_image != null) {
        request.files.add(multipartFile);
      }

      await request.send().then((response) async {
        // listen for response
        response.stream.transform(utf8.decoder).listen((value) {
          //final decodedData = json.decode(value);
          print(value);
          resp = 1;
          // if (decodedData['results'] == 1) {

          // } else {
          //   resp = false;
          // }
        });
      }).catchError((e) {
        print(e);
        return 2;
      });

      return resp;
    } catch (e) {
      return 2;
    }
  }
}
