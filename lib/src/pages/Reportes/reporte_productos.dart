import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/reporte_producto_model.dart';
import 'package:mesita_aplication_2/src/utils/constants.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class ReporteProductos extends StatelessWidget {
  const ReporteProductos({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reporteBloc = ProviderBloc.reporte(context);
    return Expanded(
      child: StreamBuilder(
          stream: reporteBloc.reporteProductoStream,
          builder: (context, AsyncSnapshot<List<ReporteProductoModel>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.length > 0) {
                var products = snapshot.data;
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (_, index) {
                      return itemFood(products[index]);
                    });
              } else {
                return Center(
                  child: Text('Sin información disponible'),
                );
              }
            } else {
              return showLoading();
            }
          }),
    );
  }

  Widget itemFood(ReporteProductoModel food) {
    return InkWell(
      onTap: () {},
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Container(
              height: ScreenUtil().setHeight(100),
              width: ScreenUtil().setWidth(100),
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
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.center,
                    child: Hero(
                      tag: food.idProducto,
                      child: Container(
                        height: ScreenUtil().setHeight(80),
                        width: ScreenUtil().setWidth(80),
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
                          imageUrl: '$apiBaseURL/${food.fotoProducto}',
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
              width: ScreenUtil().setWidth(12),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${food.nombreProducto}',
                    style: TextStyle(
                      color: Color(0XFF585858),
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Text(
                    'Se vendió ${food.cantidad}',
                    style: TextStyle(
                      color: Color(0XFF3A3A3A),
                      fontSize: ScreenUtil().setSp(14),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  RichText(
                    text: TextSpan(
                      text: 'Equivalente a ',
                      style: TextStyle(
                        color: Color(0XFF3A3A3A),
                        fontSize: ScreenUtil().setSp(14),
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.16,
                      ),
                      children: [
                        TextSpan(
                          text: 'S/${food.suma}',
                          style: TextStyle(
                            color: Color(0XFF3A3A3A),
                            fontSize: ScreenUtil().setSp(16),
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
