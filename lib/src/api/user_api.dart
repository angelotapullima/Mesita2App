import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class UserApi {
  final _prefs = Preferences();

  Future<int> registarNuevoUsuario(String nombre, String apellidoPaterno, String apellidoMaterno, String email, String usuario, String passwd) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Usuario/guardar_nuevo_usuario');

      final resp = await http.post(url, body: {
        'persona_nombre': '$nombre',
        'persona_apellido_paterno': '$apellidoPaterno',
        'persona_apellido_materno': '$apellidoMaterno',
        'persona_nacimiento': '-',
        'persona_telefono': '-',
        'id_rol': '4',
        'usuario_nickname': '$usuario',
        'usuario_contrasenha': '$passwd',
        'usuario_email': '$email',
        'usuario_imagen': '-',
        'usuario_estado': '1',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print('Respuesta guardar user persona $decodedData');
      if (decodedData['result']['code'] == 1) {
        // _prefs.personName = decodedData['result']['persona']['persona_nombre'];
        // _prefs.personApellidoMaterno = decodedData['result']['persona']['persona_apellido_materno'];
        // _prefs.personApellidoPaterno = decodedData['result']['persona']['persona_apellido_paterno'];
        // _prefs.personSurname = '${_prefs.personApellidoPaterno} ${_prefs.personApellidoMaterno}';
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> editarPersona(String nombre, String apellidoPaterno, String apellidoMaterno) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Usuario/guardar_edicion_persona');

      final resp = await http.post(url, body: {
        'persona_nombre_e': '$nombre',
        'persona_apellido_paterno_e': '$apellidoPaterno',
        'persona_apellido_materno_e': '$apellidoMaterno',
        'persona_nacimiento_e': '-',
        'persona_telefono_e': '-',
        'id_persona': _prefs.idPerson,
        'tn': _prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print('Respuesta editar persona $decodedData');
      if (decodedData['result']['code'] == 1) {
        _prefs.personName = decodedData['result']['persona']['persona_nombre'];
        _prefs.personApellidoMaterno = decodedData['result']['persona']['persona_apellido_materno'];
        _prefs.personApellidoPaterno = decodedData['result']['persona']['persona_apellido_paterno'];
        _prefs.personSurname = '${_prefs.personApellidoPaterno} ${_prefs.personApellidoMaterno}';
        return 1;
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }
}
