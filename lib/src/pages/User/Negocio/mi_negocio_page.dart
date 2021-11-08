import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class MiNegocioPage extends StatefulWidget {
  const MiNegocioPage({Key key}) : super(key: key);

  @override
  _MiNegocioPageState createState() => _MiNegocioPageState();
}

class _MiNegocioPageState extends State<MiNegocioPage> {
  TextEditingController _nombreNegocioController = TextEditingController();
  TextEditingController _direccionController = TextEditingController();
  TextEditingController _rucController = TextEditingController();
  TextEditingController _telefonoController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _razonController = TextEditingController();

  final _controller = NegocioController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final preferences = Preferences();
      _nombreNegocioController.text = preferences.negocioNombre;
      _direccionController.text = preferences.negocioDireccion;
      _rucController.text = preferences.negocioRUC;
      _telefonoController.text = preferences.negocioTelefono;
      _razonController.text = preferences.negocioRazonSocial;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller,
        builder: (context, snapshot) {
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
              actions: [
                (_controller.editarActive)
                    ? InkWell(
                        onTap: () {
                          _controller.changeActive(false);
                        },
                        child: Center(
                          child: Text(
                            'Guardar',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          _controller.changeActive(true);
                        },
                        child: Center(
                          child: Text(
                            'Editar',
                            style: GoogleFonts.poppins(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ),
                SizedBox(
                  width: ScreenUtil().setWidth(24),
                ),
              ],
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
                      height: ScreenUtil().setHeight(20),
                    ),
                    Center(
                      child: Container(
                        height: ScreenUtil().setHeight(70),
                        width: ScreenUtil().setWidth(70),
                        child: SvgPicture.asset('assets/settings_svg/negocio.svg'),
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(29),
                    ),
                    Text(
                      'Negocio',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
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
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      height: ScreenUtil().setHeight(24),
                    ),
                    Text(
                      'R.U.C.',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
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
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      height: ScreenUtil().setHeight(24),
                    ),
                    Text(
                      'Razón social',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
                      controller: _razonController,
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
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      height: ScreenUtil().setHeight(24),
                    ),
                    Text(
                      'Domicilio fiscal',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
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
                        hintText: 'Domicilio fiscal',
                        hintStyle: TextStyle(
                          color: Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      'Teléfono de contacto',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
                      controller: _telefonoController,
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
                        hintText: 'Teléfono de contacto',
                        hintStyle: TextStyle(
                          color: Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                      'Email de contacto',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                    ),
                    TextField(
                      readOnly: _controller.enableImput,
                      controller: _emailController,
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
                        hintText: 'Email de contacto',
                        hintStyle: TextStyle(
                          color: Color(0XFFBEBEBE),
                          fontWeight: FontWeight.w400,
                          fontSize: ScreenUtil().setSp(16),
                          fontStyle: FontStyle.normal,
                        ),
                        filled: true,
                        fillColor: Color(0XFFEDEDED),
                        contentPadding:
                            EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                  ],
                ),
              ),
            ),
          );
        });
  }
}

class NegocioController extends ChangeNotifier {
  bool editarActive = false;
  bool enableImput = true;

  void changeActive(bool a) {
    editarActive = a;
    enableImput = !a;
    notifyListeners();
  }
}
