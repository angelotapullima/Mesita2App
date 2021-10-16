import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/database/pedidos_temporales_database.dart';
import 'package:mesita_aplication_2/src/models/agregar_producto_pedido_model.dart';
import 'package:mesita_aplication_2/src/models/api_model.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class PedidosApi {
  final _comandaDatabase = PedidosTemporalDatabase();

  final _prefs = Preferences();

  Future<ApiModel> enviarComanda(String idMesa, String total) async {
    try {
      final comandaList = await _comandaDatabase.obtenerDetallesPedidoTemporales(idMesa);

      if (comandaList.length > 0) {
        final List<DetallePedidoTemporalModel> detallesList = [];

        double totalPedido = 0.0;

        ComandaModel comanda = ComandaModel();
        comanda.idMesa = idMesa;
        comanda.idUsuario = _prefs.idUser;

        for (var i = 0; i < comandaList.length; i++) {
          DetallePedidoTemporalModel detalles = DetallePedidoTemporalModel();
          detalles.idProducto = comandaList[i].idProducto;
          detalles.cantidad = comandaList[i].cantidad;
          detalles.subtotal = comandaList[i].subtotal;
          detalles.observaciones = comandaList[i].observaciones;
          detalles.llevar = comandaList[i].llevar;

          totalPedido = totalPedido + double.parse(comandaList[i].subtotal);

          detallesList.add(detalles);
        }

        comanda.total = totalPedido.toStringAsFixed(2);

        comanda.detalles = detallesList;
        comanda.token = '${_prefs.token}';

        var envio = jsonEncode(comanda.toJson());
        print(envio);
        final url = Uri.parse('${apiBaseURL}/api/Negocio/guardar_pedido');
        // Map<String, String> headers = {
        //   'Content-Type': 'application/json',
        //   'tn': '${_prefs.token}',
        //   'app': 'true',
        // };

        final resp = await http.post(url, body: envio);

        if (resp.statusCode == 401) {
          ApiModel apiModel = ApiModel();
          apiModel.error = true;
          apiModel.resultadoPeticion = false;
          apiModel.mensaje = 'token inválido';

          return apiModel;
        }

        final decodedData = json.decode(resp.body);

        print(decodedData);

        print(decodedData['exito']);
        if (decodedData['result']['code'] == 1) {
          await _comandaDatabase.deleteDetallesPedidoTemporal();
          ApiModel apiModel = ApiModel();
          apiModel.error = false;
          apiModel.resultadoPeticion = true;
          apiModel.mensaje = 'Respuesta correcta';

          return apiModel;
        } else {
          ApiModel apiModel = ApiModel();
          apiModel.error = false;
          apiModel.resultadoPeticion = false;
          apiModel.mensaje = 'El envío no fue exitoso';

          return apiModel;
        }
      } else {
        ApiModel apiModel = ApiModel();
        apiModel.error = false;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'El envío no fue exitoso';

        return apiModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = false;
      apiModel.mensaje = 'Error al realizar la petición';

      return apiModel;
    }
  }

  Future<ApiModel> agregarDetallePedido(String idPedido, DetalleProductoModel detalle) async {
    try {
      final List<DetalleProductoModel> detallesList = [];
      detallesList.add(detalle);

      AgreparProductoPedidoModel pedido = AgreparProductoPedidoModel();
      pedido.idPedido = idPedido;

      pedido.detalles = detallesList;
      pedido.token = '${_prefs.token}';

      var envio = jsonEncode(pedido.toJson());
      print(envio);
      final url = Uri.parse('${apiBaseURL}/api/Negocio/guardar_pedido_detalle');
      // Map<String, String> headers = {
      //   'Content-Type': 'application/json',
      //   'tn': '${_prefs.token}',
      //   'app': 'true',
      // };

      final resp = await http.post(url, body: envio);

      if (resp.statusCode == 401) {
        ApiModel apiModel = ApiModel();
        apiModel.error = true;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'token inválido';

        return apiModel;
      }

      final decodedData = json.decode(resp.body);

      print(decodedData);

      print(decodedData['exito']);
      if (decodedData['result']['code'] == 1) {
        ApiModel apiModel = ApiModel();
        apiModel.error = false;
        apiModel.resultadoPeticion = true;
        apiModel.mensaje = 'Respuesta correcta';

        return apiModel;
      } else {
        ApiModel apiModel = ApiModel();
        apiModel.error = false;
        apiModel.resultadoPeticion = false;
        apiModel.mensaje = 'El envío no fue exitoso';

        return apiModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");

      ApiModel apiModel = ApiModel();
      apiModel.error = false;
      apiModel.resultadoPeticion = false;
      apiModel.mensaje = 'Error al realizar la petición';

      return apiModel;
    }
  }
/* 
  Future<List<PedidoModel>> obtenerPedidosPorIdMesa(String idMesa) async {
    final List<PedidoModel> listaReturnPedidos = [];

    final listaPedidos = await _pedidosDatabase.obtenerPedidosPorIdMesa(idMesa);

    if (listaPedidos.length > 0) {
      for (var i = 0; i < listaPedidos.length; i++) {
        PedidoModel pedidos = PedidoModel();

        pedidos.idPedido = listaPedidos[i].idPedido;
        pedidos.idMesa = listaPedidos[i].idMesa;
        pedidos.total = listaPedidos[i].total;
        pedidos.fecha = listaPedidos[i].fecha;
        pedidos.estado = listaPedidos[i].fecha;

        final List<DetallePedidoModel> listDetalles = [];
        final listaDetallesPedido = await _pedidosDatabase.obtenerDetallesPedidoPorIdPedido(listaPedidos[i].idPedido);

        for (var x = 0; x < listaDetallesPedido.length; x++) {
          DetallePedidoModel detalles = DetallePedidoModel();

          detalles.idDetalle = listaDetallesPedido[x].idDetalle;
          detalles.idPedido = listaDetallesPedido[x].idPedido;
          detalles.idProducto = listaDetallesPedido[x].idProducto;
          detalles.cantidad = listaDetallesPedido[x].cantidad;
          detalles.totalDetalle = listaDetallesPedido[x].totalDetalle;
          detalles.observaciones = listaDetallesPedido[x].observaciones;
          detalles.estado = listaDetallesPedido[x].estado;
          detalles.llevar = listaDetallesPedido[x].llevar;

          final productoDB = await _productosDatabase.obtenerProductosPorIdProducto(listaDetallesPedido[x].idProducto);

          if (productoDB.length > 0) {
            detalles.subtotal = productoDB[0].productoPrecio;
            detalles.nombreProducto = productoDB[0].productoNombre;
            detalles.fotoProducto = productoDB[0].productoFoto;
          }

          listDetalles.add(detalles);
        }

        pedidos.detallesPedido = listDetalles;

        listaReturnPedidos.add(pedidos);
      }
    }
    return listaReturnPedidos;
  }

 */

}
