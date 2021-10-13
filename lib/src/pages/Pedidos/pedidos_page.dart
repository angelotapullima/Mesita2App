import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';

class PedidosPage extends StatelessWidget {
  const PedidosPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFE5E5E5),
        leading: InkWell(
          child: Container(),
        ),
        actions: [
          circleUser(context, prefs),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        title: Text(
          'Pedidos',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: ScreenUtil().setHeight(21),
                  width: ScreenUtil().setWidth(21),
                  child: SvgPicture.asset('assets/food_svg/order_listo.svg'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(8),
                ),
                Text(
                  'Listo',
                  style: GoogleFonts.poppins(
                    color: Color(0XFF585858),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    letterSpacing: 0.16,
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(48),
                ),
                Container(
                  height: ScreenUtil().setHeight(21),
                  width: ScreenUtil().setWidth(21),
                  child: SvgPicture.asset('assets/food_svg/order_pendiente.svg'),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(8),
                ),
                Text(
                  'Cocinando',
                  style: GoogleFonts.poppins(
                    color: Color(0XFF585858),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(14),
                    letterSpacing: 0.16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ScreenUtil().setWidth(120),
                  child: Text(
                    'Mesa',
                    style: GoogleFonts.poppins(
                      color: Color(0XFFD1D1D1),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(85),
                  child: Text(
                    'Producto',
                    style: GoogleFonts.poppins(
                      color: Color(0XFFD1D1D1),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                      letterSpacing: 0.16,
                    ),
                  ),
                ),
                Text(
                  'Cant.',
                  style: GoogleFonts.poppins(
                    color: Color(0XFFD1D1D1),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(16),
                    letterSpacing: 0.16,
                  ),
                ),
                Text(
                  'Estado',
                  style: GoogleFonts.poppins(
                    color: Color(0XFFD1D1D1),
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil().setSp(16),
                    letterSpacing: 0.16,
                  ),
                ),
              ],
            ),
            Divider(
              color: Color(0XFFD1D1D1),
              thickness: 1.5,
            ),
            _datoPedido(),
          ],
        ),
      ),
    );
  }

  Widget _datoPedido() {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenUtil().setWidth(100),
            child: Row(
              children: [
                Text(
                  '1',
                  style: GoogleFonts.poppins(
                    fontSize: ScreenUtil().setSp(40),
                    color: Color(0xfff9708d),
                    fontWeight: FontWeight.bold,
                    letterSpacing: 0.16,
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                Container(
                  height: ScreenUtil().setHeight(60),
                  width: ScreenUtil().setWidth(60),
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
                        child: Container(
                            height: ScreenUtil().setHeight(50),
                            width: ScreenUtil().setWidth(50),
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
                            child: SvgPicture.asset('assets/food_svg/food.svg')),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(78),
            child: Text(
              'Papa a la huancaina',
              style: GoogleFonts.poppins(
                color: Color(0XFF585858),
                fontWeight: FontWeight.w400,
                fontSize: ScreenUtil().setSp(14),
                letterSpacing: 0.16,
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(19),
            child: Text(
              'X1',
              style: GoogleFonts.poppins(
                color: Color(0XFF585858),
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil().setSp(18),
                letterSpacing: 0.16,
              ),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(33),
            width: ScreenUtil().setWidth(28),
            child: SvgPicture.asset('assets/food_svg/order_pendiente.svg'),
          ),
        ],
      ),
    );
  }
}
