import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_general_model.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';

class ReporteGeneral extends StatelessWidget {
  const ReporteGeneral({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reporteBloc = ProviderBloc.reporte(context);
    return StreamBuilder(
        stream: reporteBloc.reporteGeneralStream,
        builder: (context, AsyncSnapshot<List<ReporteGeneralModel>> snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data.isNotEmpty) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(30),
                  ),
                  Text(
                    'Total de productos vendidos',
                    style: TextStyle(
                      color: const Color(0XFF585858),
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(16)),
                    width: ScreenUtil().setWidth(120),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          const Color(0XFF0047FF).withOpacity(.8),
                          const Color(0XFF5782F0).withOpacity(.6),
                        ],

                        //
                      ),
                    ),
                    child: Center(
                      child: Text(
                        snapshot.data[0].cantidad,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(40),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  Text(
                    'Equivalente a',
                    style: TextStyle(
                      color: const Color(0XFF585858),
                      fontWeight: FontWeight.w600,
                      fontSize: ScreenUtil().setSp(16),
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(24),
                    margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(16)),
                    width: ScreenUtil().setWidth(250),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15),
                      gradient: LinearGradient(
                        begin: Alignment.bottomLeft,
                        end: Alignment.topRight,
                        colors: [
                          const Color(0XFF7000FF).withOpacity(.8),
                          const Color(0XFFB367FF).withOpacity(.6),
                        ],

                        //
                      ),
                    ),
                    child: Center(
                      child: Text(
                        'S/${snapshot.data[0].sumaTotal}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: ScreenUtil().setSp(40),
                          fontStyle: FontStyle.normal,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Expanded(
                child: Center(
                  child: Text('Sin información disponible'),
                ),
              );
            }
          } else {
            return Expanded(
              child: _showLoading(),
            );
          }
        });
  }

  _showLoading() {
    return Center(
      child: (Platform.isAndroid)
          ? const CircularProgressIndicator(
              color: colorPrimary1,
            )
          : const CupertinoActivityIndicator(),
    );
  }
}
