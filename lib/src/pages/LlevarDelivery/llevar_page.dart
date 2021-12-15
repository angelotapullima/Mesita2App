import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/agregar_pedidos_mesa.dart';

class LlevarPage extends StatelessWidget {
  const LlevarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFFF0036),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Llevar',
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
                            'Realice pedidos para llevar desde el local',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (_, index) {
                      return ExpansionTile(
                        onExpansionChanged: (valor) {
                          // _changeData.onChangeValue(false, valor, false, false, false, false, false);
                        },
                        title: Text(
                          'Pedido N° ${index + 1}',
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
                                    itemCount: 3,
                                    itemBuilder: (_, index2) {
                                      DetallePedidoModel pedido = DetallePedidoModel();
                                      pedido.nombreProducto = 'Arroz con pollo';
                                      pedido.cantidad = '2';
                                      pedido.observaciones = 'null';
                                      pedido.totalDetalle = '22.00';

                                      return _pedidoItem(pedido);
                                    },
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(200),
                                      child: MaterialButton(
                                        color: Color(0XFFFF0036),
                                        textColor: Colors.white,
                                        elevation: 0,
                                        onPressed: () {
                                          //pagarPedidoModal(context, pedidos[0]);
                                        },
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Pagar S/. 66.60',
                                          style: GoogleFonts.poppins(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                            fontSize: ScreenUtil().setSp(16),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: ScreenUtil().setWidth(100),
                                      child: MaterialButton(
                                        color: Colors.white,
                                        textColor: Color(0XFF585858),
                                        elevation: 0,
                                        onPressed: () {
                                          // Navigator.push(
                                          //   context,
                                          //   PageRouteBuilder(
                                          //     opaque: false,
                                          //     pageBuilder: (context, animation, secondaryAnimation) {
                                          //       return AgregarProductoPage(
                                          //         mesa: widget.mesa,
                                          //         esComanda: false,
                                          //         idEnviar: idEnviar,
                                          //       );
                                          //     },
                                          //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                          //       var begin = Offset(0.0, 1.0);
                                          //       var end = Offset.zero;
                                          //       var curve = Curves.ease;

                                          //       var tween = Tween(begin: begin, end: end).chain(
                                          //         CurveTween(curve: curve),
                                          //       );

                                          //       return SlideTransition(
                                          //         position: animation.drive(tween),
                                          //         child: child,
                                          //       );
                                          //     },
                                          //   ),
                                          // );
                                        },
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(22),
                                          side: BorderSide(
                                            color: Color(0XFFFF0036),
                                          ),
                                        ),
                                        child: Text(
                                          'Agregar pedidos',
                                          style: GoogleFonts.poppins(
                                            color: Color(0XFFFF0036),
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
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _pedidoItem(DetallePedidoModel pedido) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     pageBuilder: (context, animation, secondaryAnimation) {
        //       return EditarDetalleProductoPedido(
        //         producto: pedidos[0].detallesPedido[index],
        //         idMesa: pedidos[0].idMesa,
        //       );
        //     },
        //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
        //       var begin = Offset(0.0, 1.0);
        //       var end = Offset.zero;
        //       var curve = Curves.ease;

        //       var tween = Tween(begin: begin, end: end).chain(
        //         CurveTween(curve: curve),
        //       );

        //       return SlideTransition(
        //         position: animation.drive(tween),
        //         child: child,
        //       );
        //     },
        //   ),
        // );
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
}
