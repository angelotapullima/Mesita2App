import 'package:mesita_aplication_2/src/database/reporte_general_database.dart';
import 'package:mesita_aplication_2/src/database/reporte_linea_database.dart';
import 'package:mesita_aplication_2/src/database/reporte_producto_database.dart';
import 'package:mesita_aplication_2/src/database/reporte_utilidades_linea_database.dart';
import 'package:mesita_aplication_2/src/models/reporte_general_model.dart';
import 'package:mesita_aplication_2/src/models/reporte_linea_model.dart';
import 'package:mesita_aplication_2/src/models/reporte_producto_model.dart';
import 'package:mesita_aplication_2/src/models/reporte_utilidades_linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/utils/constants.dart';

class ReportesApi {
  final _prefs = Preferences();
  final _reporteGeneralDB = ReporteGeneralDatabase();
  final _reporteLineaDB = ReporteLineaDatabase();
  final _reporteUtilidadesLineaDB = ReporteUtilidadesLineaDatabase();
  final _reporteProductoDB = ReporteProductoDatabase();

  Future<bool> obtenerReportesLinea(String fechaI, String fechaF, int idItem) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/reporte_por_fechas');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'app': 'true',
          'id_negocio': '${_prefs.idNegocio}',
          'fecha_i': fechaI,
          'fecha_f': fechaF,
        },
      );

      final decodedData = json.decode(resp.body);

      ReporteGeneralModel general = ReporteGeneralModel();

      general.id = idItem.toString();
      general.sumaTotal = decodedData["result"]["suma_total"].toStringAsFixed(2);
      general.cantidad = decodedData["result"]["cantidad_total"].toString();
      await _reporteGeneralDB.insertarReporteGeneral(general);

      if (decodedData["result"]["lineas"].length > 0) {
        await _reporteLineaDB.deleteReportLinea();
        for (var i = 0; i < decodedData["result"]["lineas"].length; i++) {
          var linea = decodedData["result"]["lineas"][i];
          ReporteLineaModel lineaR = ReporteLineaModel();

          lineaR.idLinea = linea["id_linea"];
          lineaR.idNegocio = linea["id_negocio"];
          lineaR.idCategoria = linea["id_categoria"];
          lineaR.nombre = linea["linea_nombre"];
          lineaR.estado = linea["linea_estado"];
          lineaR.suma = linea["suma"].toStringAsFixed(2);
          lineaR.cantidad = linea["cantidad"].toString();

          await _reporteLineaDB.insertarReportLinea(lineaR);
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> obtenerReportesUtilidadesLinea(String fechaI, String fechaF) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/utilidad_por_fechas');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'app': 'true',
          'id_negocio': '${_prefs.idNegocio}',
          'fecha_i': fechaI,
          'fecha_f': fechaF,
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData["result"]["lineas"].length > 0) {
        await _reporteLineaDB.deleteReportLinea();
        for (var i = 0; i < decodedData["result"]["lineas"].length; i++) {
          var linea = decodedData["result"]["lineas"][i];
          ReporteUtilidadesLineaModel lineaR = ReporteUtilidadesLineaModel();

          lineaR.idLinea = linea["id_linea"];
          lineaR.idNegocio = linea["id_negocio"];
          lineaR.idCategoria = linea["id_categoria"];
          lineaR.nombre = linea["linea_nombre"];
          lineaR.estado = linea["linea_estado"];
          lineaR.suma = linea["suma"].toStringAsFixed(2);
          lineaR.cantidad = linea["cantidad"].toString();

          await _reporteUtilidadesLineaDB.insertarReportUtilidadLinea(lineaR);
        }
      }

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> obtenerReportesProductos(String fechaI, String fechaF) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/productos_mas_vendidos');

      final resp = await http.post(
        url,
        body: {
          'tn': '${_prefs.token}',
          'app': 'true',
          'id_negocio': '${_prefs.idNegocio}',
          'fecha_i': fechaI,
          'fecha_f': fechaF,
        },
      );

      final decodedData = json.decode(resp.body);

      if (decodedData["result"].length > 0) {
        await _reporteProductoDB.deleteReportProduct();
        for (var i = 0; i < decodedData["result"].length; i++) {
          var producto = decodedData["result"][i];
          ReporteProductoModel prodR = ReporteProductoModel();

          prodR.idProducto = producto["id_producto"];
          prodR.idNegocio = '${_prefs.idNegocio}';
          prodR.estado = '1';
          prodR.suma = producto["suma"];
          prodR.cantidad = producto["cantidad"];

          await _reporteProductoDB.insertarReportProducto(prodR);
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
