import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class NegocioApi {
  final _prefs = Preferences();

  Future<int> actualizarNegocio(String nombre, String direccion, String telefono) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/actualizar_negocio');

      final resp = await http.post(url, body: {
        'nombre': nombre,
        'telefono': telefono,
        'direccion': direccion,
        'id_negocio': _prefs.idNegocio,
        'tn': _prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      if (decodedData['result'] == 1) {
        _prefs.negocioNombre = nombre;
        _prefs.negocioDireccion = direccion;
        _prefs.negocioTelefono = telefono;
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}
