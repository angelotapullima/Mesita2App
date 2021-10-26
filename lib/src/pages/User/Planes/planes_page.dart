import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class PlanesPage extends StatelessWidget {
  const PlanesPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Planes',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(24),
              ),
              planTarjeta('Premium diario', 'cobro por 3.00 PEN', Color(0XFF3DE8F3).withOpacity(.6), Color(0XFF00C2FF).withOpacity(.8), prefs, '3'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              planTarjeta('Premium semanal', 'cobro por 18.00 PEN', Color(0XFF5782F0).withOpacity(.6), Color(0XFF0047FF).withOpacity(.8), prefs, '2'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              planTarjeta('Premium mensual', 'cobro por 60.00 PEN', Color(0XFFB367FF).withOpacity(.6), Color(0XFF7000FF).withOpacity(.8), prefs, '1'),
            ],
          ),
        ),
      ),
    );
  }

  Widget planTarjeta(String titulo, String costo, Color color1, Color color2, Preferences prefs, String tipo) {
    return Container(
      height: ScreenUtil().setHeight(200),
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
          (prefs.tipoPlan == tipo)
              ? Container(
                  height: ScreenUtil().setHeight(40),
                  width: double.infinity,
                  decoration: BoxDecoration(
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
                          color: Color(0XFF585858),
                          fontSize: ScreenUtil().setSp(16),
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.16,
                        ),
                      ),
                    ],
                  ),
                )
              : Container(),
          Spacer(),
          Text(
            titulo,
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
                costo,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              (prefs.tipoPlan == tipo)
                  ? InkWell(
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
                      child: Container(
                        padding: EdgeInsets.all(8),
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
    );
  }
}
