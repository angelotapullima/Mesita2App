import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/pedidos_model.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/delete_detail_pedido.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class EditarDetalleProductoPedido extends StatefulWidget {
  final DetallePedidoModel producto;
  final String idMesa;
  final String tipoMesa;

  const EditarDetalleProductoPedido({
    Key key,
    @required this.producto,
    @required this.idMesa,
    @required this.tipoMesa,
  }) : super(key: key);

  @override
  _EditarDetalleProductoPedidoState createState() => _EditarDetalleProductoPedidoState();
}

class _EditarDetalleProductoPedidoState extends State<EditarDetalleProductoPedido> {
  final _controller = ChangeController();
  final TextEditingController _observacionesController = TextEditingController();
  @override
  void initState() {
    _controller.obtenerPrecioIncial(widget.producto.cantidad, widget.producto.subtotal);
    _observacionesController.text = widget.producto.observaciones;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            height: double.infinity,
            width: double.infinity,
          ),
          SizedBox(
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
                  decoration: const BoxDecoration(
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
          Positioned(
            top: ScreenUtil().setHeight(25),
            right: ScreenUtil().setWidth(10),
            child: SafeArea(
              child: InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      opaque: false,
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return DeleteDetallePedido(
                          pedidoDetalle: widget.producto,
                          idMesa: widget.idMesa,
                          tipoMesa: widget.tipoMesa,
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
                child: Container(
                  height: ScreenUtil().setHeight(45),
                  width: ScreenUtil().setWidth(45),
                  decoration: const BoxDecoration(
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
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(200),
            ),
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
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
                        widget.producto.nombreProducto,
                        style: TextStyle(
                          color: const Color(0XFF585858),
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
                                  (_controller.precioMuestra != '') ? 'S/. ${_controller.precioMuestra}' : 'S/. ${widget.producto.subtotal}',
                                  style: TextStyle(
                                    color: const Color(0XFF585858),
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
                                    color: const Color(0XFFFF0036),
                                    borderRadius: BorderRadius.circular(30),
                                    boxShadow: const [
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
                                          _controller.changeCantidadPrecio(-1);
                                        },
                                        child: SizedBox(
                                          child: SvgPicture.asset('assets/food_svg/minus.svg'),
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.symmetric(horizontal: 8),
                                        height: ScreenUtil().setHeight(22),
                                        width: ScreenUtil().setWidth(22),
                                        decoration: const BoxDecoration(
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
                                            _controller.changeCantidadPrecio(1);
                                          },
                                          child: SizedBox(
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
                    SizedBox(
                      height: ScreenUtil().setHeight(16),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(130),
                      child: Stack(
                        children: [
                          SizedBox(
                            height: ScreenUtil().setHeight(130),
                            child: TextField(
                              controller: _observacionesController,
                              keyboardType: TextInputType.text,
                              maxLines: 4,
                              decoration: InputDecoration(
                                labelText: 'Observaciones',
                                labelStyle: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(12),
                                    letterSpacing: 0.16,
                                    fontStyle: FontStyle.normal),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: const Color(0XFFFF0036), width: ScreenUtil().setWidth(2)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: const Color(0XFFFF0036), width: ScreenUtil().setWidth(2)),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15),
                                  borderSide: BorderSide(color: const Color(0XFFFF0036), width: ScreenUtil().setWidth(2)),
                                ),
                              ),
                              style: GoogleFonts.poppins(
                                  color: const Color(0XFF585858),
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.normal),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: InkWell(
                              onTap: () async {
                                _controller.changeBoton(true);
                                final _pedidosApi = PedidosApi();

                                DetallePedidoModel detalle = DetallePedidoModel();
                                detalle.idPedido = widget.producto.idPedido;
                                detalle.idDetalle = widget.producto.idDetalle;
                                detalle.subtotal = _controller.precioMuestra;
                                detalle.cantidad = _controller.cantidad.toString();
                                detalle.observaciones = _observacionesController.text;
                                detalle.llevar = '0';

                                final res = await _pedidosApi.editarDetallePedido(detalle);
                                if (res) {
                                  final pedidosBloc = ProviderBloc.pedidos(context);
                                  if (widget.tipoMesa == '0') {
                                    pedidosBloc.obtenerPedidosPorIdMesa(widget.idMesa);
                                  } else {
                                    pedidosBloc.obtenerPedidosPorIdMesaParaLlevarYDelivery(widget.idMesa, widget.tipoMesa);
                                  }

                                  Navigator.pop(context);
                                }
                                _controller.changeBoton(false);
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                                height: ScreenUtil().setHeight(56),
                                width: ScreenUtil().setWidth(130),
                                //width: ScreenUtil().setWidth(86),
                                decoration: BoxDecoration(
                                  color: const Color(0XFFFF0036),
                                  borderRadius: BorderRadius.circular(30),
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color.fromRGBO(88, 88, 88, 0.5),
                                    ),
                                  ],
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    SizedBox(
                                      height: ScreenUtil().setHeight(36),
                                      child: SvgPicture.asset('assets/food_svg/bag.svg'),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 8),
                                      height: ScreenUtil().setHeight(40),
                                      width: ScreenUtil().setWidth(40),
                                      decoration: const BoxDecoration(
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
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: widget.producto.idProducto,
                    child: SizedBox(
                      height: ScreenUtil().setHeight(200),
                      width: ScreenUtil().setWidth(200),
                      child: Container(
                        height: ScreenUtil().setHeight(200),
                        width: ScreenUtil().setWidth(200),
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
                          imageUrl: '$apiBaseURL/${widget.producto.fotoProducto}',
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
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator(
                color: Color(0XFFFF0036),
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;

  int cantidad = 1;

  double precio = 0;
  double precioProducto = 0;
  String precioMuestra = '';

  void changeCantidadPrecio(int c) {
    if (c > 0) {
      cantidad = cantidad + c;
    } else {
      if (cantidad > 1) {
        cantidad = cantidad + c;
      }
    }

    precio = cantidad * precioProducto;

    precioMuestra = precio.toStringAsFixed(2);

    notifyListeners();
  }

  void obtenerPrecioIncial(String c, String p) {
    if (c == '1') {
      precioMuestra = p;
      cantidad = 1;
    } else {
      int cant = int.parse(c);
      double pre = double.parse(p);

      precioProducto = pre / cant;
      cantidad = cant;

      precioMuestra = (precioProducto * cantidad).toStringAsFixed(2);
    }

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
