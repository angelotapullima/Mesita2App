import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/pages/LlevarDelivery/delivery_llevar_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/detalle_mesa_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/modal_agregar_mesa.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';

class MesasPage extends StatelessWidget {
  const MesasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mesasBloc = ProviderBloc.mesas(context);
    mesasBloc.obtenerMesasPorNegocio();
    final prefs = Preferences();

    return Scaffold(
      backgroundColor: const Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0XFFE5E5E5),
        leading: InkWell(
          child: Container(),
        ),
        actions: [
          InkWell(
            onTap: () {
              mesaModal(context);
            },
            child: SizedBox(
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
          'Mesas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: const Color(0xffff0036),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(5),
                ),
                Text(
                  'Ocupado',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(5),
                ),
                Text(
                  'Disponible',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: mesasBloc.mesasStream,
                builder: (BuildContext context, AsyncSnapshot<List<MesaModel>> snapsdhot) {
                  if (snapsdhot.hasData) {
                    if (snapsdhot.data.isNotEmpty) {
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: ScreenUtil().setWidth(10),
                          ),
                          itemCount: snapsdhot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LayoutBuilder(builder: (context, constraints) {
                              if (snapsdhot.data[index].mesaTipo == '1' || snapsdhot.data[index].mesaTipo == '2') {
                                return InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageRouteBuilder(
                                        pageBuilder: (context, animation, secondaryAnimation) {
                                          return DeliveryLlevarPage(
                                            mesa: snapsdhot.data[index],
                                            text: (snapsdhot.data[index].mesaTipo == '1')
                                                ? 'Realice pedidos para llevar desde el local'
                                                : 'Realice pedidos para delivery',
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
                                    padding: EdgeInsets.only(
                                      right: ScreenUtil().setWidth(10),
                                      left: ScreenUtil().setWidth(10),
                                    ),
                                    width: constraints.maxWidth,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width: constraints.maxWidth * 0.12,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              vertical: ScreenUtil().setHeight(10),
                                            ),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              height: constraints.maxHeight * 0.55,
                                              width: constraints.maxWidth * 0.2,
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * 0.05,
                                        ),
                                        Container(
                                          height: constraints.maxHeight - constraints.maxHeight * 0.20,
                                          width: constraints.maxWidth * 0.52,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(5),
                                            gradient: const LinearGradient(
                                              begin: Alignment.bottomLeft,
                                              end: Alignment.topRight,
                                              colors: [
                                                Colors.white,
                                                Colors.white,
                                              ],

                                              //
                                            ),
                                            boxShadow: [
                                              BoxShadow(
                                                offset: const Offset(0, 0),
                                                blurRadius: 20.0,
                                                color: const Color(0xff585858).withOpacity(.15),
                                              ),
                                            ],
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: ScreenUtil().setWidth(10),
                                            ),
                                            child: Center(
                                              child: Text(
                                                snapsdhot.data[index].mesaNombre,
                                                style: TextStyle(
                                                  fontSize: ScreenUtil().setSp(18),
                                                  color: const Color(0xfff9708d),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * 0.05,
                                        ),
                                        SizedBox(
                                          width: constraints.maxWidth * 0.12,
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                //color: (snapsdhot.data[index].mesaEstado != '2') ? Colors.white : Color(0xffff0036),
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(5),
                                              ),
                                              height: constraints.maxHeight * 0.55,
                                              width: constraints.maxWidth * 0.2,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }

                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) {
                                        return DetalleMesaPage(
                                          mesa: snapsdhot.data[index],
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
                                  // if (snapsdhot.data[index].mesaEstado == '2') {
                                  //   Navigator.push(
                                  //     context,
                                  //     PageRouteBuilder(
                                  //       pageBuilder: (context, animation, secondaryAnimation) {
                                  //         return DetalleMesaPage(
                                  //           mesa: snapsdhot.data[index],
                                  //         );
                                  //       },
                                  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  //         var begin = Offset(0.0, 1.0);
                                  //         var end = Offset.zero;
                                  //         var curve = Curves.ease;

                                  //         var tween = Tween(begin: begin, end: end).chain(
                                  //           CurveTween(curve: curve),
                                  //         );

                                  //         return SlideTransition(
                                  //           position: animation.drive(tween),
                                  //           child: child,
                                  //         );
                                  //       },
                                  //     ),
                                  //   );
                                  // } else {
                                  //   Navigator.push(
                                  //     context,
                                  //     PageRouteBuilder(
                                  //       pageBuilder: (context, animation, secondaryAnimation) {
                                  //         return AgregarePedidoMesa(
                                  //           mesa: snapsdhot.data[index],
                                  //         );
                                  //       },
                                  //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                  //         var begin = Offset(0.0, 1.0);
                                  //         var end = Offset.zero;
                                  //         var curve = Curves.ease;

                                  //         var tween = Tween(begin: begin, end: end).chain(
                                  //           CurveTween(curve: curve),
                                  //         );

                                  //         return SlideTransition(
                                  //           position: animation.drive(tween),
                                  //           child: child,
                                  //         );
                                  //       },
                                  //     ),
                                  //   );
                                  // }
                                },
                                child: Container(
                                  padding: EdgeInsets.only(
                                    right: ScreenUtil().setWidth(10),
                                    left: ScreenUtil().setWidth(10),
                                  ),
                                  width: constraints.maxWidth,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      SizedBox(
                                        width: constraints.maxWidth * 0.12,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: ScreenUtil().setHeight(10),
                                          ),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: (snapsdhot.data[index].mesaEstado != '2') ? Colors.white : const Color(0xffff0036),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            height: constraints.maxHeight * 0.55,
                                            width: constraints.maxWidth * 0.2,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.05,
                                      ),
                                      Container(
                                        height: constraints.maxHeight - constraints.maxHeight * 0.20,
                                        width: constraints.maxWidth * 0.52,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                          gradient: LinearGradient(
                                            begin: Alignment.bottomLeft,
                                            end: Alignment.topRight,
                                            colors: [
                                              (snapsdhot.data[index].mesaEstado != '2') ? Colors.white : const Color(0xffff6787),
                                              (snapsdhot.data[index].mesaEstado != '2') ? Colors.white : const Color(0xffff0036),
                                            ],

                                            //
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              offset: const Offset(0, 0),
                                              blurRadius: 20.0,
                                              color: (snapsdhot.data[index].mesaEstado != '2')
                                                  ? const Color(0xff585858).withOpacity(.15)
                                                  : const Color(0xffff0036).withOpacity(.3),
                                            ),
                                          ],
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: ScreenUtil().setWidth(10),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    snapsdhot.data[index].mesaNombre,
                                                    style: TextStyle(
                                                      fontSize: ScreenUtil().setSp(40),
                                                      color: (snapsdhot.data[index].mesaEstado != '2') ? const Color(0xfff9708d) : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              Row(
                                                children: [
                                                  const Spacer(),
                                                  Text(
                                                    'cap .${snapsdhot.data[index].mesaCapacidad}',
                                                    style: TextStyle(
                                                      color: (snapsdhot.data[index].mesaEstado != '2') ? const Color(0xff585858) : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: ScreenUtil().setSp(18),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.05,
                                      ),
                                      SizedBox(
                                        width: constraints.maxWidth * 0.12,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: (snapsdhot.data[index].mesaEstado != '2') ? Colors.white : const Color(0xffff0036),
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                            height: constraints.maxHeight * 0.55,
                                            width: constraints.maxWidth * 0.2,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            });
                          });
                    } else {
                      return const Center(
                        child: Text('Aún no se agregaron mesas'),
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
      ),
    );
  }

  _showLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromRGBO(0, 0, 0, 0.1),
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
