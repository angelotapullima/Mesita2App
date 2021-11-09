import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/user_api.dart';
import 'package:mesita_aplication_2/src/pages/User/modal_edit_perfil.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class CuentaPage extends StatefulWidget {
  const CuentaPage({Key key}) : super(key: key);

  @override
  _CuentaPageState createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  TextEditingController _nombreController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _contraController = TextEditingController();

  final _controller = CuentaController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final preferences = Preferences();
      _nombreController.text = '${preferences.personName} ${preferences.personSurname}';
      _emailController.text = preferences.userNickname;
      _contraController.text = '******';
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Cuenta',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: AnimatedBuilder(
              animation: _controller,
              builder: (context, snapshot) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Center(
                      child: Container(
                        width: ScreenUtil().setWidth(120),
                        height: ScreenUtil().setHeight(140),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Stack(
                            children: [
                              Container(
                                width: double.infinity,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => Container(
                                    child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
                                  ),
                                  errorWidget: (context, url, error) => Container(
                                    child: Container(
                                      child: SvgPicture.asset(
                                        'assets/settings_svg/porfile.svg',
                                      ),
                                    ),
                                  ),
                                  imageUrl: '${prefs.userImage}',
                                  imageBuilder: (context, imageProvider) => Container(
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                        image: imageProvider,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  height: ScreenUtil().setHeight(30),
                                  width: ScreenUtil().setWidth(120),
                                  decoration: BoxDecoration(
                                    color: Colors.black,
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.photo_camera,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'Nombre',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
                      controller: _nombreController,
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.number,
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
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      onTap: () {
                        FocusScope.of(context).requestFocus(new FocusNode());
                        if (!_controller.enableImput) {
                          _editPersonData(context);
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'Email',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
                      controller: _emailController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        hintStyle: TextStyle(
                          color: Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'Contraseña',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
                      controller: _contraController,
                      obscureText: true,
                      keyboardType: TextInputType.number,
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
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      height: ScreenUtil().setHeight(30),
                    ),
                    (_controller.editarActive == false)
                        ? Center(
                            child: MaterialButton(
                              onPressed: () {
                                _controller.changeActive(true);
                              },
                              child: Text(
                                'Editar Perfil',
                                style: TextStyle(
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              textColor: Colors.red,
                            ),
                          )
                        : Center(
                            child: InkWell(
                              onTap: () {
                                _controller.changeActive(false);
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(10)),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(22),
                                  color: Color(0XFFFF0036),
                                ),
                                child: Text(
                                  'Hecho',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          )
                  ],
                );
              }),
        ),
      ),
    );
  }

  void _editPersonData(BuildContext context) {
    final _controller = ChangeEditPerfilController();
    final _prefs = Preferences();

    TextEditingController _nombre2Controller = new TextEditingController();
    TextEditingController _apellidoPaternoController = new TextEditingController();
    TextEditingController _apellidoMaternoController = new TextEditingController();

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
                                      'Editar perfil',
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
                                    onTap: () async {
                                      _controller.changeCargando(true);
                                      _controller.changeText('');
                                      if (_controller.boton) {
                                        final _userApi = UserApi();
                                        final res = await _userApi.editarPersona(
                                            _nombre2Controller.text, _apellidoPaternoController.text, _apellidoMaternoController.text);
                                        if (res == 1) {
                                          Navigator.pop(context);
                                          final preferences = Preferences();
                                          _nombreController.text = '${preferences.personName} ${preferences.personSurname}';
                                          setState(() {});
                                        } else {
                                          _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                        }
                                      }

                                      _controller.changeCargando(false);
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
                      return _showLoading();
                    } else {
                      return Container();
                    }
                  })
            ],
          );
        });
  }

  _showLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? CircularProgressIndicator(
                color: Color(0XFFFF0036),
              )
            : CupertinoActivityIndicator(),
      ),
    );
  }
}

class CuentaController extends ChangeNotifier {
  bool editarActive = false;
  bool enableImput = true;

  void changeActive(bool a) {
    editarActive = a;
    enableImput = !a;
    notifyListeners();
  }
}
