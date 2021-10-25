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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              Center(
                child: Container(
                  width: ScreenUtil().setWidth(120),
                  height: ScreenUtil().setHeight(140),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(150),
                    child: Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          height: double.infinity,
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
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          child: Container(
                            height: ScreenUtil().setHeight(30),
                            width: ScreenUtil().setWidth(120),
                            decoration: BoxDecoration(
                              color: Colors.black,
                            ),
                            child: Center(
                              child: Text(
                                'a',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: ScreenUtil().setHeight(30),
              ),
              Text(
                'Nombre',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
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
                'Email',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
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
                'Contraseña',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: ScreenUtil().setSp(16),
                ),
              ),
              TextField(
                readOnly: true,
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
              Center(
                  child: MaterialButton(
                onPressed: () {},
                child: Text(
                  'Editar Perfil',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(19),
                    fontWeight: FontWeight.bold,
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
