import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mesita_aplication_2/src/pages/User/user_page.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

Widget circleUser(BuildContext context, Preferences prefs) {
  return InkWell(
    onTap: () {
      Navigator.push(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) {
            return const UserPage();
          },
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var begin = const Offset(0.0, 1.0);
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
    child: SizedBox(
      width: ScreenUtil().setWidth(32),
      height: ScreenUtil().setHeight(32),
      child: CachedNetworkImage(
        placeholder: (context, url) => SizedBox(
          child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
        ),
        errorWidget: (context, url, error) => SizedBox(
          child: SvgPicture.asset(
            'assets/settings_svg/porfile.svg',
          ),
        ),
        imageUrl: '${prefs.userImage}',
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white,
              width: 2,
            ),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
      ),
    ),
  );
}
