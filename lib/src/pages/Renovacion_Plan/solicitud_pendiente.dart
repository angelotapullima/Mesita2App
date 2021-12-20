import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SolicitudPendiente extends StatelessWidget {
  const SolicitudPendiente({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(24),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(150),
                  width: ScreenUtil().setWidth(150),
                  child: SvgPicture.asset('assets/food_svg/order_pendiente.svg'),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              Text(
                'Solicitud pendiente de aprobación',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w500,
                  letterSpacing: ScreenUtil().setSp(0.016),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(8),
              ),
              Text(
                'Por favor espere mientras actualizamos los datos de tu plan',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontSize: ScreenUtil().setSp(14),
                  fontWeight: FontWeight.w400,
                  letterSpacing: ScreenUtil().setSp(0.016),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              InkWell(
                onTap: () {
                  Navigator.pushReplacementNamed(context, 'splash');
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: Color(0XFFFF0036),
                  ),
                  child: Center(
                    child: Text(
                      'Volver a cargar',
                      style: GoogleFonts.poppins(
                          color: Colors.white, fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(18), fontStyle: FontStyle.normal),
                    ),
                  ),
                  height: ScreenUtil().setHeight(60),
                  width: ScreenUtil().setWidth(327),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
