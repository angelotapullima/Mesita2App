import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/venta_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({Key key}) : super(key: key);

  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  TextEditingController fechaI = TextEditingController();
  TextEditingController fechaF = TextEditingController();
  final _controller = ChangeButtons();
  int carga = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      fechaI.text = obtenerFechaActualApi();
      fechaF.text = obtenerFechaActualApi();

      _controller.changeRangoFecha('${obtenerRangoFecha(fechaI.text, fechaF.text)}');
    });
    super.initState();
  }

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
            if (snapshot.data.isNotEmpty) {
              var ventas = snapshot.data;
              double total = 0;
              for (var i = 0; i < ventas.length; i++) {
                total = total + double.parse(ventas[i].total);
              }
              return Scaffold(
                backgroundColor: const Color(0XFFE5E5E5),
                appBar: AppBar(
                  backgroundColor: const Color(0XFFE5E5E5),
                  leading: InkWell(
                    child: Container(),
                  ),
                  actions: [
                    Container(
                      padding: const EdgeInsets.all(16),
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
                      InkWell(
                        onTap: () {
                          _selectDay(context);
                        },
                        child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, snapshot) {
                              return Container(
                                height: ScreenUtil().setHeight(48),
                                width: double.infinity,
                                decoration: BoxDecoration(color: const Color(0XFFEDEDED), borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _controller.rangoFecha,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: (_controller.rangoFecha != 'Seleccionar fecha') ? const Color(0XFF585858) : const Color(0XFFBEBEBE),
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(16),
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: ScreenUtil().setHeight(20),
                                      color: const Color(0XFF585858),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(50),
                            child: Center(
                              child: Text(
                                'N°',
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFFD1D1D1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(90),
                            child: Center(
                              child: Text(
                                'Tipo',
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFFD1D1D1),
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
                              color: const Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                          Text(
                            'Estado',
                            style: GoogleFonts.poppins(
                              color: const Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
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
                backgroundColor: const Color(0XFFE5E5E5),
                appBar: AppBar(
                  backgroundColor: const Color(0XFFE5E5E5),
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
                      InkWell(
                        onTap: () {
                          _selectDay(context);
                        },
                        child: AnimatedBuilder(
                            animation: _controller,
                            builder: (context, snapshot) {
                              return Container(
                                height: ScreenUtil().setHeight(48),
                                width: double.infinity,
                                decoration: BoxDecoration(color: const Color(0XFFEDEDED), borderRadius: BorderRadius.circular(15)),
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _controller.rangoFecha,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: (_controller.rangoFecha != 'Seleccionar fecha') ? const Color(0XFF585858) : const Color(0XFFBEBEBE),
                                          fontWeight: FontWeight.w400,
                                          fontSize: ScreenUtil().setSp(16),
                                          fontStyle: FontStyle.normal,
                                        ),
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      size: ScreenUtil().setHeight(20),
                                      color: const Color(0XFF585858),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: ScreenUtil().setHeight(16),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: ScreenUtil().setWidth(50),
                            child: Center(
                              child: Text(
                                'N°',
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFFD1D1D1),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(90),
                            child: Center(
                              child: Text(
                                'Tipo',
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFFD1D1D1),
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
                              color: const Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                          Text(
                            'Estado',
                            style: GoogleFonts.poppins(
                              color: const Color(0XFFD1D1D1),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: 0.16,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Color(0XFFD1D1D1),
                        thickness: 1.5,
                      ),
                      Expanded(
                        child: Center(
                          child: Text(
                            'Sin ventas',
                            style: GoogleFonts.poppins(
                              color: const Color(0XFF585858),
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
              backgroundColor: const Color(0XFFE5E5E5),
              appBar: AppBar(
                backgroundColor: const Color(0XFFE5E5E5),
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
                    InkWell(
                      onTap: () {
                        _selectDay(context);
                      },
                      child: AnimatedBuilder(
                          animation: _controller,
                          builder: (context, snapshot) {
                            return Container(
                              height: ScreenUtil().setHeight(48),
                              width: double.infinity,
                              decoration: BoxDecoration(color: const Color(0XFFEDEDED), borderRadius: BorderRadius.circular(15)),
                              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      _controller.rangoFecha,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: (_controller.rangoFecha != 'Seleccionar fecha') ? const Color(0XFF585858) : const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                    ),
                                  ),
                                  Icon(
                                    Icons.arrow_drop_down,
                                    size: ScreenUtil().setHeight(20),
                                    color: const Color(0XFF585858),
                                  ),
                                ],
                              ),
                            );
                          }),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(50),
                          child: Center(
                            child: Text(
                              'N°',
                              style: GoogleFonts.poppins(
                                color: const Color(0XFFD1D1D1),
                                fontWeight: FontWeight.w500,
                                fontSize: ScreenUtil().setSp(16),
                                letterSpacing: 0.16,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(90),
                          child: Center(
                            child: Text(
                              'Tipo',
                              style: GoogleFonts.poppins(
                                color: const Color(0XFFD1D1D1),
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
                            color: const Color(0XFFD1D1D1),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            letterSpacing: 0.16,
                          ),
                        ),
                        Text(
                          'Estado',
                          style: GoogleFonts.poppins(
                            color: const Color(0XFFD1D1D1),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      color: Color(0XFFD1D1D1),
                      thickness: 1.5,
                    ),
                    Expanded(
                      child: Center(
                        child: (Platform.isAndroid)
                            ? const CircularProgressIndicator(
                                color: colorPrimary1,
                              )
                            : const CupertinoActivityIndicator(),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        });
  }

  // Widget _buttonSelect(ChangeButtons controller, String titulo, int value) {
  //   return AnimatedBuilder(
  //       animation: controller,
  //       builder: (_, s) {
  //         return InkWell(
  //           onTap: () {
  //             controller.changeValue(value);
  //             final ventasBloc = ProviderBloc.ventas(context);
  //             if (value == 1) {
  //               ventasBloc.obtenerVentas(true);
  //             } else {
  //               ventasBloc.obtenerVentas(false);
  //             }
  //           },
  //           child: Container(
  //             margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
  //             padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
  //             decoration: BoxDecoration(
  //               color: (controller.value == value) ? colorPrimary1 : Colors.transparent,
  //               borderRadius: BorderRadius.circular(22),
  //             ),
  //             child: Text(
  //               titulo,
  //               style: GoogleFonts.poppins(
  //                 color: (controller.value == value) ? Colors.white : Color(0XFF585858),
  //                 fontWeight: FontWeight.w500,
  //                 fontSize: ScreenUtil().setSp(14),
  //                 letterSpacing: 0.16,
  //               ),
  //             ),
  //           ),
  //         );
  //       });
  // }

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
          SizedBox(
            width: ScreenUtil().setWidth(60),
            child: Center(
              child: Text(
                '${venta.serie}-${venta.correlativo}',
                style: GoogleFonts.poppins(
                  color: const Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(80),
            child: Center(
              child: Text(
                doc,
                style: GoogleFonts.poppins(
                  color: const Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          Text(
            venta.total,
            style: GoogleFonts.poppins(
              color: const Color(0XFF585858),
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
              letterSpacing: 0.16,
            ),
          ),
          Text(
            estado,
            style: GoogleFonts.poppins(
              color: const Color(0XFF585858),
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
              letterSpacing: 0.16,
            ),
          ),
        ],
      ),
    );
  }

  Widget imputFecha(TextEditingController control, String title) {
    return TextField(
      controller: control,
      maxLines: 1,
      enableInteractiveSelection: false,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: title,
        hintStyle: TextStyle(
          color: const Color(0XFFBEBEBE),
          fontWeight: FontWeight.w400,
          fontSize: ScreenUtil().setSp(16),
          fontStyle: FontStyle.normal,
        ),
        filled: true,
        fillColor: const Color(0XFFEDEDED),
        contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
      onTap: () async {
        FocusScope.of(context).requestFocus(FocusNode());
        DateTime picked = await PlatformDatePicker.showDate(
          context: context,
          backgroundColor: Colors.white,
          firstDate: DateTime(DateTime.now().year - 1),
          initialDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        );

        if (picked != null) {
          control.text =
              "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        }

        if (fechaI.text.isNotEmpty && fechaF.text.isNotEmpty) {
          _controller.changeBoton(true);
        } else {
          _controller.changeBoton(false);
        }
      },
    );
  }

  void _selectDay(BuildContext context) {
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
                                    'Establecer fecha',
                                    style: GoogleFonts.poppins(
                                      color: colorPrimary1,
                                      fontWeight: FontWeight.w600,
                                      fontSize: ScreenUtil().setSp(18),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setWidth(24),
                                ),
                                Text(
                                  'Fecha inicio',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                imputFecha(fechaI, 'Seleccionar fecha'),
                                SizedBox(
                                  height: ScreenUtil().setWidth(24),
                                ),
                                Text(
                                  'Fecha fin',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                imputFecha(fechaF, 'Seleccionar fecha'),
                                SizedBox(height: ScreenUtil().setHeight(48)),
                                InkWell(
                                  onTap: () async {
                                    _controller.changeCargando(true);
                                    _controller.changeText('');
                                    if (_controller.boton) {
                                      _controller.changeRangoFecha('${obtenerRangoFecha(fechaI.text, fechaF.text)}');

                                      final ventasBloc = ProviderBloc.ventas(context);
                                      ventasBloc.obtenerVentasPorFecha(fechaI.text, fechaF.text);
                                      Navigator.pop(context);
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
                                              color: (_controller.boton) ? colorPrimary1 : colorPrimary1.withOpacity(0.6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Establecer fecha',
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
                                            color: colorPrimary1,
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

class ChangeButtons extends ChangeNotifier {
  int value = 1;
  String rangoFecha = 'Seleccionar fecha';
  bool cargando = false;
  String text = '';
  bool boton = false;

  void changeValue(int v) {
    value = v;
    notifyListeners();
  }

  void changeRangoFecha(String r) {
    rangoFecha = r;

    notifyListeners();
  }

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
