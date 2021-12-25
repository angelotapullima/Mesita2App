import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_atender_model.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/atender_pedido.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    final atenderBloc = ProviderBloc.atender(context);
    atenderBloc.obtenerPedidosAtenderPorEmpresa();
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
          'Pedidos',
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
                SizedBox(
                  height: ScreenUtil().setHeight(21),
                  width: ScreenUtil().setWidth(21),
                  child: SvgPicture.asset('assets/food_svg/order_listo.svg'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(8),
                ),
                Text(
                  'Listo',
                  style: GoogleFonts.poppins(
                    color: const Color(0XFF585858),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    letterSpacing: 0.16,
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(48),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(21),
                  width: ScreenUtil().setWidth(21),
                  child: SvgPicture.asset('assets/food_svg/order_pendiente.svg'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(8),
                ),
                Text(
                  'Cocinando',
                  style: GoogleFonts.poppins(
                    color: const Color(0XFF585858),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    letterSpacing: 0.16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(120),
                  child: Text(
                    'Mesa',
                    style: GoogleFonts.poppins(
                      color: const Color(0XFFD1D1D1),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(85),
                  child: Text(
                    'Producto',
                    style: GoogleFonts.poppins(
                      color: const Color(0XFFD1D1D1),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      letterSpacing: 0.16,
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
              child: StreamBuilder(
                stream: atenderBloc.atenderStream,
                builder: (context, AsyncSnapshot<List<PedidosAtenderModel>> snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data.isNotEmpty) {
                      var pedidos = snapshot.data;
                      return ListView.builder(
                        itemCount: pedidos.length,
                        itemBuilder: (context, index) {
                          return _datoPedido(context, pedidos[index]);
                        },
                      );
                    } else {
                      return const Center(
                        child: Text('Sin pedidos'),
                      );
                    }
                  } else {
                    return _mostrarAlert();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _datoPedido(BuildContext context, PedidosAtenderModel pedido) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            PageRouteBuilder(
              opaque: false,
              pageBuilder: (context, animation, secondaryAnimation) {
                return AtenderPedido(
                  pedidoDetalle: pedido,
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: ScreenUtil().setWidth(100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    pedido.mesaNombre,
                    style: GoogleFonts.poppins(
                      fontSize: (pedido.mesaNombre.length > 2) ? ScreenUtil().setSp(8) : ScreenUtil().setSp(35),
                      color: const Color(0xfff9708d),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.16,
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(55),
                    width: ScreenUtil().setWidth(55),
                    decoration: const BoxDecoration(
                      color: Color(0XFFEEEEEE),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromRGBO(88, 88, 88, 0.3),
                          blurRadius: 20,
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: Hero(
                            tag: pedido.idProducto,
                            child: Container(
                              height: ScreenUtil().setHeight(64),
                              width: ScreenUtil().setWidth(64),
                              decoration: const BoxDecoration(
                                color: Color(0XFFEEEEEE),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    offset: Offset(-1, -1),
                                    color: Color.fromRGBO(0, 0, 0, 0.2),
                                    blurRadius: 5,
                                  ),
                                ],
                              ),
                              child: CachedNetworkImage(
                                placeholder: (context, url) => SizedBox(
                                  child: SvgPicture.asset('assets/food_svg/food.svg'),
                                ),
                                errorWidget: (context, url, error) => SizedBox(
                                  child: SvgPicture.asset(
                                    'assets/food_svg/food.svg',
                                  ),
                                ),
                                imageUrl: '$apiBaseURL/${pedido.fotoProducto}',
                                imageBuilder: (context, imageProvider) => Container(
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(78),
              child: Text(
                pedido.nombreProducto,
                style: GoogleFonts.poppins(
                  color: const Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(14),
                  letterSpacing: 0.16,
                ),
              ),
            ),
            SizedBox(
              width: ScreenUtil().setWidth(25),
              child: Text(
                'X${pedido.cantidad}',
                style: GoogleFonts.poppins(
                  color: const Color(0XFF585858),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(33),
              width: ScreenUtil().setWidth(28),
              child: SvgPicture.asset('assets/food_svg/${(pedido.estado == '1') ? 'order_pendiente' : 'order_listo'}.svg'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _mostrarAlert() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromRGBO(0, 0, 0, 0.1),
      child: Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator(
                color: Color(0xffFF0036),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}
