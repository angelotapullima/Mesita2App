import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class CuentaPage extends StatelessWidget {
  const CuentaPage({Key key}) : super(key: key);

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
          'Cuenta',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Center(
              child: Container(
                width: ScreenUtil().setWidth(100),
                height: ScreenUtil().setHeight(100),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Container(
                      width: ScreenUtil().setWidth(100),
                      height: ScreenUtil().setHeight(100),
                      child: CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
                        ),
                        errorWidget: (context, url, error) => Container(
                          child: Container(
                            child: SvgPicture.asset(
                              'assets/settings_svg/porfile.svg',
                            ),
                          ),
                        ),
                        imageUrl: '${prefs.userImage}',
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
                    Positioned(
                      bottom: -10,
                      child: Container(
                        height: ScreenUtil().setHeight(40),
                        width: ScreenUtil().setWidth(100),
                        decoration: BoxDecoration(
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
