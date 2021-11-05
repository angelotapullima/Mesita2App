import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/Pagos/validar_pago_page.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class DetalleReservaPlinYape extends StatefulWidget {
  final int tipoMetodoPago;
  final PlanesModel plan;
  final bool esRenovacion;
  const DetalleReservaPlinYape({Key key, @required this.tipoMetodoPago, @required this.plan, @required this.esRenovacion}) : super(key: key);

  @override
  _DetalleReservaPlinYapeState createState() => _DetalleReservaPlinYapeState();
}

class _DetalleReservaPlinYapeState extends State<DetalleReservaPlinYape> {
  ValueNotifier<bool> _cargando = ValueNotifier(false);
  final TextEditingController _contactoController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prefs = Preferences();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          'Generar pago',
          style: GoogleFonts.poppins(
            color: Color(0XFF585858),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: IconThemeData(color: Color(0XFF585858)),
        elevation: 0,
      ),
      body: ValueListenableBuilder(
          valueListenable: _cargando,
          builder: (BuildContext context, bool data, Widget child) {
            return Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(24),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(30),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white,
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: ScreenUtil().setHeight(24),
                              ),
                              Center(
                                child: Text(
                                  '${prefs.negocioNombre}',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: Color(0XFFFF0036),
                                    fontSize: ScreenUtil().setSp(18),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'Precio del plan  ${widget.plan.nombre}',
                                  style: GoogleFonts.poppins(
                                    color: Color(0XFF585858),
                                    fontWeight: FontWeight.w500,
                                    fontSize: ScreenUtil().setSp(14),
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: '  ',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFF585858),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                                    TextSpan(
                                      text: 'S/${widget.plan.costo}',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFF585858),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(32),
                              ),
                              Text(
                                'Monto a pagar',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFF585858),
                                  fontWeight: FontWeight.w500,
                                  fontSize: ScreenUtil().setSp(14),
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                ),
                              ),
                              RichText(
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  text: 'S/',
                                  style: GoogleFonts.poppins(
                                    color: Color(0XFF00C2FF).withOpacity(0.6),
                                    fontWeight: FontWeight.w600,
                                    fontSize: ScreenUtil().setSp(42),
                                    fontStyle: FontStyle.normal,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                  children: [
                                    TextSpan(
                                      text: ' ',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFF00C2FF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(42),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                                    TextSpan(
                                      text: '${widget.plan.costo}',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFF00C2FF),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(42),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(24),
                              ),
                              (widget.tipoMetodoPago == 3)
                                  ? Container()
                                  : Text(
                                      (widget.tipoMetodoPago == 1) ? 'Yapea el monto indicado' : 'Plinea el monto indicado',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFF585858),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              (widget.tipoMetodoPago == 3)
                                  ? Container()
                                  : Container(
                                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                      padding: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        color: Colors.white,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.black.withOpacity(0.025),
                                            blurRadius: 0.4,
                                            spreadRadius: 1,
                                          ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Container(
                                            height: ScreenUtil().setHeight(60),
                                            width: ScreenUtil().setWidth(60),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              image: DecorationImage(
                                                image: AssetImage((widget.tipoMetodoPago == 1) ? 'assets/img/yape.png' : 'assets/img/plin.png'),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                Text(
                                                  'Bufeo Tec S.A.C.',
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF585858),
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: ScreenUtil().setSp(0.016),
                                                  ),
                                                ),
                                                Text(
                                                  '927663998',
                                                  textAlign: TextAlign.center,
                                                  style: GoogleFonts.poppins(
                                                    color: Color(0XFF585858),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: ScreenUtil().setSp(12),
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: ScreenUtil().setSp(0.016),
                                                  ),
                                                ),
                                                // Text(
                                                //   (widget.tipoMetodoPago == 1) ? '${prefs.nombreYape}' : '${prefs.nombrePlin}',
                                                //   textAlign: TextAlign.center,
                                                //   style: GoogleFonts.poppins(
                                                //     color: NewColors.grayCarnet,
                                                //     fontWeight: FontWeight.w400,
                                                //     fontSize: ScreenUtil().setSp(12),
                                                //     fontStyle: FontStyle.normal,
                                                //     letterSpacing: ScreenUtil().setSp(0.016),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: () {
                                              Clipboard.setData(new ClipboardData(text: '927663998')).then((_) {
                                                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('¡Número copiado!')));
                                              });
                                            },
                                            child: Container(
                                              height: ScreenUtil().setHeight(24),
                                              width: ScreenUtil().setWidth(24),
                                              child: Icon(
                                                Icons.copy,
                                                color: Color(0XFFC4C4C4),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                              SizedBox(
                                height: ScreenUtil().setHeight(24),
                              ),
                              Text(
                                'Realizado por',
                                style: GoogleFonts.poppins(
                                  color: Color(0XFF585858),
                                  fontWeight: FontWeight.w600,
                                  fontSize: ScreenUtil().setSp(16),
                                  fontStyle: FontStyle.normal,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(27)),
                                child: Row(
                                  children: [
                                    Container(
                                      width: ScreenUtil().setWidth(60),
                                      height: ScreenUtil().setHeight(60),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: CachedNetworkImage(
                                          placeholder: (context, url) => Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Image(image: AssetImage('assets/settings_svg/porfile.svg'), fit: BoxFit.cover),
                                          ),
                                          errorWidget: (context, url, error) => Container(
                                            width: double.infinity,
                                            height: double.infinity,
                                            child: Center(
                                              child: SvgPicture.asset(
                                                'assets/settings_svg/porfile.svg',
                                                fit: BoxFit.cover,
                                                width: ScreenUtil().setWidth(300),
                                                height: ScreenUtil().setHeight(300),
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
                                      width: ScreenUtil().setWidth(16),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${prefs.personName} ${prefs.personSurname}',
                                            style: GoogleFonts.poppins(
                                              color: Color(0XFF585858),
                                              fontWeight: FontWeight.w500,
                                              fontSize: ScreenUtil().setSp(14),
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: ScreenUtil().setSp(0.016),
                                            ),
                                          ),
                                          Text(
                                            'Cliente',
                                            style: GoogleFonts.poppins(
                                              color: Color(0XFF00C2FF),
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: ScreenUtil().setSp(0.016),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(16),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(27)),
                                child: Row(
                                  children: [
                                    Container(
                                      height: ScreenUtil().setHeight(25),
                                      width: ScreenUtil().setWidth(25),
                                      margin: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(16)),
                                      child: Icon(
                                        Icons.phone,
                                        size: ScreenUtil().setHeight(40),
                                        color: Color(0XFF00C2FF),
                                      ),
                                    ),
                                    SizedBox(
                                      width: ScreenUtil().setWidth(16),
                                    ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            height: ScreenUtil().setHeight(35),
                                            child: TextField(
                                              controller: _contactoController,
                                              maxLines: 1,
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                suffixIcon: Icon(
                                                  Icons.edit,
                                                  color: Color(0XFFC4C4C4),
                                                ),
                                                hintText: 'Ingresar número',
                                                hintStyle: GoogleFonts.poppins(
                                                    fontSize: ScreenUtil().setSp(14),
                                                    fontWeight: FontWeight.w400,
                                                    letterSpacing: ScreenUtil().setSp(0.016),
                                                    fontStyle: FontStyle.normal),
                                                enabledBorder: InputBorder.none,
                                                focusedBorder: InputBorder.none,
                                                border: InputBorder.none,
                                              ),
                                              style: GoogleFonts.poppins(
                                                fontSize: ScreenUtil().setSp(14),
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: ScreenUtil().setSp(0.016),
                                              ),
                                            ),
                                          ),
                                          Text(
                                            'Número de contacto',
                                            style: GoogleFonts.poppins(
                                              color: Color(0XFF00C2FF),
                                              fontWeight: FontWeight.w400,
                                              fontSize: ScreenUtil().setSp(12),
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: ScreenUtil().setSp(0.016),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: ScreenUtil().setHeight(24),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ScreenUtil().setHeight(40)),
                        InkWell(
                          onTap: () async {
                            if (_contactoController.text.isNotEmpty) {
                              _cargando.value = true;
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                PageRouteBuilder(
                                  transitionDuration: const Duration(milliseconds: 700),
                                  pageBuilder: (context, animation, secondaryAnimation) {
                                    return ValidarPagoPage(
                                      tipoMetodoPago: widget.tipoMetodoPago,
                                      plan: widget.plan,
                                      numContacto: _contactoController.text,
                                      tiempoPlan: (widget.plan.idPlan == '1')
                                          ? 7
                                          : (widget.plan.idPlan == '2')
                                              ? 1
                                              : 3,
                                      esRenovacion: widget.esRenovacion,
                                    );
                                  },
                                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                    return FadeTransition(
                                      opacity: animation,
                                      child: child,
                                    );
                                  },
                                ),
                              );
                              _cargando.value = false;
                            } else {
                              showToast('Por favor ingrese un número de telefono', Colors.red);
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color(0XFFFF0036),
                            ),
                            child: Center(
                              child: Text(
                                'Generar',
                                style: GoogleFonts.poppins(
                                    color: Colors.white, fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(18), fontStyle: FontStyle.normal),
                              ),
                            ),
                            height: ScreenUtil().setHeight(60),
                            width: ScreenUtil().setWidth(327),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                (data)
                    ? Container(
                        height: double.infinity,
                        width: double.infinity,
                        color: Colors.black.withOpacity(.2),
                        child: Center(
                          child: (Platform.isAndroid) ? CircularProgressIndicator() : CupertinoActivityIndicator(),
                        ),
                      )
                    : Container()
              ],
            );
          }),
    );
  }
}
