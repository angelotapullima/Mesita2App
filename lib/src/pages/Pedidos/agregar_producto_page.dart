import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/pages/Busqueda/buscar_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/detalle_mesa_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/agregar_detalle_producto.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class AgregarProductoPage extends StatefulWidget {
  final MesaModel mesa;
  final String idEnviar;
  final bool esComanda;
  const AgregarProductoPage({Key key, @required this.mesa, @required this.idEnviar, @required this.esComanda}) : super(key: key);

  @override
  _AgregarProductoPageState createState() => _AgregarProductoPageState();
}

class _AgregarProductoPageState extends State<AgregarProductoPage> {
  final _controller = CategoryController();
  @override
  Widget build(BuildContext context) {
    final lineasBloc = ProviderBloc.lineas(context);
    lineasBloc.obtenerTodasLasLineasPorNegocio();

    final productosBloc = ProviderBloc.productosLinea(context);
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFFF0036),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Agregar producto',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(18),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Container(
                height: ScreenUtil().setHeight(260),
                child: Stack(
                  children: [
                    ClipPath(
                      clipper: HeaderFormaClipper(),
                      child: Container(
                        height: ScreenUtil().setHeight(270),
                        decoration: BoxDecoration(
                          color: Color(0xFFF9708D),
                        ),
                      ),
                    ),
                    ClipPath(
                      clipper: HeaderFormaClipper(),
                      child: Container(
                        height: ScreenUtil().setHeight(250),
                        decoration: BoxDecoration(
                          color: Color(0XFFFF0036),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Center(
                              child: Text(
                                'Mesa ${widget.mesa.mesaNombre}',
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
                                        return BuscarPage(
                                          idEnviar: widget.idEnviar,
                                          esComanda: widget.esComanda,
                                          mesa: widget.mesa,
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
                            StreamBuilder(
                                stream: lineasBloc.allLineasStream,
                                builder: (context, AsyncSnapshot<List<LineaModel>> snapshot) {
                                  if (snapshot.hasData) {
                                    if (snapshot.data.length > 0) {
                                      var lineas = snapshot.data;
                                      productosBloc.obtenerProductosPorLineaParaPedidos(lineas[0].idLinea);
                                      return Container(
                                        height: ScreenUtil().setHeight(40),
                                        child: ListView.builder(
                                          itemCount: lineas.length,
                                          shrinkWrap: true,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (BuildContext context, int index) {
                                            return AnimatedBuilder(
                                                animation: _controller,
                                                builder: (_, s) {
                                                  return InkWell(
                                                    onTap: () {
                                                      //_controller.changeIdSelect(lineas[index].idLinea);
                                                      productosBloc.obtenerProductosPorLineaParaPedidos(lineas[index].idLinea);
                                                      _controller.changeIndex(index);
                                                    },
                                                    child: Container(
                                                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                                                      padding: EdgeInsets.symmetric(
                                                        horizontal: ScreenUtil().setWidth(28),
                                                      ),
                                                      decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(22),
                                                          color: (index == _controller.index) ? Colors.white : Color(0XFFFF0036),
                                                          boxShadow: [
                                                            BoxShadow(
                                                              color:
                                                                  (index == _controller.index) ? Color.fromRGBO(255, 0, 54, 0.5) : Colors.transparent,
                                                            )
                                                          ]),
                                                      child: Center(
                                                          child: Text(
                                                        lineas[index].lineaNombre,
                                                        style: TextStyle(
                                                          color: (index == _controller.index) ? Color(0xFF585858) : Colors.white,
                                                          fontSize: ScreenUtil().setSp(14),
                                                          fontWeight: FontWeight.w500,
                                                          letterSpacing: 0.16,
                                                        ),
                                                      )),
                                                    ),
                                                  );
                                                });
                                          },
                                        ),
                                      );
                                    } else {
                                      return Container();
                                    }
                                  } else {
                                    return Container();
                                  }
                                }),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: productosBloc.productoPedidosStream,
                  builder: (context, AsyncSnapshot<List<ProductoLineaModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        var food = snapshot.data;
                        return ListView.builder(
                          itemCount: food.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index2) {
                            return itemFood(
                              food[index2],
                            );
                          },
                        );
                      } else {
                        return Center(
                          child: Text('Aún no existen productos para esta línea'),
                        );
                      }
                    } else {
                      return _showLoading();
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
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

  Widget itemFood(ProductoLineaModel food) {
    String disponible = 'Agotado';
    Color color = Colors.red;
    if (food.productoEstado == '1') {
      disponible = 'Disponible';
      color = Colors.green;
    }
    return InkWell(
      onTap: () {
        if (food.productoEstado == '1') {
          Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return AgregarDetalleProducto(
                  producto: food,
                  idEnviar: widget.idEnviar,
                  esComanda: widget.esComanda,
                  idMesa: widget.mesa.idMesa,
                  tipoMesa: widget.mesa.mesaTipo,
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
        }
      },
      child: Container(
        margin: const EdgeInsets.all(24),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(100),
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
                      tag: food.idProducto,
                      child: Container(
                        height: ScreenUtil().setHeight(80),
                        width: ScreenUtil().setWidth(80),
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
                          imageUrl: '$apiBaseURL/${food.productoFoto}',
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
              width: ScreenUtil().setWidth(12),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${food.productoNombre}',
                    style: TextStyle(
                      color: Color(0XFF585858),
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Text(
                    '$disponible',
                    style: TextStyle(
                      color: color,
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Text(
                    'S/${food.productoPrecio}',
                    style: TextStyle(
                      color: Color(0XFF3A3A3A),
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.16,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              child: Icon(
                Icons.arrow_forward_ios,
                size: ScreenUtil().setHeight(12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryController extends ChangeNotifier {
  String idSelec = '1';
  int index = 0;

  void changeIndex(int i) {
    index = i;
    notifyListeners();
  }

  void changeIdSelect(String id) {
    idSelec = id;
    notifyListeners();
  }
}
