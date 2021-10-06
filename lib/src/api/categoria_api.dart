import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/categoria_database.dart';
import 'package:mesita_aplication_2/src/models/categoria_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class CategoriaApi {
  final _prefs = Preferences();
  final _categoriaDatabase = CategoriaDatabase();

  Future<bool> obtenerCategorias() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_categorias');
      print('${_prefs.token}');

      final resp = await http.post(url, body: {
        'tn': _prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData['result'].length > 0) {
        for (var i = 0; i < decodedData['result'].length; i++) {
          CategoriaModel categoria = CategoriaModel();
          categoria.idCategoria = decodedData['result'][i]['id_categoria'];
          categoria.categoriaNombre = decodedData['result'][i]['categoria_nombre'];
          categoria.categoriaEstado = decodedData['result'][i]['categoria_estado'];
          await _categoriaDatabase.insertarCategoria(categoria);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
