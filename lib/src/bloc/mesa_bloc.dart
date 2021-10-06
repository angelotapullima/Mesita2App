import 'package:mesita_aplication_2/src/api/mesa_api.dart';
import 'package:mesita_aplication_2/src/database/mesa_database.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class MesBloc {
  final _mesasController = BehaviorSubject<List<MesaModel>>();
  final _mesaDatabase = MesaDatabase();
  final _mesaApi = MesaApi();
  final _prefs = Preferences();

  Stream<List<MesaModel>> get mesasStream => _mesasController.stream;

  void obtenerMesasPorNegocio() async {
    _mesasController.sink.add(await _mesaDatabase.obtenerMesasPorNegocio(_prefs.idNegocio));
    await _mesaApi.obtenerMesasPorNegocio();
    _mesasController.sink.add(await _mesaDatabase.obtenerMesasPorNegocio(_prefs.idNegocio));
  }

  dispose() {
    _mesasController?.close();
  }
}
