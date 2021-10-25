import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/venta_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;

  String idLinea = '';
  String linea = 'Seleccionar categoría';

  void changeLinea(String id, String l) {
    idLinea = id;
    linea = l;
    notifyListeners();
  }

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }

  bool mostrarTextField = false;
  String tipoDoc = '';

  void changeDoc(String tipo) {
    tipoDoc = tipo;
    if (tipo == '01') {
      mostrarTextField = true;
    } else {
      mostrarTextField = false;
    }
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

void pagarPedidoModal(BuildContext context, PedidoModel pedido) {
  final _controller = ChangeController();

  TextEditingController _rucController = new TextEditingController();
  TextEditingController _razonController = new TextEditingController();
  TextEditingController _domicilioController = new TextEditingController();

  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();
  FocusNode _focus3 = FocusNode();

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
                                    'Pagar',
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
                                  'Tipo documento',
                                  style: GoogleFonts.poppins(
                                    color: Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(16),
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setWidth(16),
                                ),
                                AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, t) {
                                      return Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () async {
                                              _controller.changeDoc('03');
                                              _rucController.text = '';
                                              _razonController.text = '';
                                              _domicilioController.text = '';
                                              if (_controller.tipoDoc == '03') {
                                                _controller.changeBoton(true);
                                              } else {
                                                _controller.changeBoton(false);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: ScreenUtil().setHeight(20),
                                                  width: ScreenUtil().setWidth(20),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (_controller.tipoDoc == '03') ? Color(0XFFFF0036) : Color(0XFFE5E5E5),
                                                    border: Border.all(
                                                      color: Color(0XFFE5E5E5),
                                                      width: ScreenUtil().setWidth(4),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(10),
                                                ),
                                                Text(
                                                  'Boleta',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF585858),
                                                    fontSize: ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: ScreenUtil().setSp(0.016),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          // SizedBox(
                                          //   width: ScreenUtil().setWidth(60),
                                          // ),
                                          InkWell(
                                            onTap: () {
                                              _controller.changeDoc('01');

                                              if (_controller.tipoDoc == '01') {
                                                if (_rucController.text.length > 0 &&
                                                    _razonController.text.length > 0 &&
                                                    _domicilioController.text.length > 0) {
                                                  _controller.changeBoton(true);
                                                } else {
                                                  _controller.changeBoton(false);
                                                }
                                              } else {
                                                _controller.changeBoton(false);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: ScreenUtil().setHeight(20),
                                                  width: ScreenUtil().setWidth(20),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (_controller.tipoDoc == '01') ? Color(0XFFFF0036) : Color(0XFFE5E5E5),
                                                    border: Border.all(
                                                      color: Color(0XFFE5E5E5),
                                                      width: ScreenUtil().setWidth(4),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(10),
                                                ),
                                                Text(
                                                  'Factura',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF585858),
                                                    fontSize: ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: ScreenUtil().setSp(0.016),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              _controller.changeDoc('02');
                                              _rucController.text = '';
                                              _razonController.text = '';
                                              _domicilioController.text = '';
                                              if (_controller.tipoDoc == '02') {
                                                _controller.changeBoton(true);
                                              } else {
                                                _controller.changeBoton(false);
                                              }
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: ScreenUtil().setHeight(20),
                                                  width: ScreenUtil().setWidth(20),
                                                  decoration: BoxDecoration(
                                                    shape: BoxShape.circle,
                                                    color: (_controller.tipoDoc == '02') ? Color(0XFFFF0036) : Color(0XFFE5E5E5),
                                                    border: Border.all(
                                                      color: Color(0XFFE5E5E5),
                                                      width: ScreenUtil().setWidth(4),
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: ScreenUtil().setWidth(10),
                                                ),
                                                Text(
                                                  'N. venta',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF585858),
                                                    fontSize: ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w500,
                                                    letterSpacing: ScreenUtil().setSp(0.016),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                                SizedBox(
                                  height: ScreenUtil().setWidth(16),
                                ),
                                SizedBox(height: ScreenUtil().setHeight(8)),
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (_, g) {
                                    if (_controller.mostrarTextField) {
                                      return Column(
                                        children: [
                                          TextField(
                                            focusNode: _focus1,
                                            controller: _rucController,
                                            maxLines: 1,
                                            onChanged: (value) {
                                              if (_rucController.text.length > 0 &&
                                                  _razonController.text.length > 0 &&
                                                  _domicilioController.text.length > 0) {
                                                _controller.changeBoton(true);
                                              } else {
                                                _controller.changeBoton(false);
                                              }
                                            },
                                            keyboardType: TextInputType.number,
                                            maxLength: 11,
                                            decoration: InputDecoration(
                                              counterText: '',
                                              hintText: 'Ingrese RUC',
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
                                            height: ScreenUtil().setHeight(8),
                                          ),
                                          TextField(
                                            focusNode: _focus2,
                                            controller: _razonController,
                                            maxLines: 1,
                                            onChanged: (value) {
                                              if (_rucController.text.length > 0 &&
                                                  _razonController.text.length > 0 &&
                                                  _domicilioController.text.length > 0) {
                                                _controller.changeBoton(true);
                                              } else {
                                                _controller.changeBoton(false);
                                              }
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: 'Ingrese razón social',
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
                                            height: ScreenUtil().setHeight(8),
                                          ),
                                          TextField(
                                            focusNode: _focus3,
                                            controller: _domicilioController,
                                            maxLines: 1,
                                            onChanged: (value) {
                                              if (_rucController.text.length > 0 &&
                                                  _razonController.text.length > 0 &&
                                                  _domicilioController.text.length > 0) {
                                                _controller.changeBoton(true);
                                              } else {
                                                _controller.changeBoton(false);
                                              }
                                            },
                                            keyboardType: TextInputType.text,
                                            decoration: InputDecoration(
                                              hintText: 'Ingrese domicilio',
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
                                        ],
                                      );
                                    } else {
                                      return Container();
                                    }
                                  },
                                ),
                                SizedBox(height: ScreenUtil().setHeight(48)),
                                InkWell(
                                  onTap: () async {
                                    _controller.changeCargando(true);
                                    _controller.changeText('');
                                    if (_controller.boton) {
                                      final _ventaApi = VentaApi();
                                      final res = await _ventaApi.guardarVenta(pedido.idPedido, _controller.tipoDoc, _rucController.text,
                                          _razonController.text, _domicilioController.text);
                                      if (res) {
                                        final mesasBloc = ProviderBloc.mesas(context);
                                        mesasBloc.obtenerMesasPorNegocio();
                                        Navigator.pop(context);
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
                                        return Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(50),
                                              color: (_controller.boton) ? Color(0XFFFF0036) : Color(0XFFFF0036).withOpacity(0.6),
                                            ),
                                            child: Center(
                                              child: Text(
                                                'Pagar S/${pedido.total}',
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