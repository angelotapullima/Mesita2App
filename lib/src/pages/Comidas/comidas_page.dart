import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/pages/Products/modals_products.dart';
import 'package:mesita_aplication_2/src/pages/Lineas_Categories/settings_lines_category.dart';
import 'package:mesita_aplication_2/src/pages/Products/detail_product.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ComidasPage extends StatefulWidget {
  const ComidasPage({Key key}) : super(key: key);

  @override
  _ComidasPageState createState() => _ComidasPageState();
}

class _ComidasPageState extends State<ComidasPage> {
  final _refreshController = RefreshController(initialRefresh: false);
  final _controller = CategoryController();
  final String idCategoria = '1';
  int carga = 0;

  void _refresher(String idLinea) {
    final productosLineaBloc = ProviderBloc.productosLinea(context);
    productosLineaBloc.updateProductosPorLinea(idLinea);

    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    final lineasBloc = ProviderBloc.lineas(context);
    if (carga == 0) {
      lineasBloc.updateLineasPorNegocio(idCategoria);
      carga++;
    } else {
      lineasBloc.obtenerLineasPorNegocio(idCategoria);
    }

    final productosLineaBloc = ProviderBloc.productosLinea(context);
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFE5E5E5),
        leading: InkWell(
          child: Container(),
        ),
        actions: [
          InkWell(
            onTap: () {
              addModal(context, idCategoria, 'comida', 'new_food');
            },
            child: Container(
              width: ScreenUtil().setWidth(20),
              height: ScreenUtil().setHeight(20),
              child: SvgPicture.asset('assets/food_svg/add_food.svg'),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
          circleUser(context, prefs),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        title: Text(
          'Comidas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
      body: StreamBuilder(
          stream: lineasBloc.lineasStream,
          builder: (context, AsyncSnapshot<List<LineaModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                var lineas = snapshot.data;
                productosLineaBloc.obtenerProductosPorLinea(lineas[0].idLinea);
                return SmartRefresher(
                  controller: _refreshController,
                  onRefresh: () {
                    _refresher(lineas[_controller.index].idLinea);
                  },
                  child: Column(
                    children: [
                      Container(
                        height: ScreenUtil().setHeight(40),
                        child: ListView.builder(
                          itemCount: lineas.length + 1,
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (BuildContext context, int index) {
                            if (index == lineas.length) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return SettingsLinesCategory(
                                          idCategoria: idCategoria,
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
                                  margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                                  height: ScreenUtil().setHeight(30),
                                  width: ScreenUtil().setWidth(30),
                                  child: SvgPicture.asset('assets/food_svg/settings_category.svg'),
                                ),
                              );
                            }
                            return AnimatedBuilder(
                                animation: _controller,
                                builder: (_, s) {
                                  return InkWell(
                                    onTap: () {
                                      //_controller.changeIdSelect(lineas[index].idLinea);
                                      productosLineaBloc.obtenerProductosPorLinea(lineas[index].idLinea);
                                      _controller.changeIndex(index);
                                    },
                                    child: Container(
                                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                                      padding: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(28),
                                      ),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(22),
                                          color: (index == _controller.index) ? Color(0XFFFF0036) : Color(0XFFE5E5E5),
                                          boxShadow: [
                                            BoxShadow(
                                              color: (index == _controller.index) ? Color.fromRGBO(255, 0, 54, 0.5) : Colors.transparent,
                                            )
                                          ]),
                                      child: Center(
                                          child: Text(
                                        lineas[index].lineaNombre,
                                        style: TextStyle(
                                          color: (index == _controller.index) ? Colors.white : Color(0xFF585858),
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
                      ),
                      Expanded(
                        child: StreamBuilder(
                          stream: productosLineaBloc.productosLineaStream,
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
                                  child: Text('Aún no existen comidas para esta línea'),
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
                );
              } else {
                return Center(
                  child: Text('Aún no se agregaron líneas'),
                );
              }
            } else {
              return _showLoading();
            }
          }),
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
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return DetailProduct(
                producto: food,
                nameCategory: 'comida',
                idCategory: idCategoria,
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
