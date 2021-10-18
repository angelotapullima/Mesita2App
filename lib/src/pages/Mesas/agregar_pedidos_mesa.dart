import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/pages/Busqueda/buscar_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/delete_mesa.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/modal_agregar_mesa.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/comanda_mesa_page.dart';

class AgregarePedidoMesa extends StatefulWidget {
  final MesaModel mesa;
  const AgregarePedidoMesa({Key key, @required this.mesa}) : super(key: key);

  @override
  _DetalleMesaPageState createState() => _DetalleMesaPageState();
}

class _DetalleMesaPageState extends State<AgregarePedidoMesa> {
  bool esComanda;
  String idEnviar;
  @override
  void initState() {
    esComanda = true;
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
                      child: ComandaPage(
                        mesa: mesaData[0],
                      ),
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
