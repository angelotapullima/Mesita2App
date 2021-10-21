import 'package:mesita_aplication_2/src/api/linea_api.dart';
import 'package:mesita_aplication_2/src/database/linea_database.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class LineaBloc {
  final _lineaDatabase = LineaDatabase();
  final _lineaApi = LineaApi();
  final _prefs = Preferences();

  final _lineasController = BehaviorSubject<List<LineaModel>>();
  final _lineasAllController = BehaviorSubject<List<LineaModel>>();

  Stream<List<LineaModel>> get lineasStream => _lineasController.stream;

  Stream<List<LineaModel>> get allLineasStream => _lineasAllController.stream;

  void obtenerLineasPorNegocio(String idCategoria) async {
    _lineasController.sink.add([]);
    _lineasController.sink.add(await _lineaDatabase.obtenerLineasPorNegocio(_prefs.idNegocio, idCategoria));
  }

  void updateLineasPorNegocio(String idCategoria) async {
    _lineasController.sink.add([]);
    await _lineaApi.obtenerLineasPorNegocio();
    _lineasController.sink.add(await _lineaDatabase.obtenerLineasPorNegocio(_prefs.idNegocio, idCategoria));
  }

  void obtenerTodasLasLineasPorNegocio() async {
    _lineasAllController.sink.add(await _lineaDatabase.obtenerAllLines(_prefs.idNegocio));
    await _lineaApi.obtenerLineasPorNegocio();
    _lineasAllController.sink.add(await _lineaDatabase.obtenerAllLines(_prefs.idNegocio));
  }

  dispose() {
    _lineasController?.close();
    _lineasAllController?.close();
  }
}
