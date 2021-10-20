import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/venta_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({Key key}) : super(key: key);

  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  final _controller = ChangeButtons();
  int carga = 0;

  @override
  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    final ventasBloc = ProviderBloc.ventas(context);
    if (carga == 0) {
      ventasBloc.obtenerVentas(true);
      carga++;
    }

    return StreamBuilder(
        stream: ventasBloc.ventasStream,
        builder: (context, AsyncSnapshot<List<VentaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              var ventas = snapshot.data;
              double total = 0;
              for (var i = 0; i < ventas.length; i++) {
                total = total + double.parse(ventas[i].total);
              }
              return Scaffold(
                backgroundColor: Color(0XFFE5E5E5),
                appBar: AppBar(
                  backgroundColor: Color(0XFFE5E5E5),
                  leading: InkWell(
                    child: Container(),
                  ),
                  actions: [
                    Container(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'S/${total.toStringAsFixed(2)}',
                        style: GoogleFonts.poppins(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: ScreenUtil().setSp(20),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(8),
                    ),
                    circleUser(context, prefs),
                    SizedBox(
                      width: ScreenUtil().setWidth(24),
                    ),
                  ],
                  elevation: 0,
                  title: Text(
                    'Ventas',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buttonSelect(_controller, 'Del día', 1),
                          _buttonSelect(_controller, 'Historial', 2),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(50),
                            child: Center(
                              child: Text(
                                'N°',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFFD1D1D1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(90),
                            child: Center(
                              child: Text(
                                'Tipo',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFFD1D1D1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Cant.',
                            style: GoogleFonts.poppins(
                              color: Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                          Text(
                            'Estado',
                            style: GoogleFonts.poppins(
                              color: Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0XFFD1D1D1),
                        thickness: 1.5,
                      ),
                      Expanded(
                        child: ListView.builder(
                            itemCount: ventas.length,
                            itemBuilder: (context, index) {
                              return itemVenta(ventas[index]);
                            }),
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Scaffold(
                backgroundColor: Color(0XFFE5E5E5),
                appBar: AppBar(
                  backgroundColor: Color(0XFFE5E5E5),
                  leading: InkWell(
                    child: Container(),
                  ),
                  actions: [
                    circleUser(context, prefs),
                    SizedBox(
                      width: ScreenUtil().setWidth(24),
                    ),
                  ],
                  elevation: 0,
                  title: Text(
                    'Ventas',
                    style: GoogleFonts.poppins(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(24),
                    ),
                  ),
                ),
                body: Padding(
                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buttonSelect(_controller, 'Del día', 1),
                          _buttonSelect(_controller, 'Historial', 2),
                        ],
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(8),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(50),
                            child: Center(
                              child: Text(
                                'N°',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFFD1D1D1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                          Container(
                            width: ScreenUtil().setWidth(90),
                            child: Center(
                              child: Text(
                                'Tipo',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFFD1D1D1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                          Text(
                            'Cant.',
                            style: GoogleFonts.poppins(
                              color: Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                          Text(
                            'Estado',
                            style: GoogleFonts.poppins(
                              color: Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                        ],
                      ),
                      Divider(
                        color: Color(0XFFD1D1D1),
                        thickness: 1.5,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sin ventas',
                            style: GoogleFonts.poppins(
                              color: Color(0XFF585858),
                              fontWeight: FontWeight.w400,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }
          } else {
            return Scaffold(
              backgroundColor: Color(0XFFE5E5E5),
              appBar: AppBar(
                backgroundColor: Color(0XFFE5E5E5),
                leading: InkWell(
                  child: Container(),
                ),
                actions: [
                  circleUser(context, prefs),
                  SizedBox(
                    width: ScreenUtil().setWidth(24),
                  ),
                ],
                elevation: 0,
                title: Text(
                  'Ventas',
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: ScreenUtil().setSp(24),
                  ),
                ),
              ),
              body: Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buttonSelect(_controller, 'Del día', 1),
                        _buttonSelect(_controller, 'Historial', 2),
                      ],
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(8),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: ScreenUtil().setWidth(50),
                          child: Center(
                            child: Text(
                              'N°',
                              style: GoogleFonts.poppins(
                                color: Color(0XFFD1D1D1),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16),
                                letterSpacing: 0.16,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: ScreenUtil().setWidth(90),
                          child: Center(
                            child: Text(
                              'Tipo',
                              style: GoogleFonts.poppins(
                                color: Color(0XFFD1D1D1),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16),
                                letterSpacing: 0.16,
                              ),
                            ),
                          ),
                        ),
                        Text(
                          'Cant.',
                          style: GoogleFonts.poppins(
                            color: Color(0XFFD1D1D1),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            letterSpacing: 0.16,
                          ),
                        ),
                        Text(
                          'Estado',
                          style: GoogleFonts.poppins(
                            color: Color(0XFFD1D1D1),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                    Divider(
                      color: Color(0XFFD1D1D1),
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: Center(
                        child: (Platform.isAndroid)
                            ? CircularProgressIndicator(
                                color: Color(0XFFFF0036),
                              )
                            : CupertinoActivityIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  Widget _buttonSelect(ChangeButtons controller, String titulo, int value) {
    return AnimatedBuilder(
        animation: controller,
        builder: (_, s) {
          return InkWell(
            onTap: () {
              controller.changeValue(value);
              final ventasBloc = ProviderBloc.ventas(context);
              if (value == 1) {
                ventasBloc.obtenerVentas(true);
              } else {
                ventasBloc.obtenerVentas(false);
              }
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                color: (controller.value == value) ? Color(0XFFFF0036) : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                titulo,
                style: GoogleFonts.poppins(
                  color: (controller.value == value) ? Colors.white : Color(0XFF585858),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(14),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          );
        });
  }

  Widget itemVenta(VentaModel venta) {
    String doc;
    String estado = '----';

    if (venta.tipoDoc == '03') {
      doc = 'Boleta';
    } else if (venta.tipoDoc == '01') {
      doc = 'Factura';
    } else {
      doc = 'N. Venta';
    }

    if (venta.envio == '0') {
      estado = 'No enviado';
    } else if (venta.envio == '1') {
      estado = 'Enviado';
    }
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenUtil().setWidth(60),
            child: Center(
              child: Text(
                '${venta.serie}-${venta.correlativo}',
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(80),
            child: Center(
              child: Text(
                doc,
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          Text(
            '${venta.total}',
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
              letterSpacing: 0.16,
            ),
          ),
          Text(
            estado,
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
              letterSpacing: 0.16,
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeButtons extends ChangeNotifier {
  int value = 1;

  void changeValue(int v) {
    value = v;
    notifyListeners();
  }
}
