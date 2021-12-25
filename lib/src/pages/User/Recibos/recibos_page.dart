import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/pages/User/Recibos/detalle_recibo.dart';

class RecibosPage extends StatelessWidget {
  const RecibosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Recibos',
          style: GoogleFonts.poppins(
            color: const Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(20),
        ),
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'FECHA',
                  style: GoogleFonts.poppins(
                    color: const Color(0XFF585858),
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                ),
                Text(
                  'N° DE REFERENCIA',
                  style: GoogleFonts.poppins(
                    color: const Color(0XFF585858),
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                ),
                Text(
                  'IMPORTE',
                  style: GoogleFonts.poppins(
                    color: const Color(0XFF585858),
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            itemRecibo(context),
          ],
        ),
      ),
    );
  }

  Widget itemRecibo(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) {
              return const DetalleRecibo();
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
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            '25/10/21',
            style: GoogleFonts.poppins(
              color: const Color(0XFF585858),
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          Text(
            '12345678910111213',
            style: GoogleFonts.poppins(
              color: const Color(0XFF585858),
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          Row(
            children: [
              Text(
                'S/ 3.00',
                style: GoogleFonts.poppins(
                  color: const Color(0XFF585858),
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.16,
                ),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(8),
              ),
              Text(
                'VER',
                style: GoogleFonts.poppins(
                  color: const Color(0XFFFF0036),
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.16,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
