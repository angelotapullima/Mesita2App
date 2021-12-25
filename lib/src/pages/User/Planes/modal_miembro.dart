import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/api/planes_api.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/miembros_model.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/buscar_usuario_page.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

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

void addMiembroModal(BuildContext context, String idPlan) {
  final _controller = ChangeController();
  final miembroBloc = ProviderBloc.bloc(context);

  //TextEditingController _nombreController = new TextEditingController();

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
                      child: StreamBuilder(
                          stream: miembroBloc.idStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              if (miembroBloc.id == '0') {
                                _controller.changeBoton(false);
                              } else {
                                _controller.changeBoton(true);
                              }
                              return Padding(
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
                                          'Añadir miembro',
                                          style: GoogleFonts.poppins(
                                            color: const Color(0XFFFF0036),
                                            fontWeight: FontWeight.w600,
                                            fontSize: ScreenUtil().setSp(18),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: ScreenUtil().setWidth(24),
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, animation, secondaryAnimation) {
                                                return const BuscarUsuario();
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
                                          decoration: BoxDecoration(
                                            color: const Color(0XFFEDEDED),
                                            borderRadius: BorderRadius.circular(15),
                                          ),
                                          padding: const EdgeInsets.all(8),
                                          child: Row(
                                            children: [
                                              const Icon(
                                                Icons.search,
                                                color: Color(0XFFC4C4C4),
                                              ),
                                              SizedBox(
                                                width: ScreenUtil().setWidth(24),
                                              ),
                                              Text(
                                                miembroBloc.name,
                                                style: GoogleFonts.poppins(
                                                  color: (miembroBloc.id == '0') ? const Color(0XFFC4C4C4) : const Color(0XFF585858),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ScreenUtil().setSp(18),
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: 0.16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      // TextField(
                                      //   controller: _nombreController,
                                      //   maxLines: 1,
                                      //   onChanged: (value) {
                                      //     if (value.length > 0) {
                                      //       _controller.changeBoton(true);
                                      //     } else {
                                      //       _controller.changeBoton(false);
                                      //     }
                                      //   },
                                      //   keyboardType: TextInputType.text,
                                      //   decoration: InputDecoration(
                                      //     hintText: 'Ingresar nombre',
                                      //     hintStyle: TextStyle(
                                      //       color: Color(0XFFBEBEBE),
                                      //       fontWeight: FontWeight.w400,
                                      //       fontSize: ScreenUtil().setSp(16),
                                      //       fontStyle: FontStyle.normal,
                                      //     ),
                                      //     filled: true,
                                      //     fillColor: Color(0XFFEDEDED),
                                      //     contentPadding: EdgeInsets.only(
                                      //         left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                                      //     enabledBorder: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.circular(15),
                                      //       borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      //     ),
                                      //     focusedBorder: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.circular(15),
                                      //       borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      //     ),
                                      //     border: OutlineInputBorder(
                                      //       borderRadius: BorderRadius.circular(15),
                                      //       borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                                      //     ),
                                      //   ),
                                      //   style: TextStyle(
                                      //     color: Color(0XFF585858),
                                      //     fontWeight: FontWeight.w400,
                                      //     fontSize: ScreenUtil().setSp(16),
                                      //     fontStyle: FontStyle.normal,
                                      //   ),
                                      // ),
                                      SizedBox(height: ScreenUtil().setHeight(48)),
                                      InkWell(
                                        onTap: () async {
                                          _controller.changeCargando(true);
                                          _controller.changeText('');
                                          if (_controller.boton) {
                                            final _planApi = PlanesApi();
                                            final res = await _planApi.agregarMiembroAlPlan(idPlan, miembroBloc.id);
                                            if (res == 1) {
                                              final planBloc = ProviderBloc.planes(context);
                                              planBloc.obtenerMiembrosPlan(idPlan);
                                              Navigator.pop(context);
                                            } else if (res == 3) {
                                              _controller.changeText('Ya existe una categoría con ese nombre');
                                            } else {
                                              _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                            }
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
                                                    color: (_controller.boton) ? const Color(0XFFFF0036) : const Color(0XFFFF0036).withOpacity(0.6),
                                                  ),
                                                  child: Center(
                                                    child: Text(
                                                      'Añadir',
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
                                      SizedBox(height: ScreenUtil().setHeight(8)),
                                      Center(
                                        child: AnimatedBuilder(
                                            animation: _controller,
                                            builder: (_, s) {
                                              return Text(
                                                _controller.text,
                                                style: TextStyle(
                                                  color: const Color(0XFFFF0036),
                                                  fontWeight: FontWeight.w600,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontStyle: FontStyle.normal,
                                                  letterSpacing: ScreenUtil().setSp(0.016),
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
                              );
                            } else {
                              miembroBloc.changeId('0');
                              miembroBloc.changeName('Buscar usuario');
                              return _showLoading();
                            }
                          }),
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

void verMiembroModal(BuildContext context, MiembrosModel miembro) {
  final _controller = ChangeController();

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
                                height: ScreenUtil().setWidth(32),
                              ),
                              Center(
                                child: Hero(
                                  tag: miembro.idMiembro,
                                  child: Container(
                                    height: ScreenUtil().setHeight(100),
                                    width: ScreenUtil().setWidth(100),
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
                                        child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
                                      ),
                                      errorWidget: (context, url, error) => SizedBox(
                                        child: SvgPicture.asset(
                                          'assets/settings_svg/porfile.svg',
                                        ),
                                      ),
                                      imageUrl: '$apiBaseURL/${miembro.imagen}',
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
                              SizedBox(
                                height: ScreenUtil().setWidth(24),
                              ),
                              Text(
                                'Nombre',
                                style: GoogleFonts.poppins(
                                  color: const Color(0XFF585858),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: 0.16,
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setWidth(8),
                              ),
                              Container(
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: const Color(0XFFEDEDED),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                padding: const EdgeInsets.all(8),
                                child: Text(
                                  '${miembro.nombre} ${miembro.apellidoPaterno}',
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: 0.16,
                                  ),
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(48)),
                              InkWell(
                                onTap: () async {
                                  _controller.changeCargando(true);
                                  _controller.changeText('');
                                  final _planApi = PlanesApi();
                                  final res = await _planApi.quitarMiembroAlPlan(miembro.idPlan, miembro.idMiembro);
                                  if (res == 1) {
                                    final planBloc = ProviderBloc.planes(context);
                                    planBloc.obtenerMiembrosPlan(miembro.idPlan);
                                    Navigator.pop(context);
                                  } else if (res == 3) {
                                    _controller.changeText('Ya existe una categoría con ese nombre');
                                  } else {
                                    _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                  }

                                  _controller.changeCargando(false);
                                },
                                child: Center(
                                  child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(50),
                                        color: Colors.white,
                                        border: Border.all(
                                          color: const Color(0XFFFF0036),
                                          width: 2,
                                        )),
                                    child: Center(
                                      child: Text(
                                        'Quitar miembro',
                                        style: TextStyle(
                                          color: const Color(0XFFFF0036),
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
                                ),
                              ),
                              SizedBox(height: ScreenUtil().setHeight(8)),
                              Center(
                                child: AnimatedBuilder(
                                    animation: _controller,
                                    builder: (_, s) {
                                      return Text(
                                        _controller.text,
                                        style: TextStyle(
                                          color: const Color(0XFFFF0036),
                                          fontWeight: FontWeight.w600,
                                          fontSize: ScreenUtil().setSp(16),
                                          fontStyle: FontStyle.normal,
                                          letterSpacing: ScreenUtil().setSp(0.016),
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
