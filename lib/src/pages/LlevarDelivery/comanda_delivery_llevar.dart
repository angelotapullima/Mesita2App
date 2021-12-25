// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/detalle_mesa_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/comanda_mesa_page.dart';

class ComandaDeliveryLlevar extends StatelessWidget {
  final MesaModel mesa;
  final String text;
  const ComandaDeliveryLlevar({Key key, @required this.mesa, this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: const Color(0XFFFF0036),
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          mesa.mesaNombre,
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(18),
          ),
        ),
      ),
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
          ),
          Container(
            height: ScreenUtil().setHeight(200),
            child: Stack(
              children: [
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(150),
                    decoration: const BoxDecoration(
                      color: Color(0xFFF9708D),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(125),
                    decoration: const BoxDecoration(
                      color: Color(0XFFFF0036),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            text,
                            style: GoogleFonts.poppins(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: ScreenUtil().setSp(14),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(
              top: ScreenUtil().setHeight(90),
            ),
            child: ComandaPage(
              mesa: mesa,
              esComandaCero: false,
            ),
          ),
        ],
      ),
    );
  }
}
