import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class VentaApi {
  final _prefs = Preferences();

  Future<bool> guardarVenta(String idPedido, String tipoVenta, String ruc, String razon, String domicilio) async {
    try {
      final url = Uri.parse('${apiBaseURL}/api/Negocio/guardar_venta');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'app': 'true',
          'id_pedido': '$idPedido',
          'venta_tipo': '$tipoVenta',
          'venta_ruc': '$ruc',
          'venta_razonsocial': '$razon',
          'venta_domicilio': '$domicilio',
          'id_usuario': '${_prefs.idUser}',
        },
      );

      final decodedData = json.decode(resp.body);
      print(decodedData);

      if (decodedData['result'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
