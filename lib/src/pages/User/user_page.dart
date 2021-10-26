import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/pages/User/Negocio/mi_negocio_page.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/planes_page.dart';
import 'package:mesita_aplication_2/src/pages/User/Recibos/recibos_page.dart';
import 'package:mesita_aplication_2/src/pages/User/cuenta_page.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key key}) : super(key: key);

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
          'Configuración',
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
            ),
            SizedBox(
              height: ScreenUtil().setHeight(16),
            ),
            Center(
              child: Text(
                '${obtenerPrimerNombre(prefs.personName)} ${prefs.personApellidoPaterno}',
                style: GoogleFonts.poppins(
                  color: Color(0XFF3A3A3A),
                  fontSize: ScreenUtil().setSp(18),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return CuentaPage();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
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
                child: _itemsConfig('user', 'Cuenta')),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return MiNegocioPage();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
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
                child: _itemsConfig('business', 'Mi negocio')),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return PlanesPage();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
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
                child: _itemsConfig('plan', 'Planes')),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return RecibosPage();
                      },
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        var begin = Offset(0.0, 1.0);
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
                child: _itemsConfig('archive', 'Recibos')),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('file', 'Términos de uso'),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('policies', 'Políticas de privacidad'),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('help', 'Ayuda'),
            SizedBox(
              height: ScreenUtil().setHeight(32),
            ),
            _itemsConfig('version', 'v.1.0.0'),
            SizedBox(
              height: ScreenUtil().setHeight(46),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(75)),
              padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(50), vertical: ScreenUtil().setHeight(10)),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(22),
                color: Color(0XFFFF0036),
              ),
              child: Text(
                'Cerrar sesión',
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _itemsConfig(String icon, String name) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(32)),
      child: Row(
        children: [
          Container(
            height: ScreenUtil().setHeight(24),
            width: ScreenUtil().setWidth(24),
            child: SvgPicture.asset('assets/settings_svg/$icon.svg'),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(16),
          ),
          Text(
            name,
            style: GoogleFonts.poppins(
              color: Color(0XFF585858),
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          Spacer(),
          Icon(
            Icons.arrow_forward_ios,
            color: Color(0XFF585858),
            size: ScreenUtil().setHeight(16),
          )
        ],
      ),
    );
  }
}
