import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:mesita_aplication_2/src/pages/Busqueda/buscar_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/delete_mesa.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/modal_agregar_mesa.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/agregar_producto_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/comanda_mesa_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/editar_producto_pedido.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/modal_pagar_pedido.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class DetalleMesaPage extends StatefulWidget {
  final MesaModel mesa;
  const DetalleMesaPage({Key key, @required this.mesa}) : super(key: key);

  @override
  _DetalleMesaPageState createState() => _DetalleMesaPageState();
}

class _DetalleMesaPageState extends State<DetalleMesaPage> {
  bool esComanda;
  String idEnviar;
  @override
  void initState() {
    esComanda = false;
    idEnviar = '';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final mesaBloc = ProviderBloc.mesas(context);
    mesaBloc.obtenerMesaPorId(widget.mesa.idMesa);

    final pedidosBloc = ProviderBloc.pedidos(context);
    pedidosBloc.obtenerPedidosPorIdMesa(widget.mesa.idMesa);
    return StreamBuilder(
        stream: mesaBloc.mesaStream,
        builder: (context, AsyncSnapshot<List<MesaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              var mesaData = snapshot.data;
              return Scaffold(
                backgroundColor: Color(0XFFE5E5E5),
                appBar: AppBar(
                  backgroundColor: Color(0XFFFF0036),
                  elevation: 0,
                  iconTheme: IconThemeData(color: Colors.white),
                  title: Text(
                    'Mesa ${mesaData[0].mesaNombre}',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(18),
                    ),
                  ),
                  actions: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            opaque: false,
                            pageBuilder: (context, animation, secondaryAnimation) {
                              return DeleteMesa(
                                mesaData: mesaData[0],
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
                        height: ScreenUtil().setHeight(20),
                        width: ScreenUtil().setWidth(20),
                        child: SvgPicture.asset('assets/svg/close_mesa.svg'),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(24),
                    ),
                    InkWell(
                      onTap: () {
                        editMesaModal(context, mesaData[0]);
                      },
                      child: Container(
                        height: ScreenUtil().setHeight(20),
                        width: ScreenUtil().setWidth(20),
                        child: SvgPicture.asset('assets/svg/edit_mesa.svg'),
                      ),
                    ),
                    SizedBox(
                      width: ScreenUtil().setWidth(24),
                    ),
                  ],
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
                              height: ScreenUtil().setHeight(200),
                              decoration: BoxDecoration(
                                color: Color(0xFFF9708D),
                              ),
                            ),
                          ),
                          ClipPath(
                            clipper: HeaderFormaClipper(),
                            child: Container(
                              height: ScreenUtil().setHeight(185),
                              decoration: BoxDecoration(
                                color: Color(0XFFFF0036),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Center(
                                    child: Text(
                                      'Capacidad para ${mesaData[0].mesaCapacidad} personas',
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
                                  SizedBox(
                                    height: ScreenUtil().setHeight(44),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          PageRouteBuilder(
                                            pageBuilder: (context, animation, secondaryAnimation) {
                                              return BuscarPage();
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
                                        margin: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setHeight(24),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setHeight(19),
                                        ),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(22),
                                        ),
                                        child: Row(
                                          children: [
                                            Icon(Icons.search),
                                            SizedBox(
                                              width: ScreenUtil().setHeight(13),
                                            ),
                                            Text(
                                              'Buscar comidas y bebidas',
                                              style: GoogleFonts.poppins(
                                                color: Color(0XFFA8A7A7),
                                                fontWeight: FontWeight.w400,
                                                fontSize: ScreenUtil().setSp(16),
                                              ),
                                            ),
                                          ],
                                        ),
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
                        top: ScreenUtil().setHeight(130),
                      ),
                      child: StreamBuilder(
                          stream: pedidosBloc.pedidosPorMesaStream,
                          builder: (context, AsyncSnapshot<List<PedidoModel>> snapshot) {
                            if (snapshot.hasData) {
                              if (snapshot.data.length > 0) {
                                //Mostrar el pedido que ya existe en el back
                                esComanda = false;
                                var pedidos = snapshot.data;
                                idEnviar = pedidos[0].idPedido;
                                return Column(
                                  children: [
                                    Expanded(
                                      child: ListView.builder(
                                          shrinkWrap: true,
                                          padding: EdgeInsets.zero,
                                          itemCount: pedidos[0].detallesPedido.length,
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  PageRouteBuilder(
                                                    pageBuilder: (context, animation, secondaryAnimation) {
                                                      return EditarDetalleProductoPedido(
                                                        producto: pedidos[0].detallesPedido[index],
                                                        idMesa: pedidos[0].idMesa,
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
                                                  vertical: ScreenUtil().setHeight(8),
                                                ),
                                                margin: EdgeInsets.symmetric(
                                                  vertical: ScreenUtil().setHeight(8),
                                                ),
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
                                                              tag: pedidos[0].detallesPedido[index].idDetalle,
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
                                                                  imageUrl: '$apiBaseURL/${pedidos[0].detallesPedido[index].fotoProducto}',
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
                                                    SizedBox(
                                                      width: ScreenUtil().setWidth(8),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            '${pedidos[0].detallesPedido[index].nombreProducto}',
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
                                                            'S/${pedidos[0].detallesPedido[index].totalDetalle}',
                                                            style: GoogleFonts.poppins(
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: ScreenUtil().setSp(16),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            height: ScreenUtil().setHeight(5),
                                                          ),
                                                          ('${pedidos[0].detallesPedido[index].observaciones}' == 'null')
                                                              ? Container()
                                                              : Text('${pedidos[0].detallesPedido[index].observaciones}',
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
                                                      '${pedidos[0].detallesPedido[index].cantidad}',
                                                      style: GoogleFonts.poppins(
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: ScreenUtil().setSp(15),
                                                      ),
                                                    ),
                                                    /* Container(
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
                                                                '${pedidos[0].detallesPedido[index].cantidad}',
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
                                                  */
                                                  ],
                                                ),
                                              ),
                                            );
                                          }),
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
                                            'S/${pedidos[0].total}',
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
                                                  esComanda: false,
                                                  idEnviar: idEnviar,
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
                                      margin: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(24), right: ScreenUtil().setWidth(24), bottom: ScreenUtil().setHeight(16)),
                                      width: double.infinity,
                                      child: MaterialButton(
                                        color: Color(0XFFFF0036),
                                        textColor: Colors.white,
                                        elevation: 1,
                                        onPressed: () {
                                          pagarPedidoModal(context, pedidos[0]);
                                        },
                                        shape: const RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.0),
                                          ),
                                        ),
                                        child: Text(
                                          'Pagar pedidos',
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
                                //Se creará la nueva comanda en db interna
                                esComanda = true;
                                idEnviar = mesaData[0].idMesa;
                                return ComandaPage(
                                  mesa: mesaData[0],
                                );
                              }
                            } else {
                              return _showLoading();
                            }
                          }),
                    ),
                    Positioned(
                      bottom: ScreenUtil().setHeight(24),
                      left: ScreenUtil().setWidth(24),
                      right: ScreenUtil().setWidth(24),
                      child: Column(
                        children: [],
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Scaffold();
            }
          } else {
            return Scaffold(
              body: _showLoading(),
            );
          }
        });
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

  _showLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: Color.fromRGBO(0, 0, 0, 0.2),
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

class HeaderFormaClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(0, size.height - 125);
    var cp1 = Offset(0, size.height - 75);
    var endPoint1 = Offset(75, size.height - 75);

    path.quadraticBezierTo(cp1.dx, cp1.dy, endPoint1.dx, endPoint1.dy);

    path.lineTo(size.width - 75, size.height - 75);

    var cp2 = Offset(size.width, size.height - 75);
    var endPoint2 = Offset(size.width, size.height);

    path.quadraticBezierTo(cp2.dx, cp2.dy, endPoint2.dx, endPoint2.dy);

    path.lineTo(size.width, 0);

    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}
