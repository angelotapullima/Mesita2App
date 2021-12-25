import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/models/buscar_user_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class BuscarUserApi {
  final _prefs = Preferences();

  Future<List<BuscarUserModel>> busacarUser(String query) async {
    final List<BuscarUserModel> listaReturn = [];

    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/buscar_usuario');

      final resp = await http.post(url, body: {
        'tn': '${_prefs.token}',
        'dato': query,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      if (decodedData["result"].length > 0) {
        for (var i = 0; i < decodedData["result"].length; i++) {
          BuscarUserModel bus = BuscarUserModel();

          bus.id = decodedData["result"][i]["id_usuario"];
          bus.nombre = '${decodedData["result"][i]["persona_nombre"]} ${decodedData["result"][i]["persona_apellido_paterno"]}';
          listaReturn.add(bus);
        }
      }

      return listaReturn;
    } catch (e) {
      return listaReturn;
    }
  }
}
