import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/pages/User/Negocio/negocio_data.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class MiNegocioPage extends StatefulWidget {
  const MiNegocioPage({Key key}) : super(key: key);

  @override
  _MiNegocioPageState createState() => _MiNegocioPageState();
}

class _MiNegocioPageState extends State<MiNegocioPage> {
  TextEditingController _negocioController = TextEditingController();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final preferences = Preferences();
      _negocioController.text = preferences.negocioNombre;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Mi negocio',
          style: GoogleFonts.poppins(
            color: Color(0XFF3A3A3A),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w600,
            letterSpacing: 0.16,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Center(
                child: Container(
                  height: ScreenUtil().setHeight(80),
                  width: ScreenUtil().setWidth(80),
                  child: SvgPicture.asset('assets/settings_svg/negocio.svg'),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(21),
              ),
              TextField(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) {
                        return NegocioData();
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
                controller: _negocioController,
                readOnly: true,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Negocio',
                  hintStyle: TextStyle(
                    color: Color(0XFFBEBEBE),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    fontStyle: FontStyle.normal,
                  ),
                  suffixIcon: Container(
                    height: ScreenUtil().setHeight(17),
                    width: ScreenUtil().setWidth(17),
                    margin: EdgeInsets.all(12),
                    child: SvgPicture.asset(
                      'assets/settings_svg/edit_negocio.svg',
                    ),
                  ),
                  filled: true,
                  fillColor: Color(0XFFEDEDED),
                  contentPadding: EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide: BorderSide(color: Color(0XFFEDEDED), width: ScreenUtil().setWidth(1)),
                  ),
                ),
                style: TextStyle(
                  color: Color(0XFF585858),
                  fontWeight: FontWeight.w400,
                  fontSize: ScreenUtil().setSp(16),
                  fontStyle: FontStyle.normal,
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              reporteProductos(
                'Comidas',
                'platos',
                'Plato',
                '4500',
                'ceviche',
                Color(0XFFFF6787).withOpacity(.6),
                Color(0XFFFF0036).withOpacity(.8),
                'assets/settings_svg/food_white.svg',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(24),
              ),
              reporteProductos(
                'Bebidas',
                'bebidas',
                'Bebida',
                '800',
                'coca cola',
                Color(0XFFFF6787).withOpacity(.6),
                Color(0XFFFF0036).withOpacity(.8),
                'assets/settings_svg/drink_white.svg',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(24),
              ),
              reporteDocs(
                'Boletas',
                '5000',
                '35',
                Color(0XFFFF6787).withOpacity(.6),
                Color(0XFFFF0036).withOpacity(.8),
                'assets/settings_svg/ticket_white.svg',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(24),
              ),
              reporteDocs(
                'Facturas',
                '5000',
                '35',
                Color(0XFFFF6787).withOpacity(.6),
                Color(0XFFFF0036).withOpacity(.8),
                'assets/settings_svg/ticket_white.svg',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(24),
              ),
              reporteDocs(
                'Notas de venta',
                '5000',
                '35',
                Color(0XFFFF6787).withOpacity(.6),
                Color(0XFFFF0036).withOpacity(.8),
                'assets/settings_svg/ticket_white.svg',
              ),
              SizedBox(
                height: ScreenUtil().setHeight(24),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget reporteProductos(String titulo, String tipo1, String tipo2, String cantidad, String producto, Color color1, Color color2, String imagen) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            color2,
            color1,
          ],

          //
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(18),
          ),
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(21),
              ),
              Container(
                height: ScreenUtil().setHeight(20),
                width: ScreenUtil().setWidth(20),
                child: SvgPicture.asset(imagen),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(8),
              ),
              Text(
                titulo,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          Text(
            'Cantidad de $tipo1 vendidos:',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            cantidad,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            '$tipo2 más consumido:',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            producto,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
        ],
      ),
    );
  }

  Widget reporteDocs(String titulo, String cantidadEmitida, String cantidadAnulada, Color color1, Color color2, String imagen) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        gradient: LinearGradient(
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
          colors: [
            color2,
            color1,
          ],

          //
        ),
      ),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(18),
          ),
          Row(
            children: [
              SizedBox(
                width: ScreenUtil().setWidth(21),
              ),
              Container(
                height: ScreenUtil().setHeight(20),
                width: ScreenUtil().setWidth(20),
                child: SvgPicture.asset(imagen),
              ),
              SizedBox(
                width: ScreenUtil().setWidth(8),
              ),
              Text(
                titulo,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(16),
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.16,
                ),
              ),
            ],
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
          Text(
            'Cantidad de emitidas:',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            cantidadEmitida,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            'Cantidad de anuladas:',
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w400,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(8),
          ),
          Text(
            cantidadAnulada,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w500,
              letterSpacing: 0.16,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(16),
          ),
        ],
      ),
    );
  }
}
