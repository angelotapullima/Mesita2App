import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class LoginApi {
  final _prefs = new Preferences();

  Future<LoginModel> login(String user, String pass) async {
    try {
      final url = Uri.parse('$apiBaseURL/api/Login/validar_sesion');

      final resp = await http.post(url, body: {
        'usuario_nickname': '$user',
        'usuario_contrasenha': '$pass',
        'app': 'true',
      });

      final decodedData = json.decode(resp.body);

      final int code = decodedData['result']['code'];
      LoginModel loginModel = LoginModel();
      loginModel.code = code.toString();
      loginModel.message = decodedData['result']['message'];

      if (code == 1) {
        if (decodedData['data']['agente'] != 0) {
          //Guardar datos Usuario
          _prefs.idUser = decodedData['data']['c_u'];
          _prefs.userNickname = decodedData['data']['_n'];
          _prefs.userImage = '${decodedData['data']['u_i']}';
          _prefs.personName = decodedData['data']['p_n'];
          _prefs.personSurname = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
          _prefs.personApellidoPaterno = '${decodedData['data']['p_p']}';
          _prefs.personApellidoMaterno = '${decodedData['data']['p_m']}';
          _prefs.token = decodedData['data']['tn'];
          //Guardar rol Usuario
          _prefs.idRol = decodedData['data']['ru'];
          _prefs.rolName = decodedData['data']['rn'];
          //Guardar plan
          _prefs.tipoPlan = decodedData['data']['plan']['tipo'];
          _prefs.inicioPlan = decodedData['data']['plan']['inicio'];
          _prefs.estadoPlan = decodedData['data']['plan']['estado'];
          //Guardar Negocio
          _prefs.idNegocio = decodedData['data']['negocio']['id'];
          _prefs.negocioNombre = decodedData['data']['negocio']['nombre'];
          _prefs.negocioDireccion = decodedData['data']['negocio']['direccion'];
          // _prefs.negocioImage = '$apiBaseURL/${decodedData['data']['n_f']}';

        } else {
          loginModel.code = '2';
          loginModel.message = decodedData['result']['message'];
        }

        return loginModel;
      } else {
        return loginModel;
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      LoginModel loginModel = LoginModel();
      loginModel.code = '2';
      loginModel.message = 'Error en la petición';
      return loginModel;
    }
  }
}

class LoginModel {
  String code;
  String message;
  String page;

  LoginModel({this.code, this.message, this.page});
}
