import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class Splash extends StatefulWidget {
  const Splash({Key key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> with AfterLayoutMixin<Splash> {
  @override
  void afterFirstLayout(BuildContext context) async {}

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        final preferences = Preferences();

        if (preferences.idUser.toString().isEmpty || preferences.idUser == null || preferences.idUser == '0') {
          Navigator.pushReplacementNamed(context, 'login');
        } else {
          Navigator.pushReplacementNamed(context, 'home');
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
          ),
          Center(
            child: SvgPicture.asset('assets/mesita_logo.svg'),
          ),
        ],
      ),
    );
  }
}
