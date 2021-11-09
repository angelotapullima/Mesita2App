import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/api/login_api.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';
import 'package:path/path.dart';

class UserApi {
  final _prefs = Preferences();

  Future<int> registarNuevoUsuario(String nombre, String apellidoPaterno, String apellidoMaterno, String email, String usuario, String passwd) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Inicio/guardar_usuario');

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

  Future<int> changePassword(String password) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Usuario/restablecer_contrasenha');

      final resp = await http.post(url, body: {
        'contrasenha': '$password',
        'id_usuario': _prefs.idUser,
        'tn': _prefs.token,
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);
      print('Respuesta cambiar contraseña: $decodedData');
      if (decodedData['result']['code'] == 1) {
        final _loginApi = LoginApi();
        final res = await _loginApi.login(_prefs.userNickname, password);
        print(res.message);
        if (res.code == '1') {
          return 1;
        } else {
          return 2;
        }
      } else {
        return 2;
      }
    } catch (e) {
      return 2;
    }
  }

  Future<int> cambiarFotoUsuario(File _image) async {
    print('Entré para cambiar foto WEB SERVICE');
    try {
      int resp;
      final uri = Uri.parse('$apiBaseURL/api/Usuario/guardar_edicion_usuario');

      var multipartFile;

      if (_image != null) {
        var stream = new http.ByteStream(Stream.castFrom(_image.openRead()));

        var length = await _image.length();

        multipartFile = new http.MultipartFile('usuario_imagen_e', stream, length, filename: basename(_image.path));
      }

      var request = new http.MultipartRequest("POST", uri);

      request.fields["app"] = 'true';
      request.fields["tn"] = '${_prefs.token}';
      request.fields["id_rol_e"] = _prefs.idRol;
      request.fields["usuario_nickname_e"] = _prefs.userNickname;
      request.fields["usuario_email_e"] = '-';
      request.fields["usuario_estado_e"] = '1';
      request.fields["id_usuario"] = _prefs.idUser;

      if (_image != null) {
        request.files.add(multipartFile);
      }

      await request.send().then((response) async {
        // listen for response
        response.stream.transform(utf8.decoder).listen((value) {
          final decodedData = json.decode(value);
          print('Resultado actualizar imagen usuario: $decodedData');

          if (decodedData["result"] == 1) {
            resp = 1;
          } else {
            resp = 2;
          }
        });
      }).catchError((e) {
        print(e);
        resp = 2;
      });
      return resp;
    } catch (e) {
      print('Exeption cambiar foto: $e');
      return 2;
    }
  }
}
