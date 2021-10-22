import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/ventas_database.dart';
import 'package:mesita_aplication_2/src/models/venta_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class VentaApi {
  final _prefs = Preferences();
  final _ventasDatabase = VentasDatabase();

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

      if (decodedData['result'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> listarVentas(String fechaI, String fechaF) async {
    try {
      final url = Uri.parse('${apiBaseURL}/api/Negocio/ventas_por_fecha');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'app': 'true',
          'id_negocio': '${_prefs.idNegocio}',
          'fecha_i': '$fechaI',
          'fecha_f': '$fechaF',
        },
      );

      final decodedData = json.decode(resp.body);
      if (decodedData["result"].length > 0) {
        for (var i = 0; i < decodedData["result"].length; i++) {
          var data = decodedData["result"][i];

          VentaModel venta = VentaModel();
          venta.idVenta = data["id_venta"];
          venta.idPedido = data["id_pedido"];
          venta.idNegocio = data["id_empresa"];
          venta.idMesa = data["id_mesa"];
          venta.envio = data["venta_tipo_envio"];
          venta.direccion = data["venta_direccion"];
          venta.tipoDoc = data["venta_tipo"];
          venta.serie = data["venta_serie"];
          venta.correlativo = data["venta_correlativo"];
          venta.igv = data["venta_totaligv"];
          venta.incluyeIGV = data["venta_incluye_igv"];
          venta.descuento = data["venta_totaldescuento"];
          venta.total = data["venta_total"];
          String date = data["venta_fecha"].toString();

          var fech = date.split(' ');

          venta.fecha = fech[0];
          venta.hora = fech[1];
          venta.estado = data["venta_estado_sunat"];

          await _ventasDatabase.insertarVenta(venta);
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
