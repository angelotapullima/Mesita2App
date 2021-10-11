import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class BuscarPage extends StatelessWidget {
  const BuscarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      body: Column(
        children: [
          Container(
            height: ScreenUtil().setHeight(158),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: ScreenUtil().setHeight(144),
                    width: ScreenUtil().setWidth(359),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9708D),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(35),
                        bottomRight: Radius.circular(35),
                      ),
                    ),
                  ),
                ),
                Container(
                  height: ScreenUtil().setHeight(144),
                  decoration: BoxDecoration(
                    color: Color(0XFFFF0036),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(35),
                      bottomRight: Radius.circular(35),
                    ),
                  ),
                  child: SafeArea(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(44),
                          margin: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setHeight(24),
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: ScreenUtil().setHeight(19),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(22),
                          ),
                          child: Row(
                            children: [
                              Icon(Icons.search),
                              SizedBox(
                                width: ScreenUtil().setHeight(13),
                              ),
                              Text(
                                'Buscar comidas y bebidas',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFFA8A7A7),
                                  fontWeight: FontWeight.w400,
                                  fontSize: ScreenUtil().setSp(16),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(33),
                          width: ScreenUtil().setWidth(33),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(0XFFC4C4C4),
                          ),
                          child: Icon(
                            Icons.close_rounded,
                            color: Colors.white,
                            size: ScreenUtil().setWidth(20),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
