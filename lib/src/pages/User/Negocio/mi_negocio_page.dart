import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class MiNegocioPage extends StatefulWidget {
  const MiNegocioPage({Key key}) : super(key: key);

  @override
  _MiNegocioPageState createState() => _MiNegocioPageState();
}

class _MiNegocioPageState extends State<MiNegocioPage> {
  final TextEditingController _nombreNegocioController = TextEditingController();
  final TextEditingController _direccionController = TextEditingController();
  final TextEditingController _rucController = TextEditingController();
  final TextEditingController _telefonoController = TextEditingController();
  final TextEditingController _razonController = TextEditingController();

  final _controller = NegocioController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final preferences = Preferences();
      _nombreNegocioController.text = verificarNull(preferences.negocioNombre);
      _direccionController.text = verificarNull(preferences.negocioDireccion);
      _rucController.text = verificarNull(preferences.negocioRUC);
      _telefonoController.text = verificarNull(preferences.negocioTelefono);
      _razonController.text = verificarNull(preferences.negocioRazonSocial);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
          return Scaffold(
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 0,
              iconTheme: const IconThemeData(
                color: Color(0XFF3A3A3A),
              ),
              title: Text(
                'Mi negocio',
                style: GoogleFonts.poppins(
                  color: const Color(0XFF3A3A3A),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                ),
              ),
            ),
            body: Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(20),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(20),
                        ),
                        Center(
                          child: SizedBox(
                            height: ScreenUtil().setHeight(70),
                            width: ScreenUtil().setWidth(70),
                            child: SvgPicture.asset(
                              'assets/settings_svg/negocio.svg',
                              color: colorPrimary1,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(29),
                        ),
                        Text(
                          'Negocio',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        TextField(
                          readOnly: _controller.enableImput,
                          controller: _nombreNegocioController,
                          maxLines: 1,
                          onChanged: (value) {
                            if (_nombreNegocioController.text.isNotEmpty &&
                                _telefonoController.text.isNotEmpty &&
                                _direccionController.text.isNotEmpty) {
                              _controller.changeBotton(true);
                            } else {
                              _controller.changeBotton(false);
                            }
                          },
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
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        Text(
                          'R.U.C.',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          controller: _rucController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'R.U.C.',
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
                          height: ScreenUtil().setHeight(24),
                        ),
                        Text(
                          'Razón social',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        TextField(
                          readOnly: true,
                          controller: _razonController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Razón social',
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
                          height: ScreenUtil().setHeight(24),
                        ),
                        Text(
                          'Domicilio fiscal',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        TextField(
                          readOnly: _controller.enableImput,
                          controller: _direccionController,
                          onChanged: (value) {
                            if (_nombreNegocioController.text.isNotEmpty &&
                                _telefonoController.text.isNotEmpty &&
                                _direccionController.text.isNotEmpty) {
                              _controller.changeBotton(true);
                            } else {
                              _controller.changeBotton(false);
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Domicilio fiscal',
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
                          'Teléfono de contacto',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        TextField(
                          readOnly: _controller.enableImput,
                          controller: _telefonoController,
                          onChanged: (value) {
                            if (_nombreNegocioController.text.isNotEmpty &&
                                _telefonoController.text.isNotEmpty &&
                                _direccionController.text.isNotEmpty) {
                              _controller.changeBotton(true);
                            } else {
                              _controller.changeBotton(false);
                            }
                          },
                          keyboardType: TextInputType.number,
                          maxLength: 9,
                          decoration: InputDecoration(
                            counterText: '',
                            hintText: 'Teléfono de contacto',
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
                        // SizedBox(
                        //   height: ScreenUtil().setHeight(30),
                        // ),
                        // Text(
                        //   'Email de contacto',
                        //   style: TextStyle(
                        //     color: Colors.black,
                        //     fontSize: ScreenUtil().setSp(16),
                        //   ),
                        // ),
                        // TextField(
                        //   readOnly: _controller.enableImput,
                        //   controller: _emailController,
                        //   /* focusNode: _focus1,
                        //                     controller: _numberTableController,
                        //                     maxLines: 1,
                        //                     onChanged: (value) {
                        //                       if (value.length > 0 && _capacityController.text.length > 0) {
                        //                         _controller.changeBoton(true);
                        //                       } else {
                        //                         _controller.changeBoton(false);
                        //                       }
                        //                     }, */
                        //   keyboardType: TextInputType.number,
                        //   decoration: InputDecoration(
                        //     hintText: 'Email de contacto',
                        //     hintStyle: TextStyle(
                        //       color: Color(0XFFBEBEBE),
                        //       fontWeight: FontWeight.w400,
                        //       fontSize: ScreenUtil().setSp(16),
                        //       fontStyle: FontStyle.normal,
                        //     ),
                        //     filled: true,
                        //     fillColor: Color(0XFFEDEDED),
                        //     contentPadding:
                        //         EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //       borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //       borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderRadius: BorderRadius.circular(15),
                        //       borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                        //     ),
                        //   ),
                        //   style: TextStyle(
                        //     color: Color(0XFF585858),
                        //     fontWeight: FontWeight.w400,
                        //     fontSize: ScreenUtil().setSp(16),
                        //     fontStyle: FontStyle.normal,
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                ),
                (_controller.cargando) ? _showLoading() : Container(),
              ],
            ),
          );
        });
  }

  _showLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator(
                color: colorPrimary1,
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class NegocioController extends ChangeNotifier {
  bool editarActive = false;
  bool enableImput = true;

  bool cargando = false;
  bool botton = false;

  void changeActive(bool a) {
    editarActive = a;
    enableImput = !a;
    notifyListeners();
  }

  void changeCargando(bool v) {
    cargando = v;
    notifyListeners();
  }

  void changeBotton(bool b) {
    botton = b;
    notifyListeners();
  }
}
