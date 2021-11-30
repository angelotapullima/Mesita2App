import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/api/comanda_temporal_api.dart';
import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/database/pedidos_temporales_database.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/agregar_producto_page.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class ComandaPage extends StatefulWidget {
  final MesaModel mesa;
  ComandaPage({Key key, @required this.mesa}) : super(key: key);

  @override
  _ComandaPageState createState() => _ComandaPageState();
}

class _ComandaPageState extends State<ComandaPage> {
  final _controller = ComandaController();
  @override
  Widget build(BuildContext context) {
    final comandaBloc = ProviderBloc.comanda(context);
    comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
    return StreamBuilder(
      stream: comandaBloc.comandaStream,
      builder: (context, AsyncSnapshot<List<DetallePedidoTemporalModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.length > 0) {
            var comanda = snapshot.data;
            double total = 00.00;
            for (var i = 0; i < comanda.length; i++) {
              total = total + (double.parse(comanda[i].subtotal));
            }

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: comanda.length,
                        itemBuilder: (context, index) {
                          return Container(
                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(8)),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  height: ScreenUtil().setHeight(80),
                                  width: ScreenUtil().setWidth(80),
                                  decoration: BoxDecoration(
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
                                          tag: comanda[index].id,
                                          child: Container(
                                            height: ScreenUtil().setHeight(64),
                                            width: ScreenUtil().setWidth(64),
                                            decoration: BoxDecoration(
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
                                              placeholder: (context, url) => Container(
                                                child: SvgPicture.asset('assets/food_svg/food.svg'),
                                              ),
                                              errorWidget: (context, url, error) => Container(
                                                child: Container(
                                                  child: SvgPicture.asset(
                                                    'assets/food_svg/food.svg',
                                                  ),
                                                ),
                                              ),
                                              imageUrl: '$apiBaseURL/${comanda[index].foto}',
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
                                        //child: SvgPicture.asset('assets/food_svg/food.svg')),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  width: ScreenUtil().setWidth(150),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${comanda[index].nombre}',
                                        style: GoogleFonts.poppins(
                                          color: Color(0XFF585858),
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(16),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setHeight(13),
                                      ),
                                      Text(
                                        'S/${comanda[index].subtotal}',
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w700,
                                          fontSize: ScreenUtil().setSp(16),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                                  height: ScreenUtil().setHeight(32),
                                  //width: ScreenUtil().setWidth(86),
                                  decoration: BoxDecoration(
                                    color: Color(0XFFFF0036),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Color.fromRGBO(88, 88, 88, 0.5),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () async {
                                          final _comandaTemporalApi = ComandaTemporalApi();
                                          final res = await _comandaTemporalApi.updateDetalle(comanda[index], -1);
                                          if (res == 1) {
                                            comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
                                          }
                                        },
                                        child: Container(
                                          width: ScreenUtil().setWidth(16),
                                          child: SvgPicture.asset('assets/food_svg/minus.svg'),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.symmetric(horizontal: 8),
                                        height: ScreenUtil().setHeight(22),
                                        width: ScreenUtil().setWidth(22),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color.fromRGBO(88, 88, 88, 0.5),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            '${comanda[index].cantidad}',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () async {
                                            final _comandaTemporalApi = ComandaTemporalApi();
                                            final res = await _comandaTemporalApi.updateDetalle(comanda[index], 1);
                                            if (res == 1) {
                                              comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
                                            }
                                          },
                                          child: Container(
                                            width: ScreenUtil().setWidth(16),
                                            child: SvgPicture.asset('assets/food_svg/plus.svg'),
                                          )),
                                    ],
                                  ),
                                ),
                                // InkWell(
                                //   onTap: () async {
                                //     final _ptDB = PedidosTemporalDatabase();
                                //     await _ptDB.deleteDetallesPedidoTemporalPorId(comanda[index].id);
                                //     comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
                                //   },
                                //   child: Container(
                                //     padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                                //     height: ScreenUtil().setHeight(32),
                                //     //width: ScreenUtil().setWidth(86),
                                //     decoration: BoxDecoration(
                                //       color: Color(0XFFFF0036),
                                //       borderRadius: BorderRadius.circular(30),
                                //       boxShadow: [
                                //         BoxShadow(
                                //           color: Color.fromRGBO(88, 88, 88, 0.5),
                                //         ),
                                //       ],
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //       children: [
                                //         Container(
                                //           margin: EdgeInsets.symmetric(horizontal: 8),
                                //           height: ScreenUtil().setHeight(22),
                                //           width: ScreenUtil().setWidth(22),
                                //           decoration: BoxDecoration(
                                //             color: Colors.white,
                                //             shape: BoxShape.circle,
                                //             boxShadow: [
                                //               BoxShadow(
                                //                 color: Color.fromRGBO(88, 88, 88, 0.5),
                                //               ),
                                //             ],
                                //           ),
                                //           child: Center(
                                //             child: Text(
                                //               '${comanda[index].cantidad}',
                                //               style: GoogleFonts.poppins(
                                //                 fontWeight: FontWeight.w700,
                                //                 fontSize: ScreenUtil().setSp(16),
                                //               ),
                                //             ),
                                //           ),
                                //         ),
                                //         Icon(
                                //           Icons.delete_outline,
                                //         ),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    _rayas(),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(8)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                          Text(
                            'S/ ${total.toStringAsFixed(2)}',
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ],
                      ),
                    ),
                    _rayas(),
                    Container(
                      margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(24),
                        right: ScreenUtil().setWidth(24),
                        bottom: ScreenUtil().setHeight(4),
                        top: ScreenUtil().setHeight(16),
                      ),
                      width: double.infinity,
                      child: MaterialButton(
                        color: Colors.white,
                        textColor: Color(0XFF585858),
                        elevation: 1,
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              opaque: false,
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return AgregarProductoPage(
                                  mesa: widget.mesa,
                                  esComanda: true,
                                  idEnviar: widget.mesa.idMesa,
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
                          'Agregar pedidos',
                          style: GoogleFonts.poppins(
                            color: Color(0XFFFF0036),
                            fontWeight: FontWeight.w500,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24), bottom: ScreenUtil().setHeight(16)),
                      width: double.infinity,
                      child: MaterialButton(
                        color: Color(0XFFFF0036),
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: () async {
                          _controller.changeCargando(true);
                          final _pedidoApi = PedidosApi();

                          final res = await _pedidoApi.enviarComanda(widget.mesa.idMesa, total.toString());

                          if (res) {
                            final pedidosBloc = ProviderBloc.pedidos(context);
                            pedidosBloc.obtenerPedidosPorIdMesa(widget.mesa.idMesa);
                          }
                          _controller.changeCargando(false);
                        },
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(20.0),
                          ),
                        ),
                        child: Text(
                          'Generar pedido',
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
                AnimatedBuilder(
                    animation: _controller,
                    builder: (_, t) {
                      return (_controller.cargando) ? _showLoading() : Container();
                    }),
              ],
            );
          } else {
            return Center(
              child: Container(
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(50),
                  vertical: ScreenUtil().setHeight(16),
                ),
                width: double.infinity,
                child: MaterialButton(
                  color: Color(0XFFFF0036),
                  textColor: Colors.white,
                  elevation: 10,
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        opaque: false,
                        pageBuilder: (context, animation, secondaryAnimation) {
                          return AgregarProductoPage(
                            mesa: widget.mesa,
                            esComanda: true,
                            idEnviar: widget.mesa.idMesa,
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
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(20.0),
                    ),
                  ),
                  child: Text(
                    'Agregar pedidos',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ),
            );
          }
        } else {
          return _showLoading();
        }
      },
    );
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

  Widget _rayas() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(8)),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Flex(
            children: List.generate(
              (constraints.constrainWidth() / 10).floor(),
              (index) => SizedBox(
                height: ScreenUtil().setHeight(1),
                width: ScreenUtil().setWidth(5),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    color: Color(0xFFC4C4C4),
                  ),
                ),
              ),
            ),
            direction: Axis.horizontal,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          );
        },
      ),
    );
  }
}

class ComandaController extends ChangeNotifier {
  bool cargando = false;
  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }
}
