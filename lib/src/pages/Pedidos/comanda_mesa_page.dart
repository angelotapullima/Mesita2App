import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class ComandaPage extends StatefulWidget {
  final MesaModel mesa;
  ComandaPage({Key key, @required this.mesa}) : super(key: key);

  @override
  _ComandaPageState createState() => _ComandaPageState();
}

class _ComandaPageState extends State<ComandaPage> {
  @override
  Widget build(BuildContext context) {
    double total = 00.00;
    final comandaBloc = ProviderBloc.comanda(context);
    comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
    return StreamBuilder(
        stream: comandaBloc.comandaStream,
        builder: (context, AsyncSnapshot<List<DetallePedidoTemporalModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              var comanda = snapshot.data;

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: comanda.length,
                      itemBuilder: (context, index) {
                        total = total + (double.parse(comanda[index].subtotal) );
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
                              Column(
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
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
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
                                    Text(
                                      '-',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: ScreenUtil().setSp(16),
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
                                    Text(
                                      '+',
                                      style: GoogleFonts.poppins(
                                        fontWeight: FontWeight.w700,
                                        fontSize: ScreenUtil().setSp(16),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
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
                          'S/ $total',
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
                    margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(16)),
                    width: double.infinity,
                    child: MaterialButton(
                      color: Color(0XFFFF0036),
                      textColor: Colors.white,
                      elevation: 10,
                      onPressed: () async {
                        final _pedidoApi = PedidosApi();

                        final res = await _pedidoApi.enviarComanda(widget.mesa.idMesa, total.toString());

                        if (res) {
                          final pedidosBloc = ProviderBloc.pedidos(context);
                          pedidosBloc.obtenerPedidosPorIdMesa(widget.mesa.idMesa);
                        }
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
              );
            } else {
              return Center(
                child: Text('Debe agregar productos para crear la comanda'),
              );
            }
          } else {
            return _showLoading();
          }
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
