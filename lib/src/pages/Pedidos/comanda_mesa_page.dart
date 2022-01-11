import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/comanda_temporal_api.dart';
import 'package:mesita_aplication_2/src/api/pedidos_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/models/pedido_temporal_model.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/agregar_producto_page.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class ComandaPage extends StatefulWidget {
  final MesaModel mesa;
  final bool esComandaCero;
  const ComandaPage({Key key, @required this.mesa, @required this.esComandaCero}) : super(key: key);

  @override
  _ComandaPageState createState() => _ComandaPageState();
}

class _ComandaPageState extends State<ComandaPage> {
  final _controller = ComandaController();
  final TextEditingController _nombre = TextEditingController();
  final TextEditingController _direccion = TextEditingController();
  final TextEditingController _telefono = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final comandaBloc = ProviderBloc.comanda(context);
    comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
    return StreamBuilder(
      stream: comandaBloc.comandaStream,
      builder: (context, AsyncSnapshot<List<DetallePedidoTemporalModel>> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.isNotEmpty) {
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
                                  child: Stack(
                                    children: [
                                      Align(
                                        alignment: Alignment.center,
                                        child: Hero(
                                          tag: comanda[index].id,
                                          child: Container(
                                            height: ScreenUtil().setHeight(64),
                                            width: ScreenUtil().setWidth(64),
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
                                SizedBox(
                                  width: ScreenUtil().setWidth(150),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        comanda[index].nombre,
                                        style: GoogleFonts.poppins(
                                          color: const Color(0XFF585858),
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
                                    color: colorPrimary1,
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
                                        onTap: () async {
                                          final _comandaTemporalApi = ComandaTemporalApi();
                                          final res = await _comandaTemporalApi.updateDetalle(comanda[index], -1);
                                          if (res == 1) {
                                            comandaBloc.obtenerComandaPorMesa(widget.mesa.idMesa);
                                          }
                                        },
                                        child: SizedBox(
                                          width: ScreenUtil().setWidth(16),
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
                                            comanda[index].cantidad,
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
                                          child: SizedBox(
                                            width: ScreenUtil().setWidth(16),
                                            child: SvgPicture.asset('assets/food_svg/plus.svg'),
                                          )),
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
                        textColor: const Color(0XFF585858),
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22),
                          side: const BorderSide(
                            color: colorPrimary1,
                          ),
                        ),
                        child: Text(
                          'Agregar pedidos',
                          style: GoogleFonts.poppins(
                            color: colorPrimary1,
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
                        color: colorPrimary1,
                        textColor: Colors.white,
                        elevation: 10,
                        onPressed: () async {
                          _controller.changeCargando(true);
                          final _pedidoApi = PedidosApi();

                          if (widget.mesa.mesaTipo == '0') {
                            final res =
                                await _pedidoApi.enviarComanda(widget.mesa.idMesa, total.toString(), _nombre.text, _direccion.text, _telefono.text);
                            if (res) {
                              final pedidosBloc = ProviderBloc.pedidos(context);
                              pedidosBloc.obtenerPedidosPorIdMesa(widget.mesa.idMesa);
                            }
                          } else {
                            generarComandaDeliveryLlevarModal(
                              context,
                              total.toString(),
                            );
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
                  color: colorPrimary1,
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
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator(
                color: colorPrimary1,
              )
            : const CupertinoActivityIndicator(),
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
                child: const DecoratedBox(
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

  void generarComandaDeliveryLlevarModal(BuildContext context, String total) {
    FocusNode _focus1 = FocusNode();
    FocusNode _focus2 = FocusNode();
    FocusNode _focus3 = FocusNode();

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) {
          return Stack(
            children: [
              Container(
                color: const Color.fromRGBO(0, 0, 0, 0.001),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.93,
                    minChildSize: 0.2,
                    maxChildSize: 0.93,
                    builder: (_, controller) {
                      return Container(
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30),
                          ),
                        ),
                        child: KeyboardActions(
                          config: KeyboardActionsConfig(keyboardSeparatorColor: Colors.white, keyboardBarColor: Colors.white, actions: [
                            KeyboardActionsItem(focusNode: _focus1),
                            KeyboardActionsItem(focusNode: _focus2),
                            KeyboardActionsItem(focusNode: _focus3),
                          ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(24)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setWidth(4),
                                    child: Center(
                                      child: Container(
                                        width: ScreenUtil().setWidth(48),
                                        decoration: const BoxDecoration(
                                          color: Color(0XFFBABABA),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(10),
                                  ),
                                  Center(
                                    child: Text(
                                      'Detalles de entrega',
                                      style: GoogleFonts.poppins(
                                        color: colorPrimary1,
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  TextField(
                                    focusNode: _focus1,
                                    controller: _nombre,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      hintText: 'Ingrese nombre del cliente',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  TextField(
                                    focusNode: _focus2,
                                    controller: _direccion,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      hintText: 'Ingrese direccion',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(10),
                                  ),
                                  TextField(
                                    focusNode: _focus3,
                                    controller: _telefono,
                                    maxLines: 1,
                                    keyboardType: TextInputType.number,
                                    maxLength: 9,
                                    decoration: InputDecoration(
                                      counterText: '',
                                      hintText: 'Ingrese teléfono',
                                      hintStyle: TextStyle(
                                        color: const Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: const Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(color: const Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: const Color(0XFF585858),
                                      fontWeight: FontWeight.w400,
                                      fontSize: ScreenUtil().setSp(16),
                                      fontStyle: FontStyle.normal,
                                    ),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(48)),
                                  InkWell(
                                    onTap: () async {
                                      _controller.changeCargando(true);

                                      if (_nombre.text.isNotEmpty) {
                                        final _pedidoApi = PedidosApi();
                                        final res = await _pedidoApi.enviarComanda(
                                            widget.mesa.idMesa, total.toString(), _nombre.text, _direccion.text, _telefono.text);
                                        if (res) {
                                          final pedidosBloc = ProviderBloc.pedidos(context);
                                          pedidosBloc.obtenerPedidosPorIdMesaParaLlevarYDelivery(widget.mesa.idMesa, widget.mesa.mesaTipo);
                                          Navigator.pop(context);
                                          if (!widget.esComandaCero) {
                                            Navigator.pop(context);
                                          }
                                        }
                                      } else {
                                        showToast('Ingrese los datos solicitados', Colors.black);
                                      }

                                      _controller.changeCargando(false);
                                    },
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: colorPrimary1,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Enviar',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                              ),
                                              height: ScreenUtil().setHeight(44),
                                              width: ScreenUtil().setWidth(255),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: GoogleFonts.poppins(
                                          color: const Color(0XFF8A8A8A),
                                          fontWeight: FontWeight.w500,
                                          fontSize: ScreenUtil().setSp(16),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              AnimatedBuilder(
                  animation: _controller,
                  builder: (_, s) {
                    if (_controller.cargando) {
                      return _showLoading();
                    } else {
                      return Container();
                    }
                  })
            ],
          );
        });
  }
}

class ComandaController extends ChangeNotifier {
  bool cargando = false;
  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }
}
