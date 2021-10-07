import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/mesa_database.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class MesaApi {
  final _prefs = Preferences();
  final _mesaDatabase = MesaDatabase();

  Future<bool> obtenerMesasPorNegocio() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_mesas_por_negocio');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_negocio': _prefs.idNegocio,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData['result'].length > 0) {
        for (var i = 0; i < decodedData['result'].length; i++) {
          MesaModel mesa = MesaModel();
          mesa.idMesa = decodedData['result'][i]['id_mesa'];
          mesa.idNegocio = decodedData['result'][i]['id_negocio'];
          mesa.mesaNombre = decodedData['result'][i]['mesa_nombre'];
          mesa.mesaCapacidad = decodedData['result'][i]['mesa_capacidad'];
          mesa.mesaEstado = decodedData['result'][i]['mesa_estado'];
          await _mesaDatabase.insertarMesa(mesa);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> agregarNuevaMesa(String numeroMesa, String capacidad) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_mesa');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_negocio': _prefs.idNegocio,
          'mesa_nombre': '$numeroMesa',
          'mesa_capacidad': '$capacidad',
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);
      return 1;
    } catch (e) {
      return 2;
    }
  }
}
