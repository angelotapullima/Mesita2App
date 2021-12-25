import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_linea_model.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class ReporteCategoria extends StatelessWidget {
  const ReporteCategoria({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reporteBloc = ProviderBloc.reporte(context);
    return Expanded(
      child: StreamBuilder(
          stream: reporteBloc.reporteLineaStream,
          builder: (context, AsyncSnapshot<List<ReporteLineaModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isNotEmpty) {
                var lineas = snapshot.data;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: lineas.length,
                    itemBuilder: (_, index) {
                      return Container(
                        margin: const EdgeInsets.all(8),
                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              lineas[index].nombre,
                              style: TextStyle(
                                color: const Color(0XFF585858),
                                fontWeight: FontWeight.w600,
                                fontSize: ScreenUtil().setSp(16),
                                fontStyle: FontStyle.normal,
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  'Total productos vendidos',
                                  style: TextStyle(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  lineas[index].cantidad,
                                  style: TextStyle(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  'Equivalente a',
                                  style: TextStyle(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w400,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                                const Spacer(),
                                Text(
                                  'S/${lineas[index].suma}',
                                  style: TextStyle(
                                    color: const Color(0XFF585858),
                                    fontWeight: FontWeight.w700,
                                    fontSize: ScreenUtil().setSp(16),
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    });
              } else {
                return const Center(
                  child: Text('Sin información disponible'),
                );
              }
            } else {
              return showLoading();
            }
          }),
    );
  }
}
