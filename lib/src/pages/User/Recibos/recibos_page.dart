import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class RecibosPage extends StatelessWidget {
  const RecibosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Recibos',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
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
                Container(
                  child: Text(
                    'FECHA',
                    style: GoogleFonts.poppins(
                      color: Color(0XFF585858),
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'N° DE REFERENCIA',
                    style: GoogleFonts.poppins(
                      color: Color(0XFF585858),
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                Container(
                  child: Text(
                    'IMPORTE',
                    style: GoogleFonts.poppins(
                      color: Color(0XFF585858),
                      fontSize: ScreenUtil().setSp(16),
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.16,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            itemRecibo(),
          ],
        ),
      ),
    );
  }

  Widget itemRecibo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          child: Text(
            '25/10/21',
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
        ),
        Container(
          child: Text(
            '12345678910111213',
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontSize: ScreenUtil().setSp(14),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
        ),
        Container(
          child: Row(
            children: [
              Text(
                'S/ 3.00',
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.16,
                ),
              ),
              Text(
                'VER',
                style: GoogleFonts.poppins(
                  color: Color(0XFFFF0036),
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.16,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
