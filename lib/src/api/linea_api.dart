import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/linea_database.dart';
import 'package:mesita_aplication_2/src/database/productos_linea_database.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class LineaApi {
  final _prefs = Preferences();
  final _lineaDatabase = LineaDatabase();
  final _productoDatabase = ProductoLineaDatabase();

  Future<bool> obtenerLineasPorNegocio() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_lineas_por_negocio');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id_negocio': '${_prefs.idNegocio}',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      //print(decodedData);

      if (decodedData['result'].length > 0) {
        for (var i = 0; i < decodedData['result'].length; i++) {
          LineaModel linea = LineaModel();
          linea.idLinea = decodedData['result'][i]['id_linea'];
          linea.idNegocio = decodedData['result'][i]['id_negocio'];
          linea.idCategoria = decodedData['result'][i]['id_categoria'];
          linea.lineaNombre = decodedData['result'][i]['linea_nombre'];
          linea.lineaEstado = decodedData['result'][i]['linea_estado'];
          await _lineaDatabase.insertarLinea(linea);

          for (var x = 0; x < decodedData['result'][i]['productos'].length; x++) {
            var product = decodedData['result'][i]['productos'][x];

            ProductoLineaModel producto = ProductoLineaModel();
            producto.idProducto = product['id_producto'];
            producto.idLinea = product['id_linea'];
            producto.productoNombre = product['producto_nombre'];
            producto.productoDescripcion = product['producto_descripcion'];
            producto.productoFoto = product['producto_foto'];
            producto.productoPrecio = product['producto_precio'];
            producto.productoEstado = product['producto_estado'];
            await _productoDatabase.insertarProducto(producto);
          }
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> agregarNuevaLinea(String nombreLinea, String idCategoria) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_linea');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id_negocio': '${_prefs.idNegocio}',
        'linea_nombre': '$nombreLinea',
        'id_categoria': '$idCategoria',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print(decodedData);
      if (decodedData["result"] == 1) {
        return 1;
      } else {
        return decodedData["result"];
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> editarLinea(String idLinea, String nombreLinea, String idCategoria) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_linea');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id_negocio': '${_prefs.idNegocio}',
        'linea_nombre': '$nombreLinea',
        'id_linea': '$idLinea',
        'id_categoria': '$idCategoria',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      if (decodedData["result"] == 1) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> eliminarLinea(String idLinea) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/eliminar_linea');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id': '$idLinea',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      if (decodedData["result"] == 1) {
        await _lineaDatabase.deleteLineaPorIdLinea(idLinea);
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}
