import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/pages/Busqueda/buscar_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/agregar_pedidos_mesa.dart';

class LlevarPage extends StatelessWidget {
  const LlevarPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFFF0036),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'Llevar',
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
            height: ScreenUtil().setHeight(200),
            child: Stack(
              children: [
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(150),
                    decoration: BoxDecoration(
                      color: Color(0xFFF9708D),
                    ),
                  ),
                ),
                ClipPath(
                  clipper: HeaderFormaClipper(),
                  child: Container(
                    height: ScreenUtil().setHeight(125),
                    decoration: BoxDecoration(
                      color: Color(0XFFFF0036),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Text(
                            'Realice pedidos para llevar desde el local',
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
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (_, index) {
                      return ExpansionTile(
                        onExpansionChanged: (valor) {
                          // _changeData.onChangeValue(false, valor, false, false, false, false, false);
                        },
                        title: Text(
                          'Pedido N° ${index + 1}',
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(16),
                          ),
                        ),
                        iconColor: Color(0XFFFF0036),
                        trailing: Container(
                          margin: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(8)),
                          child: Icon(Icons.keyboard_arrow_down
                              // _changeData.vitales ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                              // color: ColorsApp.blueClinica,
                              ),
                        ),
                        children: [
                          Container(
                            height: ScreenUtil().setHeight(200),
                            child: Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: 20,
                                itemBuilder: (_, index2) {
                                  return Container(
                                      margin: EdgeInsets.symmetric(
                                        horizontal: ScreenUtil().setWidth(24),
                                      ),
                                      child: Text('Pollo con papas'));
                                },
                              ),
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
