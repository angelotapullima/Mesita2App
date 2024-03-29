import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mesita_aplication_2/src/api/planes_api.dart';
import 'package:mesita_aplication_2/src/models/planes_model.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';
import 'package:mesita_aplication_2/src/utils/utils.dart';

class ValidarPagoPage extends StatefulWidget {
  final int tipoMetodoPago;
  final String numContacto;
  final PlanesModel plan;
  final int tiempoPlan;
  final bool esRenovacion;
  final bool planVencido;
  const ValidarPagoPage(
      {Key key,
      @required this.tipoMetodoPago,
      @required this.plan,
      @required this.numContacto,
      @required this.tiempoPlan,
      @required this.esRenovacion,
      @required this.planVencido})
      : super(key: key);

  @override
  _ValidarPagoPageState createState() => _ValidarPagoPageState();
}

class _ValidarPagoPageState extends State<ValidarPagoPage> {
  final _controller = ChangeController();
  final picker = ImagePicker();
  final TextEditingController _rucController = TextEditingController();
  final TextEditingController _razonSocialController = TextEditingController();
  final TextEditingController _direccionSocialController = TextEditingController();
  Future<void> _cropImage(filePath) async {
    File croppedImage = await ImageCropper.cropImage(
        sourcePath: filePath,
        aspectRatioPresets: Platform.isAndroid
            ? [
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio16x9
              ]
            : [
                CropAspectRatioPreset.original,
                CropAspectRatioPreset.square,
                CropAspectRatioPreset.ratio3x2,
                CropAspectRatioPreset.ratio4x3,
                CropAspectRatioPreset.ratio5x3,
                CropAspectRatioPreset.ratio5x4,
                CropAspectRatioPreset.ratio7x5,
                CropAspectRatioPreset.ratio16x9
              ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cortar Imagen',
            toolbarColor: Colors.green,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            showCropGrid: true,
            lockAspectRatio: false),
        iosUiSettings: const IOSUiSettings(minimumAspectRatio: 1.0, title: 'Cortar Imagen'));
    if (croppedImage != null) {
      _controller.changeImage(croppedImage);
      if (_controller.tipoDoc == '03') {
        _controller.changeBoton(true);
      } else if (_controller.tipoDoc == '01' &&
          _rucController.text.length > 10 &&
          _razonSocialController.text.isNotEmpty &&
          _direccionSocialController.text.isNotEmpty) {
        _controller.changeBoton(true);
      } else {
        _controller.changeBoton(false);
      }
    }
  }

  Future getImageCamera() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera, imageQuality: 70);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
  }

  Future getImageGallery() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery, imageQuality: 70);

    if (pickedFile != null) {
      _cropImage(pickedFile.path);
    }
    /**/
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
          'Validar pago',
          style: GoogleFonts.poppins(
            color: const Color(0XFF585858),
            fontSize: ScreenUtil().setSp(18),
            fontWeight: FontWeight.w700,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0XFF585858)),
        elevation: 0,
      ),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(24),
              ),
              child: Column(
                children: [
                  // SizedBox(
                  //   height: ScreenUtil().setHeight(30),
                  // ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: const Color(0XFFF7F7F7),
                    ),
                    child: Column(
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        (widget.tipoMetodoPago == 3)
                            ? Container()
                            : Center(
                                child: Text(
                                  (widget.tipoMetodoPago == 1) ? 'Adjunta captura del yape' : 'Adjunta captura del plin',
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.poppins(
                                    color: const Color(0XFF585858),
                                    fontSize: ScreenUtil().setSp(16),
                                    fontWeight: FontWeight.w600,
                                    letterSpacing: ScreenUtil().setSp(0.016),
                                  ),
                                ),
                              ),
                        SizedBox(
                          height: ScreenUtil().setHeight(16),
                        ),
                        (widget.tipoMetodoPago == 3)
                            ? Container()
                            : AnimatedBuilder(
                                animation: _controller,
                                builder: (_, f) {
                                  return SizedBox(
                                    width: ScreenUtil().setWidth(215),
                                    height: ScreenUtil().setHeight(210),
                                    child: (_controller.image != null)
                                        ? InkWell(
                                            onTap: () {
                                              getImageGallery();
                                            },
                                            child: SizedBox(
                                              child: Image.file(_controller.image),
                                            ),
                                          )
                                        : Center(
                                            child: InkWell(
                                              onTap: () {
                                                getImageGallery();
                                              },
                                              child: Container(
                                                width: ScreenUtil().setWidth(170),
                                                height: ScreenUtil().setHeight(143),
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.black.withOpacity(0.025),
                                                      blurRadius: 0.4,
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: ScreenUtil().setWidth(120),
                                                      height: ScreenUtil().setHeight(103),
                                                      child: Icon(
                                                        Icons.file_copy,
                                                        size: ScreenUtil().setHeight(50),
                                                        color: const Color(0XFF00C2FF),
                                                      ),
                                                    ),
                                                    Text(
                                                      'Subir imagen',
                                                      style: GoogleFonts.poppins(
                                                        color: const Color(0XFF585858),
                                                        fontWeight: FontWeight.w500,
                                                        fontSize: ScreenUtil().setSp(16),
                                                        fontStyle: FontStyle.normal,
                                                        letterSpacing: ScreenUtil().setSp(0.016),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                  );
                                }),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Text(
                          'Realizado por',
                          style: GoogleFonts.poppins(
                            color: const Color(0XFF585858),
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
                              SizedBox(
                                width: ScreenUtil().setWidth(60),
                                height: ScreenUtil().setHeight(60),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: CachedNetworkImage(
                                    placeholder: (context, url) => const SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Image(image: AssetImage('assets/img/loading.gif'), fit: BoxFit.cover),
                                    ),
                                    errorWidget: (context, url, error) => SizedBox(
                                      width: double.infinity,
                                      height: double.infinity,
                                      child: Center(
                                        child: SvgPicture.asset(
                                          'assets/info/userPicture.svg',
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
                                        color: const Color(0XFF585858),
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                                    Text(
                                      'Cliente',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF00C2FF),
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
                                  size: ScreenUtil().setHeight(25),
                                  color: const Color(0XFF00C2FF),
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
                                      widget.numContacto,
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF585858),
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                                    Text(
                                      'Número de contacto',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF00C2FF),
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
                                  Icons.calendar_today,
                                  size: ScreenUtil().setHeight(25),
                                  color: const Color(0XFF00C2FF),
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
                                      '${obtenerFechaActual()}',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF585858),
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                                    Text(
                                      'Inicio de suscripción',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF00C2FF),
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
                                  Icons.calendar_today,
                                  size: ScreenUtil().setHeight(25),
                                  color: const Color(0XFF00C2FF),
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
                                      '${obtenerFechaFinSuscripcion(widget.tiempoPlan)}',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF585858),
                                        fontWeight: FontWeight.w500,
                                        fontSize: ScreenUtil().setSp(14),
                                        fontStyle: FontStyle.normal,
                                        letterSpacing: ScreenUtil().setSp(0.016),
                                      ),
                                    ),
                                    Text(
                                      'Fin de suscripción',
                                      style: GoogleFonts.poppins(
                                        color: const Color(0XFF00C2FF),
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
                  SizedBox(
                    height: ScreenUtil().setHeight(16),
                  ),
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (_, t) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () async {
                                _controller.changeDoc('03');
                                _rucController.text = '';
                                if (widget.tipoMetodoPago == 3) {
                                  _controller.changeBoton(true);
                                } else {
                                  if (_controller.image != null && _controller.tipoDoc == '03') {
                                    _controller.changeBoton(true);
                                  } else {
                                    _controller.changeBoton(false);
                                  }
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (_controller.tipoDoc == '03') ? colorPrimary1 : const Color(0XFFf7f7f7),
                                      border: Border.all(
                                        color: const Color(0XFFF7F7F7),
                                        width: ScreenUtil().setWidth(4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(10),
                                  ),
                                  Text(
                                    'Boleta',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0XFF585858),
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: ScreenUtil().setSp(0.016),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: ScreenUtil().setWidth(60),
                            ),
                            InkWell(
                              onTap: () {
                                _controller.changeDoc('01');
                                if (_controller.image != null &&
                                    _controller.tipoDoc == '01' &&
                                    _rucController.text.length > 10 &&
                                    _razonSocialController.text.isNotEmpty &&
                                    _direccionSocialController.text.isNotEmpty) {
                                  _controller.changeBoton(true);
                                } else {
                                  _controller.changeBoton(false);
                                }
                              },
                              child: Row(
                                children: [
                                  Container(
                                    height: ScreenUtil().setHeight(20),
                                    width: ScreenUtil().setWidth(20),
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: (_controller.tipoDoc == '01') ? colorPrimary1 : const Color(0XFFF7F7F7),
                                      border: Border.all(
                                        color: const Color(0XFFF7F7F7),
                                        width: ScreenUtil().setWidth(4),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: ScreenUtil().setWidth(10),
                                  ),
                                  Text(
                                    'Factura',
                                    style: GoogleFonts.poppins(
                                      color: const Color(0XFF585858),
                                      fontSize: ScreenUtil().setSp(14),
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: ScreenUtil().setSp(0.016),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      }),
                  SizedBox(height: ScreenUtil().setHeight(8)),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, g) {
                      if (_controller.mostrarTextField) {
                        return Column(
                          children: [
                            TextFormField(
                              onChanged: (value) {
                                if (_controller.image != null &&
                                    _controller.tipoDoc == '01' &&
                                    value.length > 10 &&
                                    _razonSocialController.text.isNotEmpty &&
                                    _direccionSocialController.text.isNotEmpty) {
                                  _controller.changeBoton(true);
                                } else {
                                  _controller.changeBoton(false);
                                }
                              },
                              controller: _rucController,
                              maxLength: 11,
                              keyboardType: TextInputType.number,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: colorPrimary1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: colorPrimary1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: 'Ingrese RUC',
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color(0XFFA8A8A8),
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(8),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                if (_controller.image != null &&
                                    _controller.tipoDoc == '01' &&
                                    value.isNotEmpty &&
                                    _rucController.text.length > 10 &&
                                    _direccionSocialController.text.isNotEmpty) {
                                  _controller.changeBoton(true);
                                } else {
                                  _controller.changeBoton(false);
                                }
                              },
                              controller: _razonSocialController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: colorPrimary1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: colorPrimary1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: 'Ingrese razón social',
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color(0XFFA8A8A8),
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                            SizedBox(
                              height: ScreenUtil().setHeight(8),
                            ),
                            TextFormField(
                              onChanged: (value) {
                                if (_controller.image != null &&
                                    _controller.tipoDoc == '01' &&
                                    value.isNotEmpty &&
                                    _rucController.text.length > 10 &&
                                    _razonSocialController.text.isNotEmpty) {
                                  _controller.changeBoton(true);
                                } else {
                                  _controller.changeBoton(false);
                                }
                              },
                              controller: _direccionSocialController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(8)),
                                counterText: "",
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: colorPrimary1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(color: colorPrimary1),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                hintText: 'Ingrese dirección',
                                hintStyle: GoogleFonts.poppins(
                                  color: const Color(0XFFA8A8A8),
                                  fontSize: ScreenUtil().setSp(16),
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: ScreenUtil().setSp(0.016),
                                ),
                                filled: true,
                                fillColor: Colors.transparent,
                              ),
                            ),
                          ],
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                  SizedBox(height: ScreenUtil().setHeight(16)),
                  InkWell(
                    onTap: () async {
                      _controller.changeCargando(true);
                      _controller.changeText('');

                      if (_controller.boton) {
                        final api = PlanesApi();

                        bool resp;

                        if (widget.esRenovacion) {
                          resp = await api.renovarPlan(_controller.image, widget.plan.idPlan, widget.tiempoPlan, '', '', '', '', '');
                        } else {
                          resp = await api.cambiarPlan(_controller.image, widget.plan.idPlan, widget.tiempoPlan, '', '', '', '', '');
                        }

                        if (resp) {
                          Navigator.pushReplacementNamed(context, 'splash');
                          // await api.obtenerPlanUser();
                          // Navigator.pop(context);

                          // if (widget.planVencido) {
                          //   Navigator.pushReplacementNamed(context, 'home');

                          //   Navigator.push(
                          //     context,
                          //     PageRouteBuilder(
                          //       pageBuilder: (context, animation, secondaryAnimation) {
                          //         return Home();
                          //       },
                          //       transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          //         var begin = Offset(0.0, 1.0);
                          //         var end = Offset.zero;
                          //         var curve = Curves.ease;

                          //         var tween = Tween(begin: begin, end: end).chain(
                          //           CurveTween(curve: curve),
                          //         );

                          //         return SlideTransition(
                          //           position: animation.drive(tween),
                          //           child: child,
                          //         );
                          //       },
                          //     ),
                          //   );
                          // } else {
                          //   final planesBloc = ProviderBloc.planes(context);
                          //   planesBloc.obtenerPlanes();
                          // }

                          // Navigator.push(
                          //   context,
                          //   PageRouteBuilder(
                          //     transitionDuration: const Duration(milliseconds: 700),
                          //     pageBuilder: (context, animation, secondaryAnimation) {
                          //       return PendienteConfirmacionPage(canchita: widget.canchita, tipo: 'otros');
                          //     },
                          //     transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          //       return FadeTransition(
                          //         opacity: animation,
                          //         child: child,
                          //       );
                          //     },
                          //   ),
                          // );

                          //------------------------------------------------------------------------
                        } else {
                          _controller.changeText('Ocurrió un problema');
                        }
                        // }
                      }
                      _controller.changeCargando(false);
                    },
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (_, t) {
                        return Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            color: (_controller.boton) ? colorPrimary1 : colorPrimary1.withOpacity(0.6),
                          ),
                          child: Center(
                            child: Text(
                              'Validar',
                              style: GoogleFonts.poppins(
                                  color: Colors.white, fontWeight: FontWeight.w600, fontSize: ScreenUtil().setSp(18), fontStyle: FontStyle.normal),
                            ),
                          ),
                          height: ScreenUtil().setHeight(60),
                          width: ScreenUtil().setWidth(327),
                        );
                      },
                    ),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(8)),
                  Center(
                    child: AnimatedBuilder(
                        animation: _controller,
                        builder: (_, s) {
                          return Text(
                            _controller.text,
                            style: GoogleFonts.poppins(
                              color: colorPrimary1,
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(14),
                              fontStyle: FontStyle.normal,
                              letterSpacing: ScreenUtil().setSp(0.016),
                            ),
                          );
                        }),
                  ),
                  SizedBox(height: ScreenUtil().setHeight(8)),
                ],
              ),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (_, s) {
              if (_controller.cargando) {
                return _showLoading();
              } else {
                return Container();
              }
            },
          ),
        ],
      ),
    );
  }

  _showLoading() {
    return Container(
      height: double.infinity,
      width: double.infinity,
      color: const Color.fromRGBO(0, 0, 0, 0.5),
      child: Center(
        child: (Platform.isAndroid)
            ? const CircularProgressIndicator(
                color: colorPrimary1,
              )
            : const CupertinoActivityIndicator(),
      ),
    );
  }
}

class ChangeController extends ChangeNotifier {
  bool cargando = false;

  String text = '';
  bool boton = false;

  File image;

  bool mostrarTextField = false;
  String tipoDoc = '';

  void changeDoc(String tipo) {
    tipoDoc = tipo;
    if (tipo == '01') {
      mostrarTextField = true;
    } else {
      mostrarTextField = false;
    }
    notifyListeners();
  }

  void changeImage(File i) {
    image = i;

    notifyListeners();
  }

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }

  void changeCargando(bool c) {
    cargando = c;
    notifyListeners();
  }

  void changeText(String t) {
    text = t;
    notifyListeners();
  }
}
