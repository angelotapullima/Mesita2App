import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/circle_user_porfile.dart';

class ReportesPage extends StatelessWidget {
  const ReportesPage({Key key}) : super(key: key);

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
          'Reportes',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
    );
  }
}
