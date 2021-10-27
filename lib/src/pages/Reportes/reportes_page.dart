import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/model_items_reporte.dart';
import 'package:mesita_aplication_2/src/pages/Reportes/reporte_categoria.dart';
import 'package:mesita_aplication_2/src/pages/Reportes/reporte_general.dart';
import 'package:mesita_aplication_2/src/pages/Reportes/reporte_productos.dart';
import 'package:mesita_aplication_2/src/pages/Reportes/reporte_utilidades.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';
import 'package:platform_date_picker/platform_date_picker.dart';

enum PageMostrar { general, categorias, productos, utilidades }

class ReportesPage extends StatefulWidget {
  const ReportesPage({Key key}) : super(key: key);

  @override
  _ReportesPageState createState() => _ReportesPageState();
}

class _ReportesPageState extends State<ReportesPage> {
  TextEditingController fechaI = TextEditingController();
  TextEditingController fechaF = TextEditingController();
  final _controller = ReportesController();
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final reporteBloc = ProviderBloc.reporte(context);
      reporteBloc.obtenerReporteGeneralPorIdItem(fechaI.text, fechaF.text, 0);
      reporteBloc.obtenerReporteLineaFirts();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final reporteBloc = ProviderBloc.reporte(context);
    final prefs = Preferences();
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
          'Reportes',
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
                      decoration: BoxDecoration(color: Color(0XFFEDEDED), borderRadius: BorderRadius.circular(15)),
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              _controller.rangoFecha,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: (_controller.rangoFecha != 'Seleccionar fecha') ? Color(0XFF585858) : Color(0XFFBEBEBE),
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(16),
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_drop_down,
                            size: ScreenUtil().setHeight(20),
                            color: Color(0XFF585858),
                          ),
                        ],
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Container(
              height: ScreenUtil().setHeight(40),
              child: ListView.builder(
                itemCount: itemsList.length,
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (BuildContext context, int index) {
                  return AnimatedBuilder(
                      animation: _controller,
                      builder: (_, s) {
                        return InkWell(
                          onTap: () {
                            _controller.changeIndex(index);
                            if (itemsList[index].id == 1) {
                              _controller.changePage(PageMostrar.general);
                              reporteBloc.obtenerReporteGeneralPorIdItem(fechaI.text, fechaF.text, itemsList[index].id);
                            } else if (itemsList[index].id == 2) {
                              reporteBloc.obtenerReporteLinea(fechaI.text);
                              _controller.changePage(PageMostrar.categorias);
                            } else if (itemsList[index].id == 3) {
                              reporteBloc.obtenerReporteProductos(fechaI.text, fechaF.text);
                              _controller.changePage(PageMostrar.productos);
                            } else if (itemsList[index].id == 4) {
                              reporteBloc.obtenerReporteUtilidadesLineas(fechaI.text, fechaF.text);
                              _controller.changePage(PageMostrar.utilidades);
                            }
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                            padding: EdgeInsets.symmetric(
                              horizontal: ScreenUtil().setWidth(28),
                            ),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(22),
                                color: (index == _controller.index) ? Color(0XFFFF0036) : Color(0XFFE5E5E5),
                                boxShadow: [
                                  BoxShadow(
                                    color: (index == _controller.index) ? Color.fromRGBO(255, 0, 54, 0.5) : Colors.transparent,
                                  )
                                ]),
                            child: Center(
                                child: Text(
                              itemsList[index].item,
                              style: TextStyle(
                                color: (index == _controller.index) ? Colors.white : Color(0xFF585858),
                                fontSize: ScreenUtil().setSp(14),
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.16,
                              ),
                            )),
                          ),
                        );
                      });
                },
              ),
            ),
            AnimatedBuilder(
                animation: _controller,
                builder: (s, t) {
                  return (_controller.currentPage == PageMostrar.general)
                      ? ReporteGeneral()
                      : (_controller.currentPage == PageMostrar.categorias)
                          ? ReporteCategoria()
                          : (_controller.currentPage == PageMostrar.productos)
                              ? ReporteProductos()
                              : (_controller.currentPage == PageMostrar.utilidades)
                                  ? ReporteUtilidades()
                                  : Container();
                }),
          ],
        ),
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
          color: Color(0XFFBEBEBE),
          fontWeight: FontWeight.w400,
          fontSize: ScreenUtil().setSp(16),
          fontStyle: FontStyle.normal,
        ),
        filled: true,
        fillColor: Color(0XFFEDEDED),
        contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
      onTap: () async {
        FocusScope.of(context).requestFocus(new FocusNode());
        DateTime picked = await PlatformDatePicker.showDate(
          context: context,
          backgroundColor: Colors.white,
          firstDate: DateTime(DateTime.now().year - 1),
          initialDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
        );

        print('date $picked');
        if (picked != null) {
          control.text =
              "${picked.year.toString().padLeft(2, '0')}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
        }

        if (fechaI.text.length > 0 && fechaF.text.length > 0) {
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
                                    'Establecer fecha',
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
                                  'Fecha inicio',
                                  style: GoogleFonts.poppins(
                                    color: Color(0XFF585858),
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
                                    color: Color(0XFF585858),
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
                                      //_controller.changeRangoFecha('del ${obtenerFecha(fechaI.text)} al ${obtenerFecha(fechaF.text)}');
                                      _controller.changeRangoFecha('${obtenerRangoFecha(fechaI.text, fechaF.text)}');
                                      _controller.changePage(PageMostrar.general);
                                      _controller.changeIndex(0);
                                      final reporteBloc = ProviderBloc.reporte(context);
                                      reporteBloc.obtenerReporteGeneralPorIdItem(fechaI.text, fechaF.text, itemsList[0].id);
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
                                              color: (_controller.boton) ? Color(0XFFFF0036) : Color(0XFFFF0036).withOpacity(0.6),
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
}

class ReportesController extends ChangeNotifier {
  PageMostrar currentPage = PageMostrar.general;
  String rangoFecha = 'Seleccionar fecha';
  bool cargando = false;
  String text = '';
  bool boton = false;
  int index = 0;

  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }

  void changePage(PageMostrar p) {
    currentPage = p;

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
