import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/linea_api.dart';
import 'package:mesita_aplication_2/src/api/login_api.dart';
import 'package:mesita_aplication_2/src/api/planes_api.dart';
import 'package:mesita_aplication_2/src/api/user_api.dart';
import 'package:mesita_aplication_2/src/pages/User/modal_edit_perfil.dart';
import 'package:mesita_aplication_2/src/pages/home.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

enum PageMostrar { inicioSesion, registro }

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PageMostrar _currentPage = PageMostrar.inicioSesion;
  bool _passwordVisible;
  String mensaje = '';
  final _controller = ControllerNotifier();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwdLoginController = TextEditingController();
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwdController = TextEditingController();
  final TextEditingController _confrimPasswdController = TextEditingController();

  //COMPLETAR DATOS
  TextEditingController _nombre2Controller = new TextEditingController();
  TextEditingController _apellidoPaternoController = new TextEditingController();
  TextEditingController _apellidoMaternoController = new TextEditingController();

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: -ScreenUtil().setWidth(150),
            top: -ScreenUtil().setHeight(250),
            child: Container(
              width: ScreenUtil().setHeight(280) * 2,
              height: ScreenUtil().setHeight(280) * 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/img_login.jpg'),
                ),
                borderRadius: BorderRadius.all(Radius.circular(900)),
                color: Colors.redAccent,
              ),
            ), /* CircleAvatar(
              radius: ScreenUtil().setHeight(280),
              backgroundImage: const AssetImage('assets/img/img_login.jpg'),
            ), */
          ),
          Positioned(
            left: -ScreenUtil().setWidth(120),
            top: -ScreenUtil().setHeight(250),
            child: Container(
              width: ScreenUtil().setHeight(280) * 2,
              height: ScreenUtil().setHeight(280) * 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(280)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      const Color(0xffFF6787).withOpacity(.6),
                      const Color(0xffFF0036).withOpacity(.8),
                    ],

                    //
                  ),
                  color: Colors.black),
            ),
          ),
          Positioned(
            left: -ScreenUtil().setWidth(150),
            top: -ScreenUtil().setHeight(250),
            child: Container(
              width: ScreenUtil().setHeight(280) * 2,
              height: ScreenUtil().setHeight(280) * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(280)),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xffFF6787).withOpacity(.6),
                    const Color(0xffFF0036).withOpacity(.8),
                  ],

                  //
                ),
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/mesita_logo.svg',
                  fit: BoxFit.cover,
                  color: Colors.white,
                  height: ScreenUtil().setHeight(240),
                  width: ScreenUtil().setHeight(240),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(260),
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffb4b5e5).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              width: double.infinity,
              height: ScreenUtil().setHeight(470),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _currentPage == PageMostrar.inicioSesion ? inicioSe() : registro(),
              ),
            ),
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (_, s) {
                return (_controller.cargando) ? _mostrarAlert() : Container();
              })
        ],
      ),
    );
  }

  Widget _mostrarAlert() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? CircularProgressIndicator(
                color: Color(0xffFF0036),
              )
            : CupertinoActivityIndicator(),
      ),
    );
  }

  Widget inicioSe() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xffeaeaf5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(5),
                      horizontal: ScreenUtil().setWidth(2),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Center(
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(0),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = PageMostrar.registro;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(5),
                        horizontal: ScreenUtil().setWidth(2),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(32),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              controller: _userNameController,
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Ingresa tu usuario'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: AnimatedBuilder(
                animation: _controller,
                builder: (_, f) {
                  return TextField(
                    obscureText: _controller.passwdDisable,
                    controller: _passwdLoginController,
                    cursorColor: Colors.transparent,
                    keyboardType: TextInputType.text,
                    maxLines: 1,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(15),
                        horizontal: ScreenUtil().setWidth(10),
                      ),
                      hintStyle: const TextStyle(
                        color: Color(0xffa8a7a7),
                      ),
                      hintText: 'Contraseña',
                      suffixIcon: IconButton(
                        padding: EdgeInsets.all(0),
                        onPressed: () {
                          _controller.changePasswdDisable(!_controller.passwdDisable);
                        },
                        icon: _controller.passwdDisable
                            ? Icon(
                                Icons.visibility,
                                color: Color(0xffa8a7a7),
                              )
                            : Icon(
                                Icons.visibility_off,
                                color: Color(0xffa8a7a7),
                              ),
                      ),
                    ),
                    enableInteractiveSelection: true,
                  );
                }),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              '¿Olvidaste la contraseña?',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: const Color(0xffa8a7a7),
                fontSize: ScreenUtil().setSp(18),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              elevation: 10,
              onPressed: () async {
                _controller.changeCargando(true);
                _controller.changeMensaje('');
                if (_userNameController.text.length > 0 && _passwdLoginController.text.length > 0) {
                  final _loginApi = LoginApi();
                  final res = await _loginApi.login(_userNameController.text, _passwdLoginController.text);

                  if (res.code == '1') {
                    final preferences = Preferences();
                    final _lineaApi = LineaApi();
                    final _planApi = PlanesApi();
                    await _lineaApi.obtenerLineasPorNegocio();
                    await _planApi.obtenerPlanUser();

                    final resp = compararFechaConActual(preferences.finPlan);

                    if (resp) {
                      Navigator.pushReplacementNamed(context, 'planes');
                    } else {
                      Navigator.pushReplacementNamed(context, 'home');

                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation, secondaryAnimation) {
                            return Home();
                          },
                          transitionsBuilder: (context, animation, secondaryAnimation, child) {
                            var begin = Offset(0.0, 1.0);
                            var end = Offset.zero;
                            var curve = Curves.ease;

                            var tween = Tween(begin: begin, end: end).chain(
                              CurveTween(curve: curve),
                            );

                            return SlideTransition(
                              position: animation.drive(tween),
                              child: child,
                            );
                          },
                        ),
                      );
                    }

                    _controller.changeCargando(false);
                  } else if (res.code == '4') {
                    _userNameController.text = '';
                    _passwdLoginController.text = '';
                    _controller.changeMensaje(res.message);
                  } else {
                    _controller.changeMensaje(res.message);
                  }
                } else {
                  _controller.changeMensaje('Complete los campos');
                }
                _controller.changeCargando(false);
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: const Text('Continuar'),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Center(
                  child: Text(
                    _controller.mensaje,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xffa8a7a7),
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  Widget registro() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xffeaeaf5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = PageMostrar.inicioSesion;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(5),
                        horizontal: ScreenUtil().setWidth(2),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(5),
                      horizontal: ScreenUtil().setWidth(2),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Center(
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(16),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(32),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              controller: _nombreController,
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Nombre'),
              enableInteractiveSelection: false,
              onTap: () {
                FocusScope.of(context).requestFocus(new FocusNode());
                _completarDatosPersona(context);
              },
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Email'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              controller: _userController,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Usuario'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              controller: _passwdController,
              obscureText: _passwordVisible,
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(15),
                  horizontal: ScreenUtil().setWidth(10),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xffa8a7a7),
                ),
                hintText: 'Contraseña',
                suffixIcon: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      if (_passwordVisible) {
                        _passwordVisible = false;
                      } else {
                        _passwordVisible = true;
                      }
                    });
                  },
                  icon: _passwordVisible
                      ? Icon(
                          Icons.visibility,
                          color: Color(0xffa8a7a7),
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Color(0xffa8a7a7),
                        ),
                ),
              ),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              controller: _confrimPasswdController,
              obscureText: _passwordVisible,
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Confirma contraseña'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              elevation: 10,
              onPressed: () async {
                _controller.changeCargando(true);
                _controller.changeMensaje2('');

                if (_nombre2Controller.text.length > 0 &&
                    _emailController.text.length > 0 &&
                    _userController.text.length > 0 &&
                    _passwdController.text.length > 0 &&
                    _confrimPasswdController.text.length > 0) {
                  if (_passwdController.text == _confrimPasswdController.text) {
                    final _userApi = UserApi();

                    final res = await _userApi.registarNuevoUsuario(_nombre2Controller.text, _apellidoPaternoController.text,
                        _apellidoMaternoController.text, _emailController.text, _userController.text, _passwdController.text);
                    if (res == 1) {
                      showToast('¡Registro exitoso!, Ahora puede iniciar sesión.', Colors.black);
                      _nombreController.text = '';
                      _nombre2Controller.text = '';
                      _apellidoPaternoController.text = '';
                      _apellidoMaternoController.text = '';
                      _emailController.text = '';
                      _userController.text = '';
                      _passwdController.text = '';
                      _confrimPasswdController.text = '';
                      setState(() {
                        _currentPage = PageMostrar.inicioSesion;
                      });
                    } else {
                      _controller.changeMensaje2('Ocurrió un error');
                    }
                  } else {
                    _controller.changeMensaje2('Contraseñas no coinciden');
                  }
                } else {
                  _controller.changeMensaje2('Complete todos los campos');
                }
                _controller.changeCargando(false);
              },
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: const Text('Continuar'),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Center(
                  child: Text(
                    _controller.mensaje2,
                    style: TextStyle(
                      color: const Color(0xffa8a7a7),
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                );
              })
        ],
      ),
    );
  }

  void _completarDatosPersona(BuildContext context) {
    final _controller = ChangeEditPerfilController();
    final _prefs = Preferences();

    FocusNode _focus1 = FocusNode();
    FocusNode _focus2 = FocusNode();
    FocusNode _focus3 = FocusNode();

    _nombre2Controller.text = _prefs.personName;
    _apellidoPaternoController.text = _prefs.personApellidoPaterno;
    _apellidoMaternoController.text = _prefs.personApellidoMaterno;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Stack(
            children: [
              Container(
                color: Color.fromRGBO(0, 0, 0, 0.001),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.93,
                    minChildSize: 0.2,
                    maxChildSize: 0.93,
                    builder: (_, controller) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(30),
                            topRight: const Radius.circular(30),
                          ),
                        ),
                        child: KeyboardActions(
                          config: KeyboardActionsConfig(keyboardSeparatorColor: Colors.white, keyboardBarColor: Colors.white, actions: [
                            KeyboardActionsItem(focusNode: _focus1),
                            KeyboardActionsItem(focusNode: _focus2),
                            KeyboardActionsItem(focusNode: _focus3),
                          ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(24)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setWidth(4),
                                    child: Center(
                                      child: Container(
                                        width: ScreenUtil().setWidth(48),
                                        decoration: BoxDecoration(
                                          color: Color(0XFFBABABA),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(10),
                                  ),
                                  Center(
                                    child: Text(
                                      'Ingresar Datos',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFFFF0036),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Text(
                                    'Nombre',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus1,
                                    controller: _nombre2Controller,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_nombre2Controller.text.length > 0 &&
                                          _apellidoPaternoController.text.length > 0 &&
                                          _apellidoMaternoController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Nombre',
                                      hintStyle: TextStyle(
                                        color: Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Text(
                                    'Apellido paterno',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus2,
                                    controller: _apellidoPaternoController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_nombre2Controller.text.length > 0 &&
                                          _apellidoPaternoController.text.length > 0 &&
                                          _apellidoMaternoController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Apellido paterno',
                                      hintStyle: TextStyle(
                                        color: Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Text(
                                    'Apellido materno',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus3,
                                    controller: _apellidoMaternoController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_nombre2Controller.text.length > 0 &&
                                          _apellidoPaternoController.text.length > 0 &&
                                          _apellidoMaternoController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Apellido materno',
                                      hintStyle: TextStyle(
                                        color: Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(48)),
                                  InkWell(
                                    onTap: () {
                                      if (_controller.boton) {
                                        _nombreController.text =
                                            '${_nombre2Controller.text} ${_apellidoPaternoController.text} ${_apellidoMaternoController.text}';
                                        Navigator.pop(context);
                                      }
                                    },
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: (_controller.boton) ? Color(0XFFFF0036) : Color(0XFFFF0036).withOpacity(0.6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Hecho',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                              ),
                                              height: ScreenUtil().setHeight(44),
                                              width: ScreenUtil().setWidth(255),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(8)),
                                  Center(
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Text(
                                            _controller.text,
                                            style: TextStyle(
                                              color: Color(0XFFFF0036),
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: ScreenUtil().setSp(0.016),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: GoogleFonts.poppins(
                                          color: Color(0XFF8A8A8A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (_, s) {
                    if (_controller.cargando) {
                      return _mostrarAlert();
                    } else {
                      return Container();
                    }
                  })
            ],
          );
        });
  }
}

class ControllerNotifier extends ChangeNotifier {
  bool cargando = false;
  String mensaje = '';
  String mensaje2 = '';

  bool passwdDisable = true;

  void changePasswdDisable(bool v) {
    passwdDisable = v;
    notifyListeners();
  }

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeMensaje(String m) {
    mensaje = m;
    notifyListeners();
  }

  void changeMensaje2(String m) {
    mensaje2 = m;
    notifyListeners();
  }
}
