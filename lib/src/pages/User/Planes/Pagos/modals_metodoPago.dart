import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/Pagos/bloc_pago.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/Pagos/detalle_reserva_plin_yape.dart';
import 'package:provider/provider.dart';

class ChangeData extends ChangeNotifier {
  int select = 0;
  bool botton = false;

  void changeOption(int s) {
    select = s;
    if (s != 0) {
      botton = true;
    } else {
      botton = false;
    }
    notifyListeners();
  }
}

void modalSeletPayMetod(BuildContext context, PlanesModel planCambio, String titulo, bool esRenovacion) {
  final _controller = ChangeData();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      final provider = Provider.of<PagoBLoc>(context, listen: false);

      return Stack(
        children: [
          GestureDetector(
            child: Container(
              color: Color.fromRGBO(0, 0, 0, 0.001),
              child: GestureDetector(
                onTap: () {},
                child: DraggableScrollableSheet(
                  initialChildSize: 0.75,
                  minChildSize: 0.2,
                  maxChildSize: 0.9,
                  builder: (_, controller) {
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: SingleChildScrollView(
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
                              Row(
                                children: [
                                  BackButton(),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(30),
                                  ),
                                  Text(
                                    titulo,
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontSize: ScreenUtil().setSp(18),
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(27),
                              ),
                              Text(
                                'Seleccione método de pago',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFF585858),
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              _otions('yape', 'yapeOn', 1, Color(0xFF9E00FF), _controller),
                              SizedBox(
                                height: ScreenUtil().setHeight(18),
                              ),
                              _otions('plin', 'plinOn', 2, Color(0xFF00C7FE), _controller),
                              SizedBox(
                                height: ScreenUtil().setHeight(18),
                              ),
                              _otions('tarjetas', 'cardOn', 3, Color(0xFF003663), _controller),
                              SizedBox(height: ScreenUtil().setHeight(48)),
                              InkWell(
                                onTap: () async {
                                  if (_controller.botton) {
                                    /* if (_controller.select == 3) {
                                      ReservasNuevoApi reservasNuevoApi = ReservasNuevoApi();
                                      provider.changeCargandoTrue();
                                      final res = await reservasNuevoApi.reservaOnline(canchita);

                                      if (res.code == '1') {
                                        provider.changeCargandoFalse();
                                        Navigator.pop(context);
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            transitionDuration: const Duration(milliseconds: 700),
                                            pageBuilder: (context, animation, secondaryAnimation) {
                                              return WebViewPagos(link: res.url, cancha: canchita);
                                            },
                                            transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                              return FadeTransition(
                                                opacity: animation,
                                                child: child,
                                              );
                                            },
                                          ),
                                        );
                                      } else {
                                        Navigator.pop(context);
                                        provider.changeCargandoFalse();
                                      }
                                    } else { */
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        transitionDuration: const Duration(milliseconds: 700),
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return DetalleReservaPlinYape(
                                            tipoMetodoPago: _controller.select,
                                            plan: planCambio,
                                            esRenovacion: esRenovacion,
                                          );
                                        },
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          return FadeTransition(
                                            opacity: animation,
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                    // }
                                  }
                                },
                                child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, s) {
                                      return Container(
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: (_controller.botton) ? Color(0XFFFF0036) : Color(0XFFFF0036).withOpacity(0.6)),
                                        child: Center(
                                          child: Text(
                                            'Continuar',
                                            style: GoogleFonts.poppins(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ScreenUtil().setSp(18),
                                                fontStyle: FontStyle.normal),
                                          ),
                                        ),
                                        height: ScreenUtil().setHeight(60),
                                        width: ScreenUtil().setWidth(327),
                                      );
                                    }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: provider.cargando,
            builder: (BuildContext context, bool data, Widget child) {
              return (data) ? _showLoading() : Container();
            },
          ),
        ],
      );
    },
  );
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

Widget _otions(String logo, String select, int value, Color selectColor, ChangeData controller) {
  return AnimatedBuilder(
      animation: controller,
      builder: (context, s) {
        return LayoutBuilder(builder: (context, constrain) {
          return InkWell(
            onTap: () {
              controller.changeOption(value);
            },
            child: Container(
              height: ScreenUtil().setHeight(80),
              // decoration: BoxDecoration(
              //   border: Border.all(color: (controller.select == value) ? selectColor : Colors.white),
              //   borderRadius: BorderRadius.circular(20),
              // ),
              child: Stack(
                children: [
                  Container(
                    width: constrain.maxWidth - ScreenUtil().setWidth(10),
                    height: ScreenUtil().setHeight(80),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: (controller.select == value) ? selectColor : Colors.white,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  (value == 3)
                      ? Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: ScreenUtil().setHeight(55),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage('assets/img/$logo.png'),
                              ),
                            ),
                          ),
                        )
                      : Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setWidth(60),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              image: DecorationImage(
                                image: AssetImage('assets/img/$logo.png'),
                              ),
                            ),
                          ),
                        ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(30),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          width: 5,
                          color: Colors.white,
                        ),
                        color: (controller.select == value) ? selectColor : Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
      });
}
