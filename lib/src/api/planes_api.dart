import 'dart:convert';

import 'package:mesita_aplication_2/src/database/miembros_database.dart';
import 'package:mesita_aplication_2/src/database/plan_user_database.dart';
import 'package:mesita_aplication_2/src/database/planes_database.dart';
import 'package:mesita_aplication_2/src/models/miembros_model.dart';
import 'package:mesita_aplication_2/src/models/plan_user_model.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/utils/constants.dart';

class PlanesApi {
  final _prefs = Preferences();
  final _planesDatabase = PlanesDatabase();
  final _planUserDatabase = PlanUserDatabase();
  final _miembrosDatabase = MiembrosDatabase();

  Future<bool> obtenerPlanes() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_planes');

      final resp = await http.post(url, body: {
        'tn': _prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      if (decodedData["result"].length > 0) {
        for (var i = 0; i < decodedData["result"].length; i++) {
          var plancito = decodedData["result"][i];
          PlanesModel plan = PlanesModel();

          plan.idPlan = plancito["id_plan_tipo"];
          plan.nombre = plancito["plan_tipo_nombre"];
          plan.descripcion = plancito["plan_tipo_descripcion"];
          plan.costo = plancito["plan_tipo_costo"];
          plan.estado = plancito["plan_tipo_estado"];

          await _planesDatabase.insertarPlan(plan);
        }
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> obtenerPlanUser() async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_planes_usuario');

      final resp = await http.post(url, body: {
        'tn': _prefs.token,
        'app': 'true',
        'id_usuario': _prefs.idUser,
      });

      final decodedData = json.decode(resp.body);

      if (decodedData["result"].length > 0) {
        for (var i = 0; i < decodedData["result"].length; i++) {
          var plancU = decodedData["result"][i];
          PlanUserModel plan = PlanUserModel();
          plan.idUserPlan = plancU["id_plan"];
          plan.idUser = plancU["id_usuario"];
          plan.idNegocio = plancU["id_negocio"];
          plan.idPlan = plancU["plan_tipo"];
          plan.inicioFecha = plancU["plan_inicio"];
          plan.finFecha = plancU["plan_fin"];
          plan.voucher = plancU["plan_voucher"];
          plan.estado = plancU["plan_estado"];
          await _planUserDatabase.insertarPlanUser(plan);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> obtenerMiembrosPlan(String idPlan) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/listar_miembros');

      final resp = await http.post(url, body: {
        'tn': _prefs.token,
        'app': 'true',
        'id_plan': idPlan,
      });

      final decodedData = json.decode(resp.body);
      if (decodedData["result"].length > 0) {
        for (var i = 0; i < decodedData["result"].length; i++) {
          var miembros = decodedData["result"][i];

          MiembrosModel miembro = MiembrosModel();
          miembro.idMiembro = miembros["id_miembro"];
          miembro.idPlan = miembros["id_plan"];
          miembro.idUser = miembros["id_usuario"];
          miembro.nombre = miembros["persona_nombre"];
          miembro.imagen = miembros["usuario_imagen"];
          miembro.apellidoMaterno = miembros["persona_apellido_materno"];
          miembro.apellidoPaterno = miembros["persona_apellido_paterno"];

          miembro.fechaCreacion = miembros["miembro_creacion"];
          miembro.estado = miembros["miembro_estado"];

          if (miembros["id_usuario"] == _prefs.idUser) {
            miembro.puesto = 'Propietario del negocio';
          } else {
            miembro.puesto = 'Mesero';
          }

          await _miembrosDatabase.insertarMiembroPlan(miembro);
        }

        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<int> agregarMiembroAlPlan(String idPlan, String idUser) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/agregar_miembros');

      final resp = await http.post(url, body: {
        'tn': _prefs.token,
        'app': 'true',
        'id_plan': idPlan,
        'id_usuario': idUser,
      });

      final decodedData = json.decode(resp.body);

      print(decodedData);
      if (decodedData["result"] == 1) {
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> quitarMiembroAlPlan(String idPlan, String idMiembro) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Negocio/eliminar_miembros');

      final resp = await http.post(url, body: {
        'tn': _prefs.token,
        'app': 'true',
        'id_plan': idPlan,
        'id_miembro': idMiembro,
      });

      final decodedData = json.decode(resp.body);

      print(decodedData);
      if (decodedData["result"] == 1) {
        await _miembrosDatabase.deleteMiembroPlanPorId(idMiembro);
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}
