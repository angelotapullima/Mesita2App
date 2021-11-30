import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/api/comanda_temporal_api.dart';
import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/agregar_producto_pedido_model.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class AgregarDetalleProducto extends StatefulWidget {
  final ProductoLineaModel producto;
  final String idEnviar;
  final bool esComanda;
  final String idMesa;

  const AgregarDetalleProducto({Key key, @required this.producto, @required this.idEnviar, @required this.esComanda, @required this.idMesa})
      : super(key: key);

  @override
  _AgregarDetalleProductoState createState() => _AgregarDetalleProductoState();
}

class _AgregarDetalleProductoState extends State<AgregarDetalleProducto> {
  final _controller = ChangeController();
  final TextEditingController _observacionesController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.changeCantidadPrecio(0, widget.producto.productoPrecio);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final productoBloc = ProviderBloc.productosLinea(context);
    productoBloc.obtenerProductoPorIdProducto(widget.producto.idProducto, widget.producto.idLinea);
    return Scaffold(
      body: Stack(
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
                        '${widget.producto.productoNombre}',
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
                      child: AnimatedBuilder(
                          animation: _controller,
                          builder: (_, t) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  (_controller.precioMuestra != '') ? 'S/. ${_controller.precioMuestra}' : 'S/. ${widget.producto.productoPrecio}',
                                  style: TextStyle(
                                    color: Color(0XFF585858),
                                    fontSize: ScreenUtil().setSp(30),
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(
                                  width: ScreenUtil().setWidth(16),
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
                                      InkWell(
                                        onTap: () {
                                          _controller.changeCantidadPrecio(-1, widget.producto.productoPrecio);
                                        },
                                        child: Container(
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
                                            '${_controller.cantidad}',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: ScreenUtil().setSp(16),
                                            ),
                                          ),
                                        ),
                                      ),
                                      InkWell(
                                          onTap: () {
                                            _controller.changeCantidadPrecio(1, widget.producto.productoPrecio);
                                          },
                                          child: Container(
                                            child: SvgPicture.asset('assets/food_svg/plus.svg'),
                                          )),
                                    ],
                                  ),
                                ),
                              ],
                            );
                          }),
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
                      '${widget.producto.productoDescripcion} ',
                      style: TextStyle(
                        color: Color(0XFF585858),
                        fontSize: ScreenUtil().setSp(16),
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    Container(
                      height: ScreenUtil().setHeight(130),
                      child: Stack(
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(130),
                            child: TextField(
                              controller: _observacionesController,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Observaciones',
                                labelStyle: GoogleFonts.poppins(
                                    color: Color(0XFF585858),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12),
                                    letterSpacing: 0.16,
                                    fontStyle: FontStyle.normal),
                                // contentPadding: EdgeInsets.only(
                                //     left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(10), bottom: ScreenUtil().setHeight(1)),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Color(0XFFFF0036), width: ScreenUtil().setWidth(2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Color(0XFFFF0036), width: ScreenUtil().setWidth(2)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: Color(0XFFFF0036), width: ScreenUtil().setWidth(2)),
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                  color: Color(0XFF585858),
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                String valueLlevar;
                                if (_controller.llevar) {
                                  valueLlevar = '1';
                                } else {
                                  valueLlevar = '0';
                                }
                                if (widget.esComanda) {
                                  //final _comandaDatabase = PedidosTemporalDatabase();
                                  DetallePedidoTemporalModel comanda = DetallePedidoTemporalModel();

                                  comanda.idMesa = widget.idMesa;
                                  comanda.idProducto = widget.producto.idProducto;
                                  comanda.subtotal = _controller.precioMuestra;
                                  comanda.cantidad = _controller.cantidad.toString();
                                  comanda.estado = '1';
                                  comanda.llevar = valueLlevar;
                                  comanda.observaciones = _observacionesController.text;
                                  comanda.foto = widget.producto.productoFoto;
                                  comanda.nombre = widget.producto.productoNombre;

                                  //await _comandaDatabase.insertarDetallePedidoTemporal(comanda);
                                  final _comandaTemporalApi = ComandaTemporalApi();
                                  final res = await _comandaTemporalApi.guardarDetallePedidoTemporal(comanda);
                                  if (res == 1) {
                                    final comandaBloc = ProviderBloc.comanda(context);
                                    comandaBloc.obtenerComandaPorMesa(widget.idMesa);
                                  }

                                  Navigator.pop(context);
                                  Navigator.pop(context);
                                } else {
                                  _controller.changeBoton(true);
                                  final _pedidosApi = PedidosApi();

                                  DetalleProductoModel detalle = DetalleProductoModel();
                                  detalle.idProducto = widget.producto.idProducto;
                                  detalle.subtotal = _controller.precioMuestra;
                                  detalle.cantidad = _controller.cantidad.toString();
                                  detalle.observaciones = _observacionesController.text;
                                  detalle.llevar = valueLlevar;

                                  final res = await _pedidosApi.agregarDetallePedido(widget.idEnviar, detalle);
                                  if (res) {
                                    final pedidosBloc = ProviderBloc.pedidos(context);
                                    pedidosBloc.obtenerPedidosPorIdMesa(widget.idMesa);
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  }
                                  _controller.changeBoton(false);
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                                height: ScreenUtil().setHeight(56),
                                width: ScreenUtil().setWidth(130),
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
                                    Container(
                                      height: ScreenUtil().setHeight(36),
                                      child: SvgPicture.asset('assets/food_svg/bag.svg'),
                                    ),
                                    Container(
                                      margin: EdgeInsets.symmetric(horizontal: 8),
                                      height: ScreenUtil().setHeight(40),
                                      width: ScreenUtil().setWidth(40),
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
                                        child: AnimatedBuilder(
                                            animation: _controller,
                                            builder: (_, n) {
                                              return Text(
                                                '${_controller.cantidad}',
                                                style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: ScreenUtil().setSp(16),
                                                ),
                                              );
                                            }),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    AnimatedBuilder(
                        animation: _controller,
                        builder: (context, snapshot) {
                          return Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  _controller.changeLlevar(!_controller.llevar);
                                },
                                icon: (_controller.llevar)
                                    ? Icon(
                                        Icons.check_box_outlined,
                                        color: Color(0XFFFF0036),
                                      )
                                    : Icon(
                                        Icons.check_box_outline_blank_outlined,
                                        color: Color(0XFF585858),
                                      ),
                              ),
                              Text(
                                'Para llevar',
                                style: TextStyle(
                                  color: Color(0XFF585858),
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          );
                        }),
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
                    child: Container(
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      child: Container(
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
                          imageUrl: '$apiBaseURL/${widget.producto.productoFoto}',
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
          ),
          AnimatedBuilder(
              animation: _controller,
              builder: (_, s) {
                return (_controller.boton) ? _showLoading() : Container();
              })
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
}

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;

  int cantidad = 1;
  bool llevar = false;

  double precio = 0;
  String precioMuestra = '';
  void changeLlevar(bool l) {
    llevar = l;
    notifyListeners();
  }

  void changeCantidadPrecio(int c, String p) {
    if (c > 0) {
      cantidad = cantidad + c;
    } else {
      if (cantidad > 1) {
        cantidad = cantidad + c;
      }
    }

    var pre = double.parse(p);
    precio = cantidad * pre;

    precioMuestra = precio.toStringAsFixed(2);

    notifyListeners();
  }

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
