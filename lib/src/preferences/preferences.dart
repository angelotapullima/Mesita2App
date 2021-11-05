import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static final Preferences _instancia = Preferences._internal();

  factory Preferences() {
    return _instancia;
  }

  SharedPreferences _prefs;

  Preferences._internal();

  initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  clearPreferences() async {
    await _prefs.clear();
  }

  get idUser {
    return _prefs.getString('idUser');
  }

  set idUser(String value) {
    _prefs.setString('idUser', value);
  }

  get userNickname {
    return _prefs.getString('user_nickname');
  }

  set userNickname(String value) {
    _prefs.setString('user_nickname', value);
  }

  get userImage {
    return _prefs.getString('userImage');
  }

  set userImage(String value) {
    _prefs.setString('userImage', value);
  }

  get personName {
    return _prefs.getString('person_name');
  }

  set personName(String value) {
    _prefs.setString('person_name', value);
  }

  get personSurname {
    return _prefs.getString('person_surname');
  }

  set personSurname(String value) {
    _prefs.setString('person_surname', value);
  }

  get personApellidoPaterno {
    return _prefs.getString('personApellidoPaterno');
  }

  set personApellidoPaterno(String value) {
    _prefs.setString('personApellidoPaterno', value);
  }

  get personApellidoMaterno {
    return _prefs.getString('personApellidoMaterno');
  }

  set personApellidoMaterno(String value) {
    _prefs.setString('personApellidoMaterno', value);
  }

  get token {
    return _prefs.getString('token');
  }

  set token(String value) {
    _prefs.setString('token', value);
  }

  get idNegocio {
    return _prefs.getString('idNegocio');
  }

  set idNegocio(String value) {
    _prefs.setString('idNegocio', value);
  }

  get negocioNombre {
    return _prefs.getString('negocioNombre');
  }

  set negocioNombre(String value) {
    _prefs.setString('negocioNombre', value);
  }

  get negocioImage {
    return _prefs.getString('negocioImage');
  }

  set negocioImage(String value) {
    _prefs.setString('negocioImage', value);
  }

  get idRol {
    return _prefs.getString('idRol');
  }

  set idRol(String value) {
    _prefs.setString('idRol', value);
  }

  get rolName {
    return _prefs.getString('rolName');
  }

  set rolName(String value) {
    _prefs.setString('rolName', value);
  }

  get negocioDireccion {
    return _prefs.getString('negocioDireccion');
  }

  set negocioDireccion(String value) {
    _prefs.setString('negocioDireccion', value);
  }

  get tipoPlan {
    return _prefs.getString('tipoPlan');
  }

  set tipoPlan(String value) {
    _prefs.setString('tipoPlan', value);
  }

  get idPlan {
    return _prefs.getString('idPlan');
  }

  set idPlan(String value) {
    _prefs.setString('idPlan', value);
  }

  get inicioPlan {
    return _prefs.getString('inicioPlan');
  }

  set inicioPlan(String value) {
    _prefs.setString('inicioPlan', value);
  }

  get finPlan {
    return _prefs.getString('finPlan');
  }

  set finPlan(String value) {
    _prefs.setString('finPlan', value);
  }

  get estadoPlan {
    return _prefs.getString('estadoPlan');
  }

  set estadoPlan(String value) {
    _prefs.setString('estadoPlan', value);
  }
}
