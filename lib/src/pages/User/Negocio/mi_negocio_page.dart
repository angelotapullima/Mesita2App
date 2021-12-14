import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/api/negocio_api.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class MiNegocioPage extends StatefulWidget {
  const MiNegocioPage({Key key}) : super(key: key);

  @override
  _MiNegocioPageState createState() => _MiNegocioPageState();
}

class _MiNegocioPageState extends State<MiNegocioPage> {
  TextEditingController _nombreNegocioController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _rucController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  //TextEditingController _emailController = TextEditingController();
  TextEditingController _razonController = TextEditingController();

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
              iconTheme: IconThemeData(
                color: Color(0XFF3A3A3A),
              ),
              title: Text(
                'Mi negocio',
                style: GoogleFonts.poppins(
                  color: Color(0XFF3A3A3A),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                ),
              ),
              // actions: [
              //   (_controller.editarActive)
              //       ? InkWell(
              //           onTap: () async {
              //             _controller.changeCargando(true);
              //             if (_controller.botton) {
              //               final _negocioApi = NegocioApi();
              //               final res = await _negocioApi.actualizarNegocio(
              //                   _nombreNegocioController.text, _direccionController.text, _telefonoController.text);

              //               if (res == 1) {
              //                 _controller.changeActive(false);
              //                 showToast('Negocio actualizado correctamente', Colors.black);

              //                 setState(() {});
              //               } else {
              //                 showToast('Ocurrió un error', Colors.red);
              //               }
              //             }
              //             _controller.changeCargando(false);
              //           },
              //           child: Center(
              //             child: Text(
              //               'Guardar',
              //               style: GoogleFonts.poppins(
              //                 color: Colors.red,
              //               ),
              //             ),
              //           ),
              //         )
              //       : InkWell(
              //           onTap: () {
              //             _controller.changeActive(true);
              //           },
              //           child: Center(
              //             child: Text(
              //               'Editar',
              //               style: GoogleFonts.poppins(
              //                 color: Colors.red,
              //               ),
              //             ),
              //           ),
              //         ),
              //   SizedBox(
              //     width: ScreenUtil().setWidth(24),
              //   ),
              // ],
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
                          child: Container(
                            height: ScreenUtil().setHeight(70),
                            width: ScreenUtil().setWidth(70),
                            child: SvgPicture.asset('assets/settings_svg/negocio.svg'),
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
                            if (_nombreNegocioController.text.length > 0 &&
                                _telefonoController.text.length > 0 &&
                                _direccionController.text.length > 0) {
                              _controller.changeBotton(true);
                            } else {
                              _controller.changeBotton(false);
                            }
                          },
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
                            if (_nombreNegocioController.text.length > 0 &&
                                _telefonoController.text.length > 0 &&
                                _direccionController.text.length > 0) {
                              _controller.changeBotton(true);
                            } else {
                              _controller.changeBotton(false);
                            }
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            hintText: 'Domicilio fiscal',
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
                            if (_nombreNegocioController.text.length > 0 &&
                                _telefonoController.text.length > 0 &&
                                _direccionController.text.length > 0) {
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
