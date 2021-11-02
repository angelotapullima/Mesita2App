import 'package:mesita_aplication_2/src/api/planes_api.dart';
import 'package:mesita_aplication_2/src/database/miembros_database.dart';
import 'package:mesita_aplication_2/src/database/plan_user_database.dart';
import 'package:mesita_aplication_2/src/database/planes_database.dart';
import 'package:mesita_aplication_2/src/models/miembros_model.dart';
import 'package:mesita_aplication_2/src/models/plan_user_model.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:rxdart/rxdart.dart';

class PlanesBloc {
  final _prefs = Preferences();
  final _planesApi = PlanesApi();
  final _planesDatabase = PlanesDatabase();
  final _planUserDatabase = PlanUserDatabase();
  final _miembrosDatabase = MiembrosDatabase();

  final _planesController = BehaviorSubject<List<PlanesModel>>();
  final _planUserController = BehaviorSubject<List<PlanUserModel>>();
  final _miembrosPlanController = BehaviorSubject<List<MiembrosModel>>();

  Stream<List<PlanesModel>> get planesStream => _planesController.stream;
  Stream<List<PlanUserModel>> get planUserStream => _planUserController.stream;
  Stream<List<MiembrosModel>> get miembrosPlanStream => _miembrosPlanController.stream;

  void obtenerPlanes() async {
    _planesController.sink.add(null);
    await _planesApi.obtenerPlanes();
    _planesController.sink.add(await _planesDatabase.obtenerPlanes());
  }

  void obtenerPlanUser() async {
    _planUserController.sink.add(null);
    await _planesApi.obtenerPlanUser();
    _planUserController.sink.add(await _planUserDatabase.obtenerPlanUser(_prefs.idUser));
  }

  void obtenerMiembrosPlan(String idPlan) async {
    _miembrosPlanController.sink.add(null);
    await _planesApi.obtenerMiembrosPlan(idPlan);
    _miembrosPlanController.sink.add(await _miembrosDatabase.obtenerMiembrosPlan(idPlan));
  }

  dispose() {
    _planesController?.close();
    _planUserController?.close();
    _miembrosPlanController?.close();
  }
}
