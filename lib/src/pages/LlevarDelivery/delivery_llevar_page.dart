import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
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
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFFF0036),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
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
            height: ScreenUtil().setHeight(200),
            child: Stack(
              children: [
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(150),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9708D),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(125),
                    decoration: BoxDecoration(
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
                        if (snapshot.data.length > 0) {
                          var datos = snapshot.data;
                          return Column(
                            children: [
                              Expanded(
                                child: _listPedidos(context, datos),
                              ),
                              // ComandaPage(
                              //   mesa: mesa,
                              // )
                            ],
                          );
                        } else {
                          //Se creará la nueva comanda en db interna
                          // esComanda = true;
                          // idEnviar = mesaData[0].idMesa;
                          return Expanded(
                            child: ComandaPage(
                              mesa: mesa,
                            ),
                          );
                        }
                      } else {
                        return Expanded(
                          child: _showLoading(),
                        );
                      }
                    },
                  )
                : StreamBuilder(
                    stream: pedidosBloc.pedidosDeliveryStream,
                    builder: (context, AsyncSnapshot<List<PedidoModel>> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot.data.length > 0) {
                          var datos = snapshot.data;
                          return Column(
                            children: [
                              Expanded(
                                child: _listPedidos(context, datos),
                              ),
                              // ComandaPage(
                              //   mesa: mesa,
                              // )
                            ],
                          );
                        } else {
                          return Expanded(
                            child: ComandaPage(
                              mesa: mesa,
                            ),
                          );
                        }
                      } else {
                        return Expanded(
                          child: _showLoading(),
                        );
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
      //physics: NeverScrollableScrollPhysics(),
      itemCount: datos.length,
      itemBuilder: (_, index) {
        return ExpansionTile(
          onExpansionChanged: (valor) {
            // _changeData.onChangeValue(false, valor, false, false, false, false, false);
          },
          title: Text(
            'Pedido N° ${datos[index].idPedido} - ${datos[index].nombre}',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.black,
              fontSize: ScreenUtil().setSp(16),
            ),
          ),
          iconColor: Color(0XFFFF0036),
          trailing: Container(
            margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
            child: Icon(Icons.keyboard_arrow_down
                // _changeData.vitales ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                // color: ColorsApp.blueClinica,
                ),
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
                          textColor: Color(0XFF585858),
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
                                  var begin = Offset(0.0, 1.0);
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
                            side: BorderSide(
                              color: Color(0XFFFF0036),
                            ),
                          ),
                          child: Text(
                            'Agregar',
                            style: GoogleFonts.poppins(
                              color: Color(0XFFFF0036),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: ScreenUtil().setWidth(200),
                        child: MaterialButton(
                          color: Color(0XFFFF0036),
                          textColor: Colors.white,
                          elevation: 0,
                          onPressed: () {
                            pagarPedidoModal(context, datos[index]);
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
              );
            },
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              var begin = Offset(0.0, 1.0);
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
        margin: EdgeInsets.symmetric(
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
                    '${pedido.nombreProducto}',
                    style: GoogleFonts.poppins(
                      color: Color(0XFF585858),
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
                  ('${pedido.observaciones}' == 'null')
                      ? Container()
                      : Text('${pedido.observaciones}',
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
              '${pedido.cantidad}',
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
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.1),
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
