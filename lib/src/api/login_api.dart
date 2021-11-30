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
        if (decodedData['data']['data_negocio']['tiene_negocio'] != 0) {
          //Guardar datos Usuario
          _prefs.idUser = '${decodedData['data']['c_u']}';
          _prefs.idPerson = '${decodedData['data']['c_p']}';
          _prefs.userNickname = '${decodedData['data']['_n']}';
          _prefs.userImage = '${decodedData['data']['u_i']}';
          _prefs.personName = '${decodedData['data']['p_n']}';
          _prefs.personSurname = '${decodedData['data']['p_p']} ${decodedData['data']['p_m']}';
          _prefs.personApellidoPaterno = '${decodedData['data']['p_p']}';
          _prefs.personApellidoMaterno = '${decodedData['data']['p_m']}';
          _prefs.token = decodedData['data']['tn'];
          //Guardar rol Usuario
          _prefs.idRol = '${decodedData['data']['ru']}';
          _prefs.rolName = '${decodedData['data']['rn']}';

          //Guardar plan
          _prefs.tipoPlan = '${decodedData['data']['data_negocio']['plan']['tipo']}';
          _prefs.inicioPlan = '${decodedData['data']['data_negocio']['plan']['inicio']}';
          _prefs.finPlan = '${decodedData['data']['data_negocio']['plan']['fin']}';
          _prefs.estadoPlan = '${decodedData['data']['data_negocio']['plan']['estado']}';
          //Guardar Negocio
          _prefs.idNegocio = '${decodedData['data']['data_negocio']['negocio']['id']}';
          _prefs.negocioNombre = '${decodedData['data']['data_negocio']['negocio']['nombre']}';
          _prefs.negocioDireccion = '${decodedData['data']['data_negocio']['negocio']['direccion']}';
          _prefs.negocioTelefono = '${decodedData['data']['data_negocio']['negocio']['telefono']}';
          _prefs.negocioRUC = '${decodedData['data']['data_negocio']['negocio']['ruc']}';
          _prefs.negocioRazonSocial = '${decodedData['data']['data_negocio']['negocio']['razonsocial']}';
          // _prefs.negocioImage = '$apiBaseURL/${decodedData['data']['n_f']}';

        } else {
          loginModel.code = '4';
          loginModel.message = 'Usuario no se encuentra asignado a algún negocio';
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
