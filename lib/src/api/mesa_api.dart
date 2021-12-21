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

      //GUARDANDO PEDIDOS Y MESAS DENTRO DEL LOCAL

      if (decodedData['local'].length > 0) {
        for (var i = 0; i < decodedData['local'].length; i++) {
          MesaModel mesa = MesaModel();
          mesa.idMesa = decodedData['local'][i]['id_mesa'];
          mesa.idNegocio = decodedData['local'][i]['id_negocio'];
          mesa.mesaNombre = decodedData['local'][i]['mesa_nombre'];
          mesa.mesaCapacidad = decodedData['local'][i]['mesa_capacidad'];
          mesa.mesaEstado = decodedData['local'][i]['mesa_estado'];
          mesa.mesaTipo = decodedData['local'][i]['mesa_tipo'];
          await _mesaDatabase.insertarMesa(mesa);
          //decodedData['local'][i]["pedido"]["id_pedido"] != 0 &&

          if (decodedData['local'][i]['mesa_estado'] == '2') {
            PedidoModel pedido = PedidoModel();

            pedido.idPedido = decodedData['local'][i]["pedido"]["id_pedido"];
            pedido.idMesa = decodedData['local'][i]['id_mesa'];
            pedido.total = decodedData['local'][i]["pedido"]["pedido_total"];
            pedido.nombre = decodedData['local'][i]["pedido"]["pedido_nombre"];
            pedido.direccion = decodedData['local'][i]["pedido"]["pedido_direccion"];
            pedido.telefono = decodedData['local'][i]["pedido"]["pedido_telefono"];

            if (decodedData['local'][i]["pedido"]["detalle"].length > 0) {
              pedido.estado = decodedData['local'][i]["pedido"]["detalle"][0]["pedido_estado"];
              pedido.fecha = decodedData['local'][i]["pedido"]["detalle"][0]["pedido_datetime"];
              for (var x = 0; x < decodedData['local'][i]["pedido"]["detalle"].length; x++) {
                var detalle = decodedData['local'][i]["pedido"]["detalle"][x];
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
            await _pedidosDatabase.deletePedidoPorIdMesa(decodedData['local'][i]['id_mesa']);
          }
        }
      }

      //GUARDANDO PEDIDOS LLEVAR

      MesaModel mesa = MesaModel();
      mesa.idMesa = decodedData['llevar']['id_mesa'];
      mesa.idNegocio = decodedData['llevar']['id_negocio'];
      mesa.mesaNombre = decodedData['llevar']['mesa_nombre'];
      mesa.mesaCapacidad = decodedData['llevar']['mesa_capacidad'];
      mesa.mesaEstado = decodedData['llevar']['mesa_estado'];
      mesa.mesaTipo = decodedData['llevar']['mesa_tipo'];
      await _mesaDatabase.insertarMesa(mesa);

      if (decodedData['llevar']['mesa_estado'] == '2') {
        for (var a = 0; a < decodedData['llevar']["pedido"].length; a++) {
          var pedixd = decodedData['llevar']["pedido"][a];
          PedidoModel pedido = PedidoModel();

          pedido.idPedido = pedixd["id_pedido"];
          pedido.idMesa = decodedData['llevar']['id_mesa'];
          pedido.total = pedixd["pedido_total"];
          pedido.nombre = pedixd["pedido_nombre"];
          pedido.direccion = pedixd["pedido_direccion"];
          pedido.telefono = pedixd["pedido_telefono"];
          pedido.estado = pedixd["pedido_estado"];
          pedido.fecha = pedixd["pedido_datetime"];
          await _pedidosDatabase.insertarPedido(pedido);

          DetallePedidoModel detallePedido = DetallePedidoModel();
          detallePedido.idDetalle = pedixd["id_pedido_detalle"];
          detallePedido.idPedido = pedixd["id_pedido"];
          detallePedido.idProducto = pedixd["id_producto"];
          detallePedido.cantidad = pedixd["pedido_detalle_cantidad"];
          detallePedido.subtotal = pedixd["pedido_detalle_subtotal"];
          detallePedido.totalDetalle = pedixd["pedido_detalle_subtotal"];
          detallePedido.observaciones = pedixd["pedido_detalle_observaciones"].toString();
          detallePedido.estado = pedixd["pedido_detalle_estado"];
          detallePedido.llevar = pedixd["pedido_detalle_llevar"];
          detallePedido.nombreProducto = pedixd["producto_nombre"];
          detallePedido.fotoProducto = pedixd["producto_foto"];

          await _pedidosDatabase.insertarDetallePedido(detallePedido);
        }
      } else {
        await _pedidosDatabase.deletePedidoPorIdMesa(decodedData['llevar']['id_mesa']);
      }

      //GUARDANDO PEDIDOS DELIVERY

      MesaModel mesa2 = MesaModel();
      mesa2.idMesa = decodedData['delivery']['id_mesa'];
      mesa2.idNegocio = decodedData['delivery']['id_negocio'];
      mesa2.mesaNombre = decodedData['delivery']['mesa_nombre'];
      mesa2.mesaCapacidad = decodedData['delivery']['mesa_capacidad'];
      mesa2.mesaEstado = decodedData['delivery']['mesa_estado'];
      mesa2.mesaTipo = decodedData['delivery']['mesa_tipo'];
      await _mesaDatabase.insertarMesa(mesa2);

      if (decodedData['delivery']["mesa_estado"] == '2') {
        for (var g = 0; g < decodedData['delivery']["pedido"].length; g++) {
          var delivery = decodedData['delivery']["pedido"][g];

          PedidoModel pedido = PedidoModel();

          pedido.idPedido = delivery["id_pedido"];
          pedido.idMesa = decodedData['delivery']['id_mesa'];
          pedido.total = delivery["pedido_total"];
          pedido.nombre = delivery["pedido_nombre"];
          pedido.direccion = delivery["pedido_direccion"];
          pedido.telefono = delivery["pedido_telefono"];
          pedido.estado = delivery["pedido_estado"];
          pedido.fecha = delivery["pedido_datetime"];
          await _pedidosDatabase.insertarPedido(pedido);

          DetallePedidoModel detallePedido = DetallePedidoModel();
          detallePedido.idDetalle = delivery["id_pedido_detalle"];
          detallePedido.idPedido = delivery["id_pedido"];
          detallePedido.idProducto = delivery["id_producto"];
          detallePedido.cantidad = delivery["pedido_detalle_cantidad"];
          detallePedido.subtotal = delivery["pedido_detalle_subtotal"];
          detallePedido.totalDetalle = delivery["pedido_detalle_subtotal"];
          detallePedido.observaciones = delivery["pedido_detalle_observaciones"].toString();
          detallePedido.estado = delivery["pedido_detalle_estado"];
          detallePedido.llevar = delivery["pedido_detalle_llevar"];
          detallePedido.nombreProducto = delivery["producto_nombre"];
          detallePedido.fotoProducto = delivery["producto_foto"];

          await _pedidosDatabase.insertarDetallePedido(detallePedido);
        }
      } else {
        await _pedidosDatabase.deletePedidoPorIdMesa(decodedData['delivery']['id_mesa']);
      }

      return true;
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
      if (decodedData["local"] == 1) {
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
      if (decodedData["local"] == 1) {
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
