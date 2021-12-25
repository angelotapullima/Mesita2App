import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/user_api.dart';
import 'package:mesita_aplication_2/src/pages/User/modal_edit_perfil.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class CuentaPage extends StatefulWidget {
  const CuentaPage({Key key}) : super(key: key);

  @override
  _CuentaPageState createState() => _CuentaPageState();
}

class _CuentaPageState extends State<CuentaPage> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _contraController = TextEditingController();

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
        iconTheme: const IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Cuenta',
          style: GoogleFonts.poppins(
            color: const Color(0XFF3A3A3A),
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
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(150),
                          child: Stack(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: double.infinity,
                                child: CachedNetworkImage(
                                  placeholder: (context, url) => SizedBox(
                                    child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
                                  ),
                                  errorWidget: (context, url, error) => SizedBox(
                                    child: SvgPicture.asset(
                                      'assets/settings_svg/porfile.svg',
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
                                child: InkWell(
                                  onTap: () {
                                    if (!_controller.enableImput) {
                                      _updatePhotoProductModal(context);
                                    }
                                  },
                                  child: Container(
                                    height: ScreenUtil().setHeight(30),
                                    width: ScreenUtil().setWidth(120),
                                    decoration: const BoxDecoration(
                                      color: Colors.black,
                                    ),
                                    child: const Center(
                                      child: Icon(
                                        Icons.photo_camera,
                                        color: Colors.white,
                                      ),
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
                          color: const Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                      ),
                      style: TextStyle(
                        color: const Color(0XFF585858),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(16),
                        fontStyle: FontStyle.normal,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (!_controller.enableImput) {
                          _editPersonData(context);
                        }
                      },
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(30),
                    ),
                    Text(
                      'Usuario',
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
                        hintText: 'Usuario',
                        hintStyle: TextStyle(
                          color: const Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                      ),
                      style: TextStyle(
                        color: const Color(0XFF585858),
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
                      enableInteractiveSelection: false,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Contraseña',
                        hintStyle: TextStyle(
                          color: const Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: const Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        ),
                      ),
                      style: TextStyle(
                        color: const Color(0XFF585858),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(16),
                        fontStyle: FontStyle.normal,
                      ),
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                        if (!_controller.enableImput) {
                          _changePassword(context);
                        }
                      },
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
                                  color: const Color(0XFFFF0036),
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

    final TextEditingController _nombre2Controller = TextEditingController();
    final TextEditingController _apellidoPaternoController = TextEditingController();
    final TextEditingController _apellidoMaternoController = TextEditingController();

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
                color: const Color.fromRGBO(0, 0, 0, 0.001),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.93,
                    minChildSize: 0.2,
                    maxChildSize: 0.93,
                    builder: (_, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
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
                                        decoration: const BoxDecoration(
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
                                        color: const Color(0XFFFF0036),
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
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus1,
                                    controller: _nombre2Controller,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_nombre2Controller.text.isNotEmpty &&
                                          _apellidoPaternoController.text.isNotEmpty &&
                                          _apellidoMaternoController.text.isNotEmpty) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Nombre',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
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
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus2,
                                    controller: _apellidoPaternoController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_nombre2Controller.text.isNotEmpty &&
                                          _apellidoPaternoController.text.isNotEmpty &&
                                          _apellidoMaternoController.text.isNotEmpty) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Apellido paterno',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
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
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus3,
                                    controller: _apellidoMaternoController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_nombre2Controller.text.isNotEmpty &&
                                          _apellidoPaternoController.text.isNotEmpty &&
                                          _apellidoMaternoController.text.isNotEmpty) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Apellido materno',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
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
                                                color: (_controller.boton) ? const Color(0XFFFF0036) : const Color(0XFFFF0036).withOpacity(0.6),
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
                                              color: const Color(0XFFFF0036),
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
                                          color: const Color(0XFF8A8A8A),
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

  void _changePassword(BuildContext context) {
    final _controller = ChangeEditPerfilController();

    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController = TextEditingController();

    FocusNode _focus1 = FocusNode();
    FocusNode _focus2 = FocusNode();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Stack(
            children: [
              Container(
                color: const Color.fromRGBO(0, 0, 0, 0.001),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.93,
                    minChildSize: 0.2,
                    maxChildSize: 0.93,
                    builder: (_, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: KeyboardActions(
                          config: KeyboardActionsConfig(keyboardSeparatorColor: Colors.white, keyboardBarColor: Colors.white, actions: [
                            KeyboardActionsItem(focusNode: _focus1),
                            KeyboardActionsItem(focusNode: _focus2),
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
                                        decoration: const BoxDecoration(
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
                                      'Actualizar contraseña',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFFFF0036),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Text(
                                    'Contraseña',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus1,
                                    controller: _passwordController,
                                    obscureText: true,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_confirmPasswordController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                        if (_confirmPasswordController.text == _passwordController.text) {
                                          _controller.changeBoton(true);
                                        } else {
                                          _controller.changeBoton(false);
                                        }
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Ingresar contraseña',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Text(
                                    'Confirmar contraseña',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus2,
                                    controller: _confirmPasswordController,
                                    obscureText: true,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (_confirmPasswordController.text.isNotEmpty && _passwordController.text.isNotEmpty) {
                                        if (_confirmPasswordController.text == _passwordController.text) {
                                          _controller.changeBoton(true);
                                        } else {
                                          _controller.changeBoton(false);
                                        }
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Confirma tu contraseña',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
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
                                        final res = await _userApi.changePassword(_passwordController.text);
                                        if (res == 1) {
                                          Navigator.pop(context);
                                          showToast('Contraseña actualizada', Colors.black);
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
                                                color: (_controller.boton) ? const Color(0XFFFF0036) : const Color(0XFFFF0036).withOpacity(0.6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Confirmar',
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
                                              color: const Color(0XFFFF0036),
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
                                          color: const Color(0XFF8A8A8A),
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

  void _updatePhotoProductModal(BuildContext context) {
    final _controller = CuentaController();
    final picker = ImagePicker();
    Future<void> _cropImage(filePath) async {
      File croppedImage = await ImageCropper.cropImage(
          sourcePath: filePath,
          aspectRatioPresets: Platform.isAndroid
              ? [
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio16x9
                ]
              : [
                  CropAspectRatioPreset.original,
                  CropAspectRatioPreset.square,
                  CropAspectRatioPreset.ratio3x2,
                  CropAspectRatioPreset.ratio4x3,
                  CropAspectRatioPreset.ratio5x3,
                  CropAspectRatioPreset.ratio5x4,
                  CropAspectRatioPreset.ratio7x5,
                  CropAspectRatioPreset.ratio16x9
                ],
          androidUiSettings: const AndroidUiSettings(
              toolbarTitle: 'Cortar Imagen',
              toolbarColor: Color(0XFFFF0036),
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.original,
              showCropGrid: true,
              lockAspectRatio: false),
          iosUiSettings: const IOSUiSettings(minimumAspectRatio: 1.0, title: 'Cortar Imagen'));
      if (croppedImage != null) {
        _controller.changeImage(croppedImage);
      }
    }

    Future getImageCamera() async {
      final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 70);

      if (pickedFile != null) {
        _cropImage(pickedFile.path);
      }
    }

    Future getImageGallery() async {
      final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 70);

      if (pickedFile != null) {
        _cropImage(pickedFile.path);
      }
      /**/
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.2,
                minChildSize: 0.2,
                maxChildSize: 0.2,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(24),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(24),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              getImageGallery();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Seleccionar foto',
                                  style: GoogleFonts.poppins(
                                    fontStyle: FontStyle.normal,
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(16),
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.photo_album_outlined,
                                  color: const Color(0XFFFF0036),
                                  size: ScreenUtil().setHeight(24),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                          SizedBox(
                            height: ScreenUtil().setHeight(10),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              getImageCamera();
                            },
                            child: Row(
                              children: [
                                Text(
                                  'Tomar foto',
                                  style: GoogleFonts.poppins(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w400,
                                    color: const Color(0XFF585858),
                                    fontSize: ScreenUtil().setSp(16),
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                                const Spacer(),
                                Icon(
                                  Icons.photo_camera_outlined,
                                  color: const Color(0XFFFF0036),
                                  size: ScreenUtil().setHeight(24),
                                )
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  _showLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator(
                color: Color(0XFFFF0036),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class CuentaController extends ChangeNotifier {
  bool editarActive = false;
  bool enableImput = true;

  File image;

  void changeActive(bool a) {
    editarActive = a;
    enableImput = !a;
    notifyListeners();
  }

  void changeImage(File i) {
    image = i;
    notifyListeners();
  }
}
