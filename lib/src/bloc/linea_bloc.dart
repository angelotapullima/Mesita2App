import 'package:mesita_aplication_2/src/api/linea_api.dart';
import 'package:mesita_aplication_2/src/database/linea_model.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class LineaBloc {
  final _lineaDatabase = LineaDatabase();
  final _lineaApi = LineaApi();
  final _prefs = Preferences();

  final _lineasController = BehaviorSubject<List<LineaModel>>();

  Stream<List<LineaModel>> get lineasStream => _lineasController.stream;

  void obtenerLineasPorNegocio() async {
    _lineasController.sink.add(await _lineaDatabase.obtenerLineasPorNegocio(_prefs.idNegocio));
    await _lineaApi.obtenerLineasPorNegocio();
    _lineasController.sink.add(await _lineaDatabase.obtenerLineasPorNegocio(_prefs.idNegocio));
  }

  dispose() {
    _lineasController?.close();
  }
}
