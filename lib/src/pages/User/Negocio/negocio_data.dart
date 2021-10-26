import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class NegocioData extends StatefulWidget {
  const NegocioData({Key key}) : super(key: key);

  @override
  _NegocioDataState createState() => _NegocioDataState();
}

class _NegocioDataState extends State<NegocioData> {
  TextEditingController _nombreNegocioController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _rucController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final preferences = Preferences();
      _nombreNegocioController.text = preferences.negocioNombre;
      _direccionController.text = preferences.negocioDireccion;
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
            crossAxisAlignment: CrossAxisAlignment.start,
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
                height: ScreenUtil().setHeight(63),
              ),
              Text(
                'Negocio',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
                controller: _nombreNegocioController,
                /* focusNode: _focus1,
                                    controller: _numberTableController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0 && _capacityController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    }, */
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Nombre',
                  hintStyle: TextStyle(
                    color: Color(0XFFBEBEBE),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    fontStyle: FontStyle.normal,
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
                height: ScreenUtil().setHeight(30),
              ),
              Text(
                'R.U.C.',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
                controller: _rucController,
                /* focusNode: _focus1,
                                    controller: _numberTableController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0 && _capacityController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    }, */
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'R.U.C.',
                  hintStyle: TextStyle(
                    color: Color(0XFFBEBEBE),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    fontStyle: FontStyle.normal,
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
                height: ScreenUtil().setHeight(30),
              ),
              Text(
                'Razón social',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
                controller: _rucController,
                /* focusNode: _focus1,
                                    controller: _numberTableController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0 && _capacityController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    }, */
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Razón social',
                  hintStyle: TextStyle(
                    color: Color(0XFFBEBEBE),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    fontStyle: FontStyle.normal,
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
                height: ScreenUtil().setHeight(30),
              ),
              Text(
                'Dirección',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
                controller: _direccionController,
                /* focusNode: _focus1,
                                    controller: _numberTableController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0 && _capacityController.text.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    }, */
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  hintText: 'Dirección',
                  hintStyle: TextStyle(
                    color: Color(0XFFBEBEBE),
                    fontWeight: FontWeight.w400,
                    fontSize: ScreenUtil().setSp(16),
                    fontStyle: FontStyle.normal,
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
                height: ScreenUtil().setHeight(30),
              ),
              Center(
                  child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Editar negocio',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(16),
                    fontWeight: FontWeight.w400,
                  ),
                ),
                textColor: Colors.red,
              ))
            ],
          ),
        ),
      ),
    );
  }
}
