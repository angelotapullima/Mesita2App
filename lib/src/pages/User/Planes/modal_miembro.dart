import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeText(String t) {
    text = t;
    notifyListeners();
  }
}

void addMiembroModal(BuildContext context, String idPlan) {
  final _controller = ChangeController();

  TextEditingController _nombreController = new TextEditingController();

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
                                  'Añadir miembro',
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
                              InkWell(
                                onTap: () {},
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0XFFEDEDED),
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.search,
                                        color: Color(0XFFC4C4C4),
                                      ),
                                      SizedBox(
                                        width: ScreenUtil().setWidth(24),
                                      ),
                                      Text(
                                        'Buscar usuario',
                                        style: GoogleFonts.poppins(
                                          color: Color(0XFFC4C4C4),
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(18),
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: 0.16,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                              // TextField(
                              //   controller: _nombreController,
                              //   maxLines: 1,
                              //   onChanged: (value) {
                              //     if (value.length > 0) {
                              //       _controller.changeBoton(true);
                              //     } else {
                              //       _controller.changeBoton(false);
                              //     }
                              //   },
                              //   keyboardType: TextInputType.text,
                              //   decoration: InputDecoration(
                              //     hintText: 'Ingresar nombre',
                              //     hintStyle: TextStyle(
                              //       color: Color(0XFFBEBEBE),
                              //       fontWeight: FontWeight.w400,
                              //       fontSize: ScreenUtil().setSp(16),
                              //       fontStyle: FontStyle.normal,
                              //     ),
                              //     filled: true,
                              //     fillColor: Color(0XFFEDEDED),
                              //     contentPadding: EdgeInsets.only(
                              //         left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                              SizedBox(height: ScreenUtil().setHeight(48)),
                              InkWell(
                                onTap: () async {
                                  _controller.changeCargando(true);
                                  _controller.changeText('');
                                  if (_controller.boton) {
                                    // final _lineaApi = LineaApi();
                                    // final res = await _lineaApi.agregarNuevaLinea(_nombreController.text, idCategoria);
                                    // if (res == 1) {
                                    //   final lineasBloc = ProviderBloc.lineas(context);
                                    //   lineasBloc.updateLineasPorNegocio(idCategoria);
                                    //   Navigator.pop(context);
                                    // } else if (res == 3) {
                                    //   _controller.changeText('Ya existe una categoría con ese nombre');
                                    // } else {
                                    //   _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                    // }
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
                                              'Añadir',
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
