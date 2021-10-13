import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';

class VentasPage extends StatefulWidget {
  const VentasPage({Key key}) : super(key: key);

  @override
  _VentasPageState createState() => _VentasPageState();
}

class _VentasPageState extends State<VentasPage> {
  final _controller = ChangeButtons();
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
          Container(
            padding: EdgeInsets.all(16),
            child: Text(
              'S/00.00',
              style: GoogleFonts.poppins(
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil().setSp(20),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(8),
          ),
          circleUser(context, prefs),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        title: Text(
          'Ventas',
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
                _buttonSelect(_controller, 'Del día', 1),
                _buttonSelect(_controller, 'Historial', 2),
              ],
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: ScreenUtil().setWidth(50),
                  child: Center(
                    child: Text(
                      'N°',
                      style: GoogleFonts.poppins(
                        color: Color(0XFFD1D1D1),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                        letterSpacing: 0.16,
                      ),
                    ),
                  ),
                ),
                Container(
                  width: ScreenUtil().setWidth(90),
                  child: Center(
                    child: Text(
                      'Tipo',
                      style: GoogleFonts.poppins(
                        color: Color(0XFFD1D1D1),
                        fontWeight: FontWeight.w500,
                        fontSize: ScreenUtil().setSp(16),
                        letterSpacing: 0.16,
                      ),
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
            itemVenta(),
          ],
        ),
      ),
    );
  }

  Widget _buttonSelect(ChangeButtons controller, String titulo, int value) {
    return AnimatedBuilder(
        animation: controller,
        builder: (_, s) {
          return InkWell(
            onTap: () {
              controller.changeValue(value);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
              padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8), horizontal: ScreenUtil().setWidth(16)),
              decoration: BoxDecoration(
                color: (controller.value == value) ? Color(0XFFFF0036) : Colors.transparent,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Text(
                titulo,
                style: GoogleFonts.poppins(
                  color: (controller.value == value) ? Colors.white : Color(0XFF585858),
                  fontWeight: FontWeight.w500,
                  fontSize: ScreenUtil().setSp(14),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          );
        });
  }

  Widget itemVenta() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: ScreenUtil().setWidth(50),
            child: Center(
              child: Text(
                '00001',
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          Container(
            width: ScreenUtil().setWidth(90),
            child: Center(
              child: Text(
                'Boleta',
                style: GoogleFonts.poppins(
                  color: Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  letterSpacing: 0.16,
                ),
              ),
            ),
          ),
          Text(
            '150',
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
              letterSpacing: 0.16,
            ),
          ),
          Text(
            'Enviado',
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontWeight: FontWeight.w400,
              fontSize: ScreenUtil().setSp(16),
              letterSpacing: 0.16,
            ),
          ),
        ],
      ),
    );
  }
}

class ChangeButtons extends ChangeNotifier {
  int value = 1;

  void changeValue(int v) {
    value = v;
    notifyListeners();
  }
}
