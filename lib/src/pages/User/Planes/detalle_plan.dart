import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/miembros_model.dart';
import 'package:mesita_aplication_2/src/models/plan_user_model.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/modal_miembro.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';

class DetallePlanPage extends StatelessWidget {
  final String nombrePlan;
  const DetallePlanPage({Key key, @required this.nombrePlan}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final planBloc = ProviderBloc.planes(context);
    planBloc.obtenerPlanUser();
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFE5E5E5),
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Plan $nombrePlan',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: StreamBuilder(
        stream: planBloc.planUserStream,
        builder: (context, AsyncSnapshot<List<PlanUserModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.length > 0) {
              planBloc.obtenerMiembrosPlan(snapshot.data[0].idUserPlan);
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24)),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Miembros del plan',
                          style: GoogleFonts.poppins(
                            color: Color(0XFF3A3A3A),
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.16,
                          ),
                        ),
                        Expanded(
                          child: StreamBuilder(
                            stream: planBloc.miembrosPlanStream,
                            builder: (context, AsyncSnapshot<List<MiembrosModel>> snapshot2) {
                              if (snapshot2.hasData) {
                                if (snapshot2.data.length > 0) {
                                  var miembros = snapshot2.data;
                                  return ListView.builder(
                                      itemCount: miembros.length,
                                      itemBuilder: (context, index) {
                                        return _itemMiembro(context, miembros[index]);
                                      });
                                } else {
                                  return Center(
                                    child: Text('Sin miembros'),
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
                    Positioned(
                      bottom: 2,
                      left: 0,
                      right: 0,
                      child: Container(
                        margin: EdgeInsets.symmetric(),
                        width: double.infinity,
                        child: MaterialButton(
                          color: Color(0XFFFF0036),
                          textColor: Colors.white,
                          elevation: 1,
                          onPressed: () {
                            addMiembroModal(context, snapshot.data[0].idUserPlan);
                          },
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          child: Text(
                            'Añadir miembro',
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            } else {
              return Center(
                child: Text('No existe información'),
              );
            }
          } else {
            return _showLoading();
          }
        },
      ),
    );
  }

  Widget _itemMiembro(BuildContext context, MiembrosModel miembro) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(32)),
        child: Row(
          children: [
            Hero(
              tag: miembro.idMiembro,
              child: Container(
                height: ScreenUtil().setHeight(60),
                width: ScreenUtil().setWidth(60),
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
                    child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
                  ),
                  errorWidget: (context, url, error) => Container(
                    child: Container(
                      child: SvgPicture.asset(
                        'assets/settings_svg/porfile.svg',
                      ),
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
            SizedBox(
              width: ScreenUtil().setWidth(16),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${miembro.nombre} ${miembro.apellidoPaterno}',
                  style: GoogleFonts.poppins(
                    color: Color(0XFF3A3A3A),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(12),
                ),
                Text(
                  '${miembro.puesto}',
                  style: GoogleFonts.poppins(
                    color: Color(0XFF868686),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }

  _showLoading() {
    return Center(
      child: (Platform.isAndroid)
          ? CircularProgressIndicator(
              color: Color(0XFFFF0036),
            )
          : CupertinoActivityIndicator(),
    );
  }
}
