import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/mesa_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';

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

void mesaModal(BuildContext context) {
  final _controller = ChangeController();

  TextEditingController _numberTableController = TextEditingController();
  TextEditingController _capacityController = TextEditingController();

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
                                    'Agregar mesa',
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
                                  'Número de mesa',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                TextField(
                                  focusNode: _focus1,
                                  controller: _numberTableController,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _capacityController.text.isNotEmpty) {
                                      _controller.changeBoton(true);
                                    } else {
                                      _controller.changeBoton(false);
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Ingrese número de mesa',
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
                                SizedBox(height: ScreenUtil().setHeight(8)),
                                Text(
                                  'Capacidad de mesa',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                TextField(
                                  focusNode: _focus2,
                                  controller: _capacityController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _numberTableController.text.isNotEmpty) {
                                      _controller.changeBoton(true);
                                    } else {
                                      _controller.changeBoton(false);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Ingrese capacidad de mesa',
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
                                      final _mesaApi = MesaApi();
                                      final res = await _mesaApi.agregarNuevaMesa(_numberTableController.text, _capacityController.text);
                                      if (res == 1) {
                                        final mesasBloc = ProviderBloc.mesas(context);
                                        mesasBloc.obtenerMesasPorNegocio();
                                        Navigator.pop(context);
                                      } else {
                                        _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                      }
                                    }

                                    _controller.changeCargando(false);
                                  },
                                  child: AnimatedBuilder(
                                      animation: _controller,
                                      builder: (_, s) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: (_controller.boton) ? const Color(0XFFFF0036) : const Color(0XFFFF0036).withOpacity(0.6),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Agregar mesa',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ScreenUtil().setSp(20),
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ),
                                          height: ScreenUtil().setHeight(60),
                                          width: ScreenUtil().setWidth(327),
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

void editMesaModal(BuildContext context, MesaModel mesaData) {
  final _controller = ChangeController();

  TextEditingController _numberTableController = TextEditingController();
  TextEditingController _capacityController = TextEditingController();

  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();

  _numberTableController.text = mesaData.mesaNombre;
  _capacityController.text = mesaData.mesaCapacidad;

  if (_numberTableController.text.isNotEmpty && _capacityController.text.isNotEmpty) {
    _controller.changeBoton(true);
  }

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
                                    'Editar mesa',
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
                                  'Número de mesa',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                TextField(
                                  focusNode: _focus1,
                                  controller: _numberTableController,
                                  maxLines: 1,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _capacityController.text.isNotEmpty) {
                                      _controller.changeBoton(true);
                                    } else {
                                      _controller.changeBoton(false);
                                    }
                                  },
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(
                                    hintText: 'Ingrese número de mesa',
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
                                SizedBox(height: ScreenUtil().setHeight(8)),
                                Text(
                                  'Capacidad de mesa',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                TextField(
                                  focusNode: _focus2,
                                  controller: _capacityController,
                                  maxLines: 1,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    if (value.isNotEmpty && _numberTableController.text.isNotEmpty) {
                                      _controller.changeBoton(true);
                                    } else {
                                      _controller.changeBoton(false);
                                    }
                                  },
                                  decoration: InputDecoration(
                                    hintText: 'Ingrese capacidad de mesa',
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
                                      final _mesaApi = MesaApi();
                                      MesaModel mesaEnviar = MesaModel();
                                      mesaEnviar.idMesa = mesaData.idMesa;
                                      mesaEnviar.idNegocio = mesaData.idNegocio;
                                      mesaEnviar.mesaNombre = _numberTableController.text;
                                      mesaEnviar.mesaCapacidad = _capacityController.text;
                                      final res = await _mesaApi.editarMesa(mesaEnviar);
                                      if (res == 1) {
                                        final mesasBloc = ProviderBloc.mesas(context);
                                        mesasBloc.actualizarMesas(mesaData.idMesa);
                                        Navigator.pop(context);
                                      } else {
                                        _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                      }
                                    }

                                    _controller.changeCargando(false);
                                  },
                                  child: AnimatedBuilder(
                                      animation: _controller,
                                      builder: (_, s) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(50),
                                            color: (_controller.boton) ? const Color(0XFFFF0036) : const Color(0XFFFF0036).withOpacity(0.6),
                                          ),
                                          child: Center(
                                            child: Text(
                                              'Guardar',
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                                fontSize: ScreenUtil().setSp(20),
                                                fontStyle: FontStyle.normal,
                                                letterSpacing: 1.5,
                                              ),
                                            ),
                                          ),
                                          height: ScreenUtil().setHeight(60),
                                          width: ScreenUtil().setWidth(327),
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
