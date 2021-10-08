import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mesita_aplication_2/src/api/producto_linea_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/pages/Products/delete_product.dart';
import 'package:mesita_aplication_2/src/pages/Products/modals_products.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class DetailProduct extends StatefulWidget {
  final ProductoLineaModel producto;
  final String nameCategory;
  final String idCategory;

  const DetailProduct({Key key, @required this.producto, @required this.nameCategory, @required this.idCategory}) : super(key: key);

  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final _controller = ChangeController();
  final _productoApi = ProductoLineaApi();

  final picker = ImagePicker();
  Future<Null> _cropImage(filePath, String idProducto, String idLinea) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cortar Imagen',
            toolbarColor: Color(0XFFFF0036),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            showCropGrid: true,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0, title: 'Cortar Imagen'));
    if (croppedImage != null) {
      _controller.changeCargando(true);
      final res = await _productoApi.cambiarFotoProducto(croppedImage, idProducto);

      if (res == 1) {
        final productoBloc = ProviderBloc.productosLinea(context);
        productoBloc.obtenerProductoPorIdProducto(idProducto, idLinea);
        productoBloc.obtenerProductosPorLinea(idLinea);
      }

      _controller.changeCargando(false);
      //_controller.changeImage(croppedImage);
    }
  }

  Future getImageCamera(String idProducto, String idLinea) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 70);

    if (pickedFile != null) {
      _cropImage(pickedFile.path, idProducto, idLinea);
    }
  }

  Future getImageGallery(String idProducto, String idLinea) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile != null) {
      _cropImage(pickedFile.path, idProducto, idLinea);
    }
    /**/
  }

  @override
  Widget build(BuildContext context) {
    final productoBloc = ProviderBloc.productosLinea(context);
    productoBloc.obtenerProductoPorIdProducto(widget.producto.idProducto, widget.producto.idLinea);
    return Scaffold(
      body: StreamBuilder(
          stream: productoBloc.productoStream,
          builder: (context, AsyncSnapshot<List<ProductoLineaModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                var prod = snapshot.data;
                return Stack(
                  children: [
                    SizedBox(
                      height: double.infinity,
                      width: double.infinity,
                    ),
                    Container(
                      height: ScreenUtil().setHeight(300),
                      width: double.infinity,
                      child: SvgPicture.asset(
                        'assets/svg/back_detail_product.svg',
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: ScreenUtil().setHeight(85),
                      right: ScreenUtil().setWidth(10),
                      child: SafeArea(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (context, animation, secondaryAnimation) {
                                  return DeleteProduct(
                                    productData: prod[0],
                                    nameCategory: widget.nameCategory,
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
                            height: ScreenUtil().setHeight(45),
                            width: ScreenUtil().setWidth(45),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/food_svg/delete_food.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: ScreenUtil().setHeight(25),
                      right: ScreenUtil().setWidth(10),
                      child: SafeArea(
                        child: InkWell(
                          onTap: () {
                            editProductModal(context, prod[0], widget.idCategory, widget.nameCategory);
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(45),
                            width: ScreenUtil().setWidth(45),
                            child: SvgPicture.asset(
                              'assets/food_svg/edit_food.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: ScreenUtil().setHeight(25),
                      left: ScreenUtil().setWidth(10),
                      child: SafeArea(
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: ScreenUtil().setHeight(45),
                            width: ScreenUtil().setWidth(45),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: SvgPicture.asset(
                              'assets/food_svg/backButton.svg',
                            ),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(200),
                      ),
                      /* padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(130),
                ), */
                      height: double.infinity,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setWidth(24),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(130),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  '${prod[0].productoNombre}',
                                  style: TextStyle(
                                    color: Color(0XFF585858),
                                    fontSize: ScreenUtil().setSp(20),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'S/. ${prod[0].productoPrecio}',
                                  style: TextStyle(
                                    color: Color(0XFF585858),
                                    fontSize: ScreenUtil().setSp(30),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(32),
                              ),
                              Text(
                                'Descripción',
                                style: TextStyle(
                                  color: Color(0XFF585858),
                                  fontSize: ScreenUtil().setSp(18),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              Text(
                                '${prod[0].productoDescripcion} ',
                                style: TextStyle(
                                  color: Color(0XFF585858),
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: ScreenUtil().setHeight(100),
                      left: 0,
                      right: 0,
                      child: Container(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Hero(
                              tag: widget.producto.idProducto,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    backgroundColor: Colors.transparent,
                                    builder: (context) {
                                      return GestureDetector(
                                        onTap: () => Navigator.of(context).pop(),
                                        child: Container(
                                          color: Color.fromRGBO(0, 0, 0, 0.001),
                                          child: GestureDetector(
                                            onTap: () {},
                                            child: DraggableScrollableSheet(
                                              initialChildSize: 0.2,
                                              minChildSize: 0.2,
                                              maxChildSize: 0.2,
                                              builder: (_, controller) {
                                                return Container(
                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.only(
                                                      topLeft: const Radius.circular(25.0),
                                                      topRight: const Radius.circular(25.0),
                                                    ),
                                                  ),
                                                  child: Padding(
                                                    padding: EdgeInsets.symmetric(
                                                      horizontal: ScreenUtil().setWidth(24),
                                                    ),
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        SizedBox(
                                                          height: ScreenUtil().setHeight(24),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            getImageGallery(prod[0].idProducto, prod[0].idLinea);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Seleccionar foto',
                                                                style: GoogleFonts.poppins(
                                                                  fontStyle: FontStyle.normal,
                                                                  color: Color(0XFF585858),
                                                                  fontWeight: FontWeight.w400,
                                                                  fontSize: ScreenUtil().setSp(16),
                                                                  letterSpacing: ScreenUtil().setSp(0.016),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Icon(
                                                                Icons.photo_album_outlined,
                                                                color: Color(0XFFFF0036),
                                                                size: ScreenUtil().setHeight(24),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                        SizedBox(
                                                          height: ScreenUtil().setHeight(10),
                                                        ),
                                                        InkWell(
                                                          onTap: () {
                                                            Navigator.pop(context);
                                                            getImageCamera(prod[0].idProducto, prod[0].idLinea);
                                                          },
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                'Tomar foto',
                                                                style: GoogleFonts.poppins(
                                                                  fontStyle: FontStyle.normal,
                                                                  fontWeight: FontWeight.w400,
                                                                  color: Color(0XFF585858),
                                                                  fontSize: ScreenUtil().setSp(16),
                                                                  letterSpacing: ScreenUtil().setSp(0.016),
                                                                ),
                                                              ),
                                                              Spacer(),
                                                              Icon(
                                                                Icons.photo_camera_outlined,
                                                                color: Color(0XFFFF0036),
                                                                size: ScreenUtil().setHeight(24),
                                                              )
                                                            ],
                                                          ),
                                                        ),
                                                        Divider(
                                                          thickness: 1,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                                child: Container(
                                  height: ScreenUtil().setHeight(200),
                                  width: ScreenUtil().setWidth(200),
                                  child: Stack(
                                    children: [
                                      Container(
                                        height: ScreenUtil().setHeight(200),
                                        width: ScreenUtil().setWidth(200),
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
                                          imageUrl: '$apiBaseURL/${prod[0].productoFoto}',
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
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: Container(
                                            height: ScreenUtil().setHeight(30),
                                            width: ScreenUtil().setWidth(30),
                                            child: SvgPicture.asset('assets/food_svg/add_image.svg')),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(24),
                          vertical: ScreenUtil().setWidth(12),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              'Disponible',
                              style: TextStyle(
                                color: Color(0XFF585858),
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Spacer(),
                            Switch.adaptive(
                              value: (prod[0].productoEstado == '1') ? true : false,
                              activeColor: Colors.green,
                              inactiveTrackColor: Colors.green,
                              onChanged: (valor) async {
                                _controller.changeBoton(true);
                                String estado;

                                if (valor) {
                                  estado = '1';
                                } else {
                                  estado = '2';
                                }

                                ProductoLineaModel producto = ProductoLineaModel();
                                producto.idProducto = prod[0].idProducto;
                                producto.idLinea = prod[0].idLinea;
                                producto.productoNombre = prod[0].productoNombre;
                                producto.productoDescripcion = prod[0].productoDescripcion;
                                producto.productoPrecio = prod[0].productoPrecio;
                                producto.productoEstado = estado;

                                final res = await _productoApi.editarProducto(producto);

                                if (res == 1) {
                                  productoBloc.obtenerProductoPorIdProducto(prod[0].idProducto, prod[0].idLinea);
                                  productoBloc.obtenerProductosPorLinea(prod[0].idLinea);
                                }

                                _controller.changeBoton(false);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (_, s) {
                          return (_controller.boton) ? _showLoading() : Container();
                        })
                  ],
                );
              } else {
                return Container();
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
}

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeText(String t) {
    text = t;
    notifyListeners();
  }
}
