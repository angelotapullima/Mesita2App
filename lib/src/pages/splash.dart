import 'package:after_layout/after_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesita_aplication_2/src/api/categoria_api.dart';
import 'package:mesita_aplication_2/src/api/linea_api.dart';
import 'package:mesita_aplication_2/src/api/mesa_api.dart';
import 'package:mesita_aplication_2/src/pages/Comidas/comidas_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/detalle_mesa_page.dart';
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
          /* final bottomBloc = ProviderBloc.bottomNavic(context);
        bottomBloc.changePage(0); */
          //Navigator.pushReplacementNamed(context, 'home');
          Navigator.pushReplacementNamed(context, 'login');
          //Navigator.pushReplacementNamed(context, preferences.pageInit);

        } else {
          final api1 = MesaApi();
          await api1.obtenerMesasPorNegocio();
          final api2 = CategoriaApi();
          await api2.obtenerCategorias();
          final api3 = LineaApi();
          await api3.obtenerLineasPorNegocio();
          Navigator.pushReplacementNamed(context, 'home');

          /* Navigator.push(
            context,
            PageRouteBuilder(
              pageBuilder: (context, animation, secondaryAnimation) {
                return ComidasPage();
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
          ); */
          // Navigator.pushReplacementNamed(context, 'login');
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
