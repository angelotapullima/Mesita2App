import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/agregar_detalle_producto.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class BuscarPage extends StatefulWidget {
  final String idEnviar;
  final bool esComanda;
  final MesaModel mesa;
  const BuscarPage({Key key, @required this.idEnviar, this.esComanda, this.mesa}) : super(key: key);

  @override
  _BuscarPageState createState() => _BuscarPageState();
}

class _BuscarPageState extends State<BuscarPage> {
  final TextEditingController _queryController = TextEditingController();
  FocusNode focus = FocusNode();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      print('${widget.esComanda}');
      final busquedaBloc = ProviderBloc.productosLinea(context);
      busquedaBloc.obtenerProductosPorQuery('');
      FocusScope.of(context).requestFocus(focus);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final busquedaBloc = ProviderBloc.productosLinea(context);
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      body: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(158),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: ScreenUtil().setHeight(144),
                    width: ScreenUtil().setWidth(359),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9708D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(144),
                  decoration: BoxDecoration(
                    color: Color(0XFFFF0036),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ScreenUtil().setWidth(12),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            width: ScreenUtil().setWidth(300),
                            child: CupertinoSearchTextField(
                              controller: _queryController,
                              backgroundColor: Colors.white,
                              placeholderStyle: GoogleFonts.poppins(
                                color: Color(0XFFA8A7A7),
                                fontWeight: FontWeight.w400,
                                fontSize: ScreenUtil().setSp(16),
                              ),
                              placeholder: 'Buscar comidas y bebidas',
                              focusNode: focus,
                              //onSubmitted: ,
                              onChanged: (value) {
                                if (value.length > 2) {
                                  busquedaBloc.obtenerProductosPorQuery(value);
                                } else {
                                  busquedaBloc.obtenerProductosPorQuery('');
                                }
                              },
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Container(
                              height: ScreenUtil().setHeight(33),
                              width: ScreenUtil().setWidth(33),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0XFFC4C4C4),
                              ),
                              child: Icon(
                                Icons.close_rounded,
                                color: Colors.white,
                                size: ScreenUtil().setWidth(20),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: busquedaBloc.productoBusquedaStream,
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
                      child: Text('Realice una búsqueda'),
                    );
                  }
                } else {
                  return Center(
                    child: (Platform.isAndroid)
                        ? CircularProgressIndicator(
                            color: Color(0XFFFF0036),
                          )
                        : CupertinoActivityIndicator(),
                  );
                }
              },
            ),
          ),
        ],
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
