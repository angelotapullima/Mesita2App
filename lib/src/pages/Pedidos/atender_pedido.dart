import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_atender_model.dart';
import 'package:mesita_aplication_2/src/pages/Lineas_Categories/modal_edit_line.dart';

class AtenderPedido extends StatefulWidget {
  final PedidosAtenderModel pedidoDetalle;
  const AtenderPedido({Key key, @required this.pedidoDetalle}) : super(key: key);

  @override
  _AtenderPedidoState createState() => _AtenderPedidoState();
}

class _AtenderPedidoState extends State<AtenderPedido> {
  final _controller = ChangeController();
  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color(0XFFC4C4C4).withOpacity(.6),
      child: Stack(
        children: [
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: const SizedBox(
              height: double.infinity,
              width: double.infinity,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    _controller.changeCargando(true);
                    final _pedidoApi = PedidosApi();
                    final res = await _pedidoApi.atenderPedido(widget.pedidoDetalle);
                    if (res) {
                      final atenderBloc = ProviderBloc.atender(context);
                      atenderBloc.obtenerPedidosAtenderPorEmpresa();
                      Navigator.pop(context);
                    } else {
                      _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                    }
                    _controller.changeCargando(false);
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(44),
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                      color: const Color(0XFFEDEDED),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Text(
                        'Atender pedido',
                        style: TextStyle(
                          color: Colors.green,
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: ScreenUtil().setHeight(44),
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                    padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                    decoration: BoxDecoration(
                      color: const Color(0XFFEDEDED),
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: Center(
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          color: const Color(0XFF585858),
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
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
                SizedBox(
                  height: ScreenUtil().setHeight(8),
                ),
              ],
            ),
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
      ),
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
