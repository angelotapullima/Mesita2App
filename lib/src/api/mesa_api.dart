import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/mesa_database.dart';
import 'package:mesita_aplication_2/src/database/pedidos_database.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class MesaApi {
  final _prefs = Preferences();
  final _mesaDatabase = MesaDatabase();

  Future<bool> obtenerMesasPorNegocio() async {
    final _pedidosDatabase = PedidosDatabase();
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

      if (decodedData['result'].length > 0) {
        for (var i = 0; i < decodedData['result'].length; i++) {
          MesaModel mesa = MesaModel();
          mesa.idMesa = decodedData['result'][i]['id_mesa'];
          mesa.idNegocio = decodedData['result'][i]['id_negocio'];
          mesa.mesaNombre = decodedData['result'][i]['mesa_nombre'];
          mesa.mesaCapacidad = decodedData['result'][i]['mesa_capacidad'];
          mesa.mesaEstado = decodedData['result'][i]['mesa_estado'];
          await _mesaDatabase.insertarMesa(mesa);
          //decodedData['result'][i]["pedido"]["id_pedido"] != 0 &&

          if (decodedData['result'][i]['mesa_estado'] == '2') {
            PedidoModel pedido = PedidoModel();

            pedido.idPedido = decodedData['result'][i]["pedido"]["id_pedido"];
            pedido.idMesa = decodedData['result'][i]['id_mesa'];
            pedido.total = decodedData['result'][i]["pedido"]["pedido_total"];

            if (decodedData['result'][i]["pedido"]["detalle"].length > 0) {
              pedido.estado = decodedData['result'][i]["pedido"]["detalle"][0]["pedido_estado"];
              pedido.fecha = decodedData['result'][i]["pedido"]["detalle"][0]["pedido_datetime"];
              for (var x = 0; x < decodedData['result'][i]["pedido"]["detalle"].length; x++) {
                var detalle = decodedData['result'][i]["pedido"]["detalle"][x];
                DetallePedidoModel detallePedido = DetallePedidoModel();
                detallePedido.idDetalle = detalle["id_pedido_detalle"];
                detallePedido.idPedido = detalle["id_pedido"];
                detallePedido.idProducto = detalle["id_producto"];
                detallePedido.cantidad = detalle["pedido_detalle_cantidad"];
                detallePedido.subtotal = detalle["pedido_detalle_subtotal"];
                detallePedido.totalDetalle = detalle["pedido_detalle_subtotal"];
                detallePedido.observaciones = detalle["pedido_detalle_observaciones"].toString();
                detallePedido.estado = detalle["pedido_detalle_estado"];
                detallePedido.llevar = detalle["pedido_detalle_llevar"];
                detallePedido.nombreProducto = detalle["producto_nombre"];
                detallePedido.fotoProducto = detalle["producto_foto"];

                await _pedidosDatabase.insertarDetallePedido(detallePedido);
              }

              await _pedidosDatabase.insertarPedido(pedido);
            }
          } else {
            await _pedidosDatabase.deletePedidoPorIdMesa(decodedData['result'][i]['id_mesa']);
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
      if (decodedData["result"] == 1) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      print(e);
      return 2;
    }
  }

  Future<int> editarMesa(MesaModel mesa) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_mesa');

      final resp = await http.post(
        url,
        body: {
          'tn': _prefs.token,
          'id_mesa': '${mesa.idMesa}',
          'id_negocio': _prefs.idNegocio,
          'mesa_nombre': '${mesa.mesaNombre}',
          'mesa_capacidad': '${mesa.mesaCapacidad}',
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      if (decodedData["result"] == 1) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      print(e);
      return 2;
    }
  }
}
