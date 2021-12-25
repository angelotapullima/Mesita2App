import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class DetalleRecibo extends StatelessWidget {
  const DetalleRecibo({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Color(0XFF3A3A3A),
        ),
        title: Text(
          'Recibo',
          style: GoogleFonts.poppins(
            color: const Color(0XFF3A3A3A),
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
                height: ScreenUtil().setHeight(16),
              ),
              Center(
                child: Text(
                  'N° 12345678910111213',
                  style: TextStyle(
                    color: const Color(0XFFFF0036),
                    fontSize: ScreenUtil().setSp(18),
                    fontWeight: FontWeight.w500,
                    letterSpacing: 0.16,
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Fecha', '28/10/2021'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Forma de pago', 'Visa (######780)'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Distribuidor', 'Bufeo Tec S.A.C.'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Dirección', 'Urb. Sargento Lores C3'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Producto', 'Premium Semanal'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Impuestos', 'S/ 00.00'),
              SizedBox(
                height: ScreenUtil().setHeight(32),
              ),
              rowData('Total', 'S/ 18.00'),
              SizedBox(
                height: ScreenUtil().setHeight(90),
              ),
              Container(
                margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(24),
                  right: ScreenUtil().setWidth(24),
                  bottom: ScreenUtil().setHeight(4),
                  top: ScreenUtil().setHeight(16),
                ),
                width: double.infinity,
                child: MaterialButton(
                  color: Colors.white,
                  textColor: const Color(0XFF585858),
                  elevation: 1,
                  onPressed: () {},
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                    side: const BorderSide(
                      color: Color(0XFFFF0036),
                    ),
                  ),
                  child: Text(
                    'Descargar pdf',
                    style: GoogleFonts.poppins(
                      color: const Color(0XFFFF0036),
                      fontWeight: FontWeight.w500,
                      fontSize: ScreenUtil().setSp(16),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rowData(String titulo, String data) {
    return Row(
      children: [
        SizedBox(
          width: ScreenUtil().setWidth(150),
          child: Text(
            titulo,
            style: TextStyle(
              color: const Color(0XFF585858),
              fontSize: ScreenUtil().setSp(16),
              fontWeight: FontWeight.w600,
              letterSpacing: 0.16,
            ),
          ),
        ),
        Text(
          data,
          style: TextStyle(
            color: const Color(0XFF585858),
            fontSize: ScreenUtil().setSp(16),
            fontWeight: FontWeight.w400,
            letterSpacing: 0.16,
          ),
        ),
      ],
    );
  }
}
