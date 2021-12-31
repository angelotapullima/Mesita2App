import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/Pagos/modals_metodo_pago.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/detalle_plan.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class PlanesPage extends StatelessWidget {
  const PlanesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    final planesBloc = ProviderBloc.planes(context);
    planesBloc.obtenerPlanes();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Planes',
          style: GoogleFonts.poppins(
            color: const Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: StreamBuilder(
          stream: planesBloc.planesStream,
          builder: (context, AsyncSnapshot<List<PlanesModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                var planes = snapshot.data;
                return SingleChildScrollView(
                  child: ListView.builder(
                      itemCount: planes.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return planTarjeta(context, planes[index], prefs);
                      }),
                );
              } else {
                return const Center(
                  child: Text('Sin planes disponibles'),
                );
              }
            } else {
              return _showLoading();
            }
          }),
    );
  }

  _showLoading() {
    return Center(
      child: (Platform.isAndroid)
          ? const CircularProgressIndicator(
              color: Color(0XFFFF0036),
            )
          : const CupertinoActivityIndicator(),
    );
  }

  Widget planTarjeta(
    BuildContext context,
    PlanesModel plan,
    Preferences prefs,
  ) {
    Color color1;
    Color color2;

    if (plan.idPlan == '1') {
      color1 = const Color(0XFF3DE8F3).withOpacity(.6);
      color2 = const Color(0XFF00C2FF).withOpacity(.8);
    } else if (plan.idPlan == '2') {
      color1 = const Color(0XFF5782F0).withOpacity(.6);
      color2 = const Color(0XFF0047FF).withOpacity(.8);
    } else {
      color1 = const Color(0XFFB367FF).withOpacity(.6);
      color2 = const Color(0XFF7000FF).withOpacity(.8);
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(16)),
      child: Container(
        height: ScreenUtil().setHeight(250),
        // height: double.infinity,
        // width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          gradient: LinearGradient(
            begin: Alignment.bottomLeft,
            end: Alignment.topRight,
            colors: [
              color1,
              color2,
            ],

            //
          ),
        ),
        child: Column(
          children: [
            (prefs.tipoPlan == plan.idPlan)
                ? Container(
                    height: ScreenUtil().setHeight(40),
                    width: double.infinity,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                      color: Color(0XFFE9FEFB),
                    ),
                    child: Row(
                      children: [
                        SizedBox(
                          width: ScreenUtil().setWidth(16),
                        ),
                        Text(
                          'PLAN ACTUAL',
                          style: GoogleFonts.poppins(
                            color: const Color(0XFF585858),
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                  )
                : Container(),
            const Spacer(),
            Text(
              plan.nombre,
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(24),
                fontWeight: FontWeight.w600,
                letterSpacing: 0.16,
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Row(
              children: [
                SizedBox(
                  width: ScreenUtil().setWidth(24),
                ),
                Icon(
                  Icons.check,
                  color: Colors.white,
                  size: ScreenUtil().setHeight(18),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(8),
                ),
                Text(
                  '${plan.costo} PEN',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: ScreenUtil().setSp(14),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(14),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(5)),
              child: Text(
                plan.descripcion,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(12),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.16,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(14),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                (prefs.tipoPlan == plan.idPlan)
                    ? InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) {
                                return DetallePlanPage(
                                  nombrePlan: plan.nombre,
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
                          padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            'Ver',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.16,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          if (int.parse(prefs.tipoPlan) > int.parse(plan.idPlan)) {
                            showToast('Su plan actual está vigente, con mejores beneficios', Colors.black);
                          } else {
                            modalSeletPayMetod(context, plan, 'Cambiar plan', false, false);
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white),
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Text(
                            'Cambiar plan',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: ScreenUtil().setSp(14),
                              fontWeight: FontWeight.w600,
                              letterSpacing: 0.16,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: ScreenUtil().setWidth(24),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
          ],
        ),
      ),
    );
  }
}
