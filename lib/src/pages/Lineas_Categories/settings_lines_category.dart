import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/pages/Lineas_Categories/delete_line.dart';
import 'package:mesita_aplication_2/src/pages/Lineas_Categories/modal_edit_line.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';

class SettingsLinesCategory extends StatelessWidget {
  final String idCategoria;
  const SettingsLinesCategory({Key key, @required this.idCategoria}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final lineasBloc = ProviderBloc.lineas(context);
    lineasBloc.obtenerLineasPorNegocio(idCategoria);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Color(0XFF585858)),
        title: Text(
          'Categorías',
          style: GoogleFonts.poppins(
            color: colorPrimary1,
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder(
        stream: lineasBloc.lineasStream,
        builder: (context, AsyncSnapshot<List<LineaModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(24), vertical: ScreenUtil().setHeight(16)),
                itemCount: snapshot.data.length,
                shrinkWrap: true,
                itemBuilder: (context, index2) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            snapshot.data[index2].lineaNombre,
                            style: GoogleFonts.poppins(
                              color: const Color(0XFF585858),
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(16),
                              letterSpacing: ScreenUtil().setSp(0.016),
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: () {
                              editLineModal(context, snapshot.data[index2]);
                            },
                            child: SizedBox(
                              height: ScreenUtil().setHeight(20),
                              width: ScreenUtil().setWidth(20),
                              child: SvgPicture.asset('assets/food_svg/edit_category.svg'),
                            ),
                          ),
                          SizedBox(
                            width: ScreenUtil().setWidth(18),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  opaque: false,
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return DeleteLine(
                                      lineaData: snapshot.data[index2],
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
                            child: SizedBox(
                              height: ScreenUtil().setHeight(24),
                              width: ScreenUtil().setWidth(24),
                              child: SvgPicture.asset('assets/food_svg/delete_category.svg'),
                            ),
                          ),
                        ],
                      ),
                      const Divider(),
                    ],
                  );
                },
              );
            } else {
              return Container();
            }
          } else {
            return _showLoading();
          }
        },
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
                color: colorPrimary1,
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}
