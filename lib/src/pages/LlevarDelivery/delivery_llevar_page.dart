// ignore_for_file: sized_box_for_whitespace

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:mesita_aplication_2/src/pages/LlevarDelivery/comanda_delivery_llevar.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/agregar_pedidos_mesa.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/agregar_producto_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/comanda_mesa_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/editar_producto_pedido.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/modal_pagar_pedido.dart';

class DeliveryLlevarPage extends StatelessWidget {
  final MesaModel mesa;
  final String text;
  const DeliveryLlevarPage({Key key, @required this.mesa, @required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final pedidosBloc = ProviderBloc.pedidos(context);
    pedidosBloc.obtenerPedidosPorIdMesaParaLlevarYDelivery(mesa.idMesa, mesa.mesaTipo);

    return Scaffold(
      backgroundColor: const Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0XFFFF0036),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          mesa.mesaNombre,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(18),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: ScreenUtil().setHeight(200),
            child: Stack(
              children: [
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(150),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9708D),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(125),
                    decoration: const BoxDecoration(
                      color: Color(0XFFFF0036),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            text,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(90),
            ),
            child: (mesa.mesaTipo == '1')
                ? StreamBuilder(
                    stream: pedidosBloc.pedidosParaLlevarStream,
                    builder: (context, AsyncSnapshot<List<PedidoModel>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isNotEmpty) {
                          var datos = snapshot.data;
                          return Column(
                            children: [
                              Expanded(
                                child: _listPedidos(context, datos),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(50),
                                  vertical: ScreenUtil().setHeight(16),
                                ),
                                width: double.infinity,
                                child: MaterialButton(
                                  color: const Color(0XFFFF0036),
                                  textColor: Colors.white,
                                  elevation: 10,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return ComandaDeliveryLlevar(
                                            mesa: mesa,
                                            text: 'Nueva comanda para llevar',
                                          );
                                        },
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          var begin = const Offset(0.0, 1.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;

                                          var tween = Tween(begin: begin, end: end).chain(
                                            CurveTween(curve: curve),
                                          );

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Generar nueva comanda',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ComandaPage(
                            mesa: mesa,
                            esComandaCero: true,
                          );
                        }
                      } else {
                        return _showLoading();
                      }
                    },
                  )
                : StreamBuilder(
                    stream: pedidosBloc.pedidosDeliveryStream,
                    builder: (context, AsyncSnapshot<List<PedidoModel>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.isNotEmpty) {
                          var datos = snapshot.data;
                          return Column(
                            children: [
                              Expanded(
                                child: _listPedidos(context, datos),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(
                                  horizontal: ScreenUtil().setWidth(50),
                                  vertical: ScreenUtil().setHeight(16),
                                ),
                                width: double.infinity,
                                child: MaterialButton(
                                  color: const Color(0XFFFF0036),
                                  textColor: Colors.white,
                                  elevation: 10,
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        opaque: false,
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return ComandaDeliveryLlevar(
                                            mesa: mesa,
                                            text: 'Nueva comanda para delivery',
                                          );
                                        },
                                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          var begin = const Offset(0.0, 1.0);
                                          var end = Offset.zero;
                                          var curve = Curves.ease;

                                          var tween = Tween(begin: begin, end: end).chain(
                                            CurveTween(curve: curve),
                                          );

                                          return SlideTransition(
                                            position: animation.drive(tween),
                                            child: child,
                                          );
                                        },
                                      ),
                                    );
                                  },
                                  shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(20.0),
                                    ),
                                  ),
                                  child: Text(
                                    'Generar nueva comanda',
                                    style: GoogleFonts.poppins(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return ComandaPage(
                            mesa: mesa,
                            esComandaCero: true,
                          );
                        }
                      } else {
                        return _showLoading();
                      }
                    },
                  ),
          )
        ],
      ),
    );
  }

  Widget _listPedidos(BuildContext context, List<PedidoModel> datos) {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: datos.length,
      itemBuilder: (_, index) {
        return ExpansionTile(
          onExpansionChanged: (valor) {},
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Pedido N° ${datos[index].idPedido}',
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),
                  Icon(
                    Icons.person,
                    size: ScreenUtil().setHeight(16),
                    color: const Color(0XFF585858),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(4),
                  ),
                  Text(
                    datos[index].nombre,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.place,
                    size: ScreenUtil().setHeight(16),
                    color: const Color(0XFF585858),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(4),
                  ),
                  Text(
                    datos[index].direccion,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(8),
                  ),
                  Icon(
                    Icons.phone,
                    size: ScreenUtil().setHeight(16),
                    color: const Color(0XFF585858),
                  ),
                  SizedBox(
                    width: ScreenUtil().setWidth(4),
                  ),
                  Text(
                    datos[index].telefono,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ],
              ),
            ],
          ),
          iconColor: const Color(0XFFFF0036),
          trailing: Container(
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
            child: const Icon(Icons.keyboard_arrow_down),
          ),
          children: [
            Container(
              height: ScreenUtil().setHeight(200),
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: datos[index].detallesPedido.length,
                      itemBuilder: (_, index2) {
                        var pedido = datos[index].detallesPedido[index2];

                        return _pedidoItem(context, pedido, datos[index].idMesa);
                      },
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        width: ScreenUtil().setWidth(100),
                        child: MaterialButton(
                          color: Colors.white,
                          textColor: const Color(0XFF585858),
                          elevation: 0,
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return AgregarProductoPage(
                                    mesa: mesa,
                                    esComanda: false,
                                    idEnviar: datos[index].idPedido,
                                  );
                                },
                                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  var begin = const Offset(0.0, 1.0);
                                  var end = Offset.zero;
                                  var curve = Curves.ease;

                                  var tween = Tween(begin: begin, end: end).chain(
                                    CurveTween(curve: curve),
                                  );

                                  return SlideTransition(
                                    position: animation.drive(tween),
                                    child: child,
                                  );
                                },
                              ),
                            );
                          },
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(22),
                            side: const BorderSide(
                              color: Color(0XFFFF0036),
                            ),
                          ),
                          child: Text(
                            'Agregar',
                            style: GoogleFonts.poppins(
                              color: const Color(0XFFFF0036),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(200),
                        child: MaterialButton(
                          color: const Color(0XFFFF0036),
                          textColor: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            pagarPedidoModal(context, datos[index], true, mesa.mesaTipo);
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            'Pagar S/. ${datos[index].total}',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

  Widget _pedidoItem(BuildContext context, DetallePedidoModel pedido, String idMesa) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return EditarDetalleProductoPedido(
                producto: pedido,
                idMesa: idMesa,
                tipoMesa: mesa.mesaTipo,
              );
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = const Offset(0.0, 1.0);
              var end = Offset.zero;
              var curve = Curves.ease;

              var tween = Tween(begin: begin, end: end).chain(
                CurveTween(curve: curve),
              );

              return SlideTransition(
                position: animation.drive(tween),
                child: child,
              );
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(24),
          vertical: ScreenUtil().setHeight(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pedido.nombreProducto,
                    style: GoogleFonts.poppins(
                      color: const Color(0XFF585858),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  Text(
                    'S/${pedido.totalDetalle}',
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w700,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(5),
                  ),
                  (pedido.observaciones == 'null')
                      ? Container()
                      : Text(pedido.observaciones,
                          style: GoogleFonts.poppins(
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(14),
                          ),
                          maxLines: 2),
                ],
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(8),
            ),
            Text(
              'X',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil().setSp(15),
              ),
            ),
            Text(
              pedido.cantidad,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil().setSp(15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _showLoading() {
    return Center(
      child: (Platform.isAndroid)
          ? const CircularProgressIndicator(
              color: Color(0XFFFF0036),
            )
          : const CupertinoActivityIndicator(),
    );
  }
}
