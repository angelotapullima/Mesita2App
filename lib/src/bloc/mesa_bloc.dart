import 'package:mesita_aplication_2/src/api/mesa_api.dart';
import 'package:mesita_aplication_2/src/database/mesa_database.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class MesasBloc {
  final _mesaDatabase = MesaDatabase();
  final _mesaApi = MesaApi();
  final _prefs = Preferences();

  final _mesasController = BehaviorSubject<List<MesaModel>>();
  final _mesaController = BehaviorSubject<List<MesaModel>>();

  Stream<List<MesaModel>> get mesasStream => _mesasController.stream;
  Stream<List<MesaModel>> get mesaStream => _mesaController.stream;

  void obtenerMesasPorNegocio() async {
    _mesasController.sink.add(await _mesaDatabase.obtenerMesasPorNegocio(_prefs.idNegocio));
    await _mesaApi.obtenerMesasPorNegocio();
    _mesasController.sink.add(await _mesaDatabase.obtenerMesasPorNegocio(_prefs.idNegocio));
  }

  void obtenerMesaPorId(String idMesa) async {
    _mesaController.sink.add(await _mesaDatabase.obtenerMesaPorIdMesa(idMesa));
    await _mesaApi.obtenerMesasPorNegocio();
    _mesaController.sink.add(await _mesaDatabase.obtenerMesaPorIdMesa(idMesa));
  }

  void actualizarMesas(String idMesa) async {
    _mesaController.sink.add(await _mesaDatabase.obtenerMesaPorIdMesa(idMesa));
    _mesasController.sink.add(await _mesaDatabase.obtenerMesasPorNegocio(_prefs.idNegocio));
    await _mesaApi.obtenerMesasPorNegocio();
    _mesaController.sink.add(await _mesaDatabase.obtenerMesaPorIdMesa(idMesa));
    _mesasController.sink.add(await _mesaDatabase.obtenerMesasPorNegocio(_prefs.idNegocio));
  }

  dispose() {
    _mesasController?.close();
    _mesaController?.close();
  }
}
