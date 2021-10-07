import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/linea_model.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class LineaApi {
  final _prefs = Preferences();
  final _lineaDatabase = LineaDatabase();

  Future<bool> obtenerLineasPorNegocio() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_lineas_por_negocio');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id_negocio': '${_prefs.idNegocio}',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      if (decodedData['result'].length > 0) {
        for (var i = 0; i < decodedData['result'].length; i++) {
          LineaModel linea = LineaModel();
          linea.idLinea = decodedData['result'][i]['id_linea'];
          linea.idNegocio = decodedData['result'][i]['id_negocio'];
          linea.lineaNombre = decodedData['result'][i]['linea_nombre'];
          linea.lineaEstado = decodedData['result'][i]['linea_estado'];
          await _lineaDatabase.insertarLinea(linea);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> agregarNuevaLinea(String nombreLinea) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_linea');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'id_negocio': '${_prefs.idNegocio}',
        'linea_nombre': '$nombreLinea',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print(decodedData);
      if (decodedData["result"] == 1) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}
