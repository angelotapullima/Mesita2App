import 'package:mesita_aplication_2/src/api/reportes_api.dart';
import 'package:mesita_aplication_2/src/database/reporte_general_database.dart';
import 'package:mesita_aplication_2/src/database/reporte_linea_database.dart';
import 'package:mesita_aplication_2/src/models/reporte_general_model.dart';
import 'package:mesita_aplication_2/src/models/reporte_linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class ReporteBloc {
  final _prefs = Preferences();
  final _reportesApi = ReportesApi();
  final _reportGDB = ReporteGeneralDatabase();
  final _reporteLineaDB = ReporteLineaDatabase();

  final _reporteGeneralController = BehaviorSubject<List<ReporteGeneralModel>>();
  final _reportesLineaController = BehaviorSubject<List<ReporteLineaModel>>();

  Stream<List<ReporteGeneralModel>> get reporteGeneralStream => _reporteGeneralController.stream;
  Stream<List<ReporteLineaModel>> get reporteLineaStream => _reportesLineaController.stream;

  void obtenerReporteGeneralPorIdItem(String fechaI, String fechaF, int idItem) async {
    _reporteGeneralController.sink.add(await _reportGDB.obtenerReporteGeneralPorId(idItem.toString()));
    await _reportesApi.obtenerReportesLinea(fechaI, fechaF, idItem);
    _reporteGeneralController.sink.add(await _reportGDB.obtenerReporteGeneralPorId(idItem.toString()));
  }

  void obtenerReporteLinea() async {
    _reportesLineaController.sink.add([]);
    _reportesLineaController.sink.add(await _reporteLineaDB.obtenerReportLinea(_prefs.idNegocio));
  }

  dispose() {
    _reporteGeneralController?.close();
    _reportesLineaController?.close();
  }
}
