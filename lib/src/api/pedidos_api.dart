import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/pedidos_database.dart';
import 'package:mesita_aplication_2/src/database/pedidos_por_atender_database.dart';
import 'package:mesita_aplication_2/src/database/pedidos_temporales_database.dart';
import 'package:mesita_aplication_2/src/models/agregar_producto_pedido_model.dart';
import 'package:mesita_aplication_2/src/models/pedidos_atender_model.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class PedidosApi {
  final _comandaDatabase = PedidosTemporalDatabase();
  final _pedidosDatabase = PedidosDatabase();

  final _prefs = Preferences();

  Future<bool> enviarComanda(String idMesa, String total, String nombre, String direccion, String telefono) async {
    try {
      final comandaList = await _comandaDatabase.obtenerDetallesPedidoTemporales(idMesa);

      if (comandaList.isNotEmpty) {
        double totalPedido = 0.0;

        var detalle = '';

        for (var i = 0; i < comandaList.length; i++) {
          totalPedido = totalPedido + double.parse(comandaList[i].subtotal);

          detalle +=
              '${comandaList[i].idProducto};;;${comandaList[i].cantidad};;;${comandaList[i].subtotal};;;${comandaList[i].observaciones};;;${comandaList[i].llevar}//';
        }

        final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_pedido');

        final resp = await http.post(
          url,
          body: {
            'tn': '${_prefs.token}',
            'id_mesa': idMesa,
            'id_usuario': '${_prefs.idUser}',
            'pedido_total': '$totalPedido',
            'detalle': detalle,
            'nombre': nombre,
            'direccion': direccion,
            'telefono': telefono,
            'app': 'true',
          },
        );

        final decodedData = json.decode(resp.body);
        if (decodedData['result'] == 1) {
          await _comandaDatabase.deleteDetallesPedidoTemporal();
          return true;
        } else {
          return false;
        }
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> agregarDetallePedido(String idPedido, DetalleProductoModel detail) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/guardar_pedido_detalle');
      var detalle = '';

      detalle += '${detail.idProducto};;;${detail.cantidad};;;${detail.subtotal};;;${detail.observaciones};;;${detail.llevar}//';

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'id_pedido': idPedido,
          'detalle': detalle,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData['result'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> editarDetallePedido(DetallePedidoModel detail) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/editar_pedido_detalle');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'id_pedido': detail.idPedido,
          'id_pedido_detalle': detail.idDetalle,
          'pedido_detalle_cantidad': detail.cantidad,
          'pedido_detalle_subtotal': detail.subtotal,
          'pedido_detalle_observaciones': detail.observaciones,
          'pedido_detalle_llevar': detail.llevar,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      if (decodedData['result'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> eliminarDetallePedido(DetallePedidoModel detail) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/eliminar_pedido_detalle');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'id_pedido': detail.idPedido,
          'id_pedido_detalle': detail.idDetalle,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      if (decodedData['result'] == 1) {
        await _pedidosDatabase.deleteDetallesPedidoPorId(detail.idDetalle);
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }

  Future<bool> obtenerPedidosPorAtender() async {
    try {
      final _pedidosAtenderDatabase = PedidosAtenderDatabase();

      final url = Uri.parse('$apiBaseURL/api/Negocio/pedidos_por_atender');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'id_negocio': '${_prefs.idNegocio}',
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData['result'].length > 0) {
        await _pedidosAtenderDatabase.deletePedidoAtender();
        for (var i = 0; i < decodedData['result'].length; i++) {
          var detallito = decodedData['result'][i];

          PedidosAtenderModel pedido = PedidosAtenderModel();

          pedido.idPedidoDetalle = detallito["id_pedido_detalle"];
          pedido.idNegocio = detallito["id_negocio"];
          pedido.idMesa = detallito["id_mesa"];
          pedido.idProducto = detallito["id_producto"];
          pedido.nombreProducto = detallito["producto_nombre"];
          pedido.mesaNombre = detallito["mesa_nombre"];
          pedido.fotoProducto = detallito["producto_foto"];
          pedido.cantidad = detallito["pedido_detalle_cantidad"];
          pedido.fecha = detallito["pedido_detalle_datetime"];
          pedido.estado = detallito["pedido_detalle_estado"];

          await _pedidosAtenderDatabase.insertarPedidoAtender(pedido);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> atenderPedido(PedidosAtenderModel pedido) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/atender_pedido');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'id_pedido_detalle': pedido.idPedidoDetalle,
          'app': 'true',
        },
      );

      final decodedData = json.decode(resp.body);
      if (decodedData['result'] == 1) {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}
