import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keyboard_actions/keyboard_actions.dart';
import 'package:mesita_aplication_2/src/api/linea_api.dart';
import 'package:mesita_aplication_2/src/api/producto_linea_api.dart';
import 'package:mesita_aplication_2/src/bloc/linea_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/linea_model.dart';
import 'package:mesita_aplication_2/src/models/producto_linea_model.dart';

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;
  File image;

  String idLinea = '';
  String linea = 'Seleccionar categoría de comida';

  void changeLinea(String id, String l) {
    idLinea = id;
    linea = l;
    notifyListeners();
  }

  void changeBoton(bool b) {
    boton = b;
    notifyListeners();
  }

  void changeImage(File i) {
    image = i;
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

void addModal(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return GestureDetector(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          color: Color.fromRGBO(0, 0, 0, 0.001),
          child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
              initialChildSize: 0.3,
              minChildSize: 0.2,
              maxChildSize: 0.3,
              builder: (_, controller) {
                return Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(25.0),
                      topRight: const Radius.circular(25.0),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(24),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: ScreenUtil().setHeight(24),
                        ),
                        SizedBox(
                          height: ScreenUtil().setWidth(4),
                          child: Center(
                            child: Container(
                              width: ScreenUtil().setWidth(48),
                              decoration: BoxDecoration(
                                color: Color(0XFFBABABA),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Center(
                          child: Text(
                            'Agregar',
                            style: GoogleFonts.poppins(
                              color: Color(0XFF3A3A3A),
                              fontWeight: FontWeight.w600,
                              fontSize: ScreenUtil().setSp(18),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(8),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            _newFoodModal(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/food_svg/new_food.svg',
                                fit: BoxFit.cover,
                                height: ScreenUtil().setHeight(20),
                                width: ScreenUtil().setWidth(20),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(13),
                              ),
                              Text(
                                'Nueva comida',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF585858),
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                        SizedBox(
                          height: ScreenUtil().setHeight(10),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            _addCategoryModal(context);
                          },
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                'assets/food_svg/tag.svg',
                                fit: BoxFit.cover,
                                height: ScreenUtil().setHeight(20),
                                width: ScreenUtil().setWidth(20),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(13),
                              ),
                              Text(
                                'Nueva categoría',
                                style: GoogleFonts.poppins(
                                  fontStyle: FontStyle.normal,
                                  fontWeight: FontWeight.w500,
                                  color: Color(0XFF585858),
                                  fontSize: ScreenUtil().setSp(16),
                                  letterSpacing: 0.16,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      );
    },
  );
}

void _newFoodModal(BuildContext context) {
  final lineasBloc = ProviderBloc.lineas(context);
  lineasBloc.obtenerLineasPorNegocio();
  final _controller = ChangeController();

  TextEditingController _precioController = new TextEditingController();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();

  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();
  FocusNode _focus3 = FocusNode();

  final picker = ImagePicker();
  Future<Null> _cropImage(filePath) async {
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
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cortar Imagen',
            toolbarColor: Color(0XFFFF0036),
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            showCropGrid: true,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(minimumAspectRatio: 1.0, title: 'Cortar Imagen'));
    if (croppedImage != null) {
      _controller.changeImage(croppedImage);
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

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.001),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.93,
                    minChildSize: 0.2,
                    maxChildSize: 0.93,
                    builder: (_, controller) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(30),
                            topRight: const Radius.circular(30),
                          ),
                        ),
                        child: KeyboardActions(
                          config: KeyboardActionsConfig(keyboardSeparatorColor: Colors.white, keyboardBarColor: Colors.white, actions: [
                            KeyboardActionsItem(focusNode: _focus1),
                            KeyboardActionsItem(focusNode: _focus2),
                            KeyboardActionsItem(focusNode: _focus3),
                          ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(24)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setWidth(4),
                                    child: Center(
                                      child: Container(
                                        width: ScreenUtil().setWidth(48),
                                        decoration: BoxDecoration(
                                          color: Color(0XFFBABABA),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(10),
                                  ),
                                  Center(
                                    child: Text(
                                      'Nueva comida',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFFFF0036),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                            context: context,
                                            isScrollControlled: true,
                                            backgroundColor: Colors.transparent,
                                            builder: (context) {
                                              return GestureDetector(
                                                onTap: () => Navigator.of(context).pop(),
                                                child: Container(
                                                  color: Color.fromRGBO(0, 0, 0, 0.001),
                                                  child: GestureDetector(
                                                    onTap: () {},
                                                    child: DraggableScrollableSheet(
                                                      initialChildSize: 0.2,
                                                      minChildSize: 0.2,
                                                      maxChildSize: 0.2,
                                                      builder: (_, controller) {
                                                        return Container(
                                                          decoration: BoxDecoration(
                                                            color: Colors.white,
                                                            borderRadius: BorderRadius.only(
                                                              topLeft: const Radius.circular(25.0),
                                                              topRight: const Radius.circular(25.0),
                                                            ),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.symmetric(
                                                              horizontal: ScreenUtil().setWidth(24),
                                                            ),
                                                            child: Column(
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                SizedBox(
                                                                  height: ScreenUtil().setHeight(24),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                    getImageGallery();
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Seleccionar foto',
                                                                        style: GoogleFonts.poppins(
                                                                          fontStyle: FontStyle.normal,
                                                                          color: Color(0XFF585858),
                                                                          fontWeight: FontWeight.w400,
                                                                          fontSize: ScreenUtil().setSp(16),
                                                                          letterSpacing: ScreenUtil().setSp(0.016),
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons.photo_album_outlined,
                                                                        color: Color(0XFFFF0036),
                                                                        size: ScreenUtil().setHeight(24),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness: 1,
                                                                ),
                                                                SizedBox(
                                                                  height: ScreenUtil().setHeight(10),
                                                                ),
                                                                InkWell(
                                                                  onTap: () {
                                                                    Navigator.pop(context);
                                                                    getImageCamera();
                                                                  },
                                                                  child: Row(
                                                                    children: [
                                                                      Text(
                                                                        'Tomar foto',
                                                                        style: GoogleFonts.poppins(
                                                                          fontStyle: FontStyle.normal,
                                                                          fontWeight: FontWeight.w400,
                                                                          color: Color(0XFF585858),
                                                                          fontSize: ScreenUtil().setSp(16),
                                                                          letterSpacing: ScreenUtil().setSp(0.016),
                                                                        ),
                                                                      ),
                                                                      Spacer(),
                                                                      Icon(
                                                                        Icons.photo_camera_outlined,
                                                                        color: Color(0XFFFF0036),
                                                                        size: ScreenUtil().setHeight(24),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                Divider(
                                                                  thickness: 1,
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                          );
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(150),
                                          width: ScreenUtil().setWidth(150),
                                          decoration: BoxDecoration(
                                            color: Color(0XFFEEEEEE),
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: Color.fromRGBO(88, 88, 88, 0.3),
                                                blurRadius: 20,
                                              ),
                                            ],
                                          ),
                                          child: Stack(
                                            children: [
                                              Align(
                                                alignment: Alignment.center,
                                                child: Container(
                                                    height: ScreenUtil().setHeight(120),
                                                    width: ScreenUtil().setWidth(120),
                                                    decoration: BoxDecoration(
                                                      color: Color(0XFFEEEEEE),
                                                      shape: BoxShape.circle,
                                                      boxShadow: [
                                                        BoxShadow(
                                                          offset: Offset(-1, -1),
                                                          color: Color.fromRGBO(0, 0, 0, 0.2),
                                                          blurRadius: 5,
                                                        ),
                                                      ],
                                                    ),
                                                    child: SvgPicture.asset('assets/food_svg/food.svg')),
                                              ),
                                              Align(
                                                alignment: Alignment.bottomRight,
                                                child: Container(
                                                    height: ScreenUtil().setHeight(23),
                                                    width: ScreenUtil().setWidth(23),
                                                    child: SvgPicture.asset('assets/food_svg/add_image.svg')),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      Container(
                                        width: ScreenUtil().setWidth(156),
                                        child: Column(
                                          children: [
                                            Text(
                                              'Precio',
                                              style: GoogleFonts.poppins(
                                                color: Color(0XFF585858),
                                                fontWeight: FontWeight.w500,
                                                fontSize: ScreenUtil().setSp(16),
                                              ),
                                            ),
                                            TextField(
                                              focusNode: _focus1,
                                              controller: _precioController,
                                              maxLines: 1,
                                              onChanged: (value) {
                                                if (value.length > 0 &&
                                                    _nombreController.text.length > 0 &&
                                                    _descripcionController.text.length > 0 &&
                                                    _controller.idLinea != '') {
                                                  _controller.changeBoton(true);
                                                } else {
                                                  _controller.changeBoton(false);
                                                }
                                              },
                                              keyboardType: TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: 'S/00.00',
                                                hintStyle: TextStyle(
                                                  color: Color(0XFFBEBEBE),
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: ScreenUtil().setSp(16),
                                                  fontStyle: FontStyle.normal,
                                                ),
                                                filled: true,
                                                fillColor: Color(0XFFEDEDED),
                                                contentPadding: EdgeInsets.only(
                                                    left: ScreenUtil().setWidth(10),
                                                    top: ScreenUtil().setHeight(5),
                                                    bottom: ScreenUtil().setHeight(1)),
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
                                    ],
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(8)),
                                  Text(
                                    'Nombre',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus2,
                                    controller: _nombreController,
                                    maxLines: 1,
                                    keyboardType: TextInputType.text,
                                    onChanged: (value) {
                                      if (value.length > 0 &&
                                          _precioController.text.length > 0 &&
                                          _descripcionController.text.length > 0 &&
                                          _controller.idLinea != '') {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Ingrese nombre de comida',
                                      hintStyle: TextStyle(
                                        color: Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                                  SizedBox(height: ScreenUtil().setHeight(8)),
                                  Text(
                                    'Categoría',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        backgroundColor: Colors.transparent,
                                        builder: (context) {
                                          return StreamBuilder(
                                              stream: lineasBloc.lineasStream,
                                              builder: (BuildContext context, AsyncSnapshot<List<LineaModel>> snapshot) {
                                                if (snapshot.hasData && snapshot.data.length >= 0) {
                                                  return GestureDetector(
                                                    onTap: () => Navigator.of(context).pop(),
                                                    child: Container(
                                                      color: Color.fromRGBO(0, 0, 0, 0.001),
                                                      child: GestureDetector(
                                                        onTap: () {},
                                                        child: DraggableScrollableSheet(
                                                          initialChildSize: 0.9,
                                                          minChildSize: 0.2,
                                                          maxChildSize: 0.9,
                                                          builder: (_, controller) {
                                                            return Container(
                                                              decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.only(
                                                                  topLeft: const Radius.circular(30),
                                                                  topRight: const Radius.circular(30),
                                                                ),
                                                              ),
                                                              child: Padding(
                                                                padding: EdgeInsets.symmetric(
                                                                    vertical: ScreenUtil().setHeight(24), horizontal: ScreenUtil().setWidth(24)),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      children: [
                                                                        IconButton(
                                                                          icon: Icon(
                                                                            Icons.arrow_back_ios,
                                                                          ),
                                                                          iconSize: ScreenUtil().setSp(20),
                                                                          onPressed: () => Navigator.of(context).pop(),
                                                                        ),
                                                                        SizedBox(width: ScreenUtil().setWidth(30)),
                                                                        Text(
                                                                          'Seleccione una línea',
                                                                          textAlign: TextAlign.center,
                                                                          style: GoogleFonts.poppins(
                                                                            color: Color(0XFF585858),
                                                                            fontStyle: FontStyle.normal,
                                                                            fontWeight: FontWeight.w700,
                                                                            fontSize: ScreenUtil().setSp(18),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Expanded(
                                                                      child: ListView.builder(
                                                                        itemCount: snapshot.data.length,
                                                                        shrinkWrap: true,
                                                                        itemBuilder: (context, index2) {
                                                                          return Column(
                                                                            children: [
                                                                              InkWell(
                                                                                onTap: () {
                                                                                  _controller.changeLinea(snapshot.data[index2].idLinea,
                                                                                      snapshot.data[index2].lineaNombre);
                                                                                  if (_precioController.text.length > 0 &&
                                                                                      _nombreController.text.length > 0 &&
                                                                                      _descripcionController.text.length > 0 &&
                                                                                      _controller.idLinea != '') {
                                                                                    _controller.changeBoton(true);
                                                                                  } else {
                                                                                    _controller.changeBoton(false);
                                                                                  }
                                                                                  Navigator.pop(context);
                                                                                },
                                                                                child: Row(
                                                                                  children: [
                                                                                    SizedBox(
                                                                                      width: ScreenUtil().setWidth(8),
                                                                                    ),
                                                                                    Text(
                                                                                      '${snapshot.data[index2].lineaNombre}',
                                                                                      style: GoogleFonts.poppins(
                                                                                        color: Color(0XFF585858),
                                                                                        fontWeight: FontWeight.w500,
                                                                                        fontSize: ScreenUtil().setSp(16),
                                                                                        letterSpacing: ScreenUtil().setSp(0.016),
                                                                                      ),
                                                                                    ),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              Divider(),
                                                                            ],
                                                                          );
                                                                        },
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                      ),
                                                    ),
                                                  );
                                                } else {
                                                  return Container();
                                                }
                                              });
                                        },
                                      );
                                    },
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (context, snapshot) {
                                          return Container(
                                            height: ScreenUtil().setHeight(48),
                                            width: double.infinity,
                                            decoration: BoxDecoration(color: Color(0XFFEDEDED), borderRadius: BorderRadius.circular(15)),
                                            padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  _controller.linea,
                                                  style: TextStyle(
                                                    color: (_controller.idLinea != '') ? Color(0XFF585858) : Color(0XFFBEBEBE),
                                                    fontWeight: FontWeight.w400,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontStyle: FontStyle.normal,
                                                  ),
                                                ),
                                                Icon(
                                                  Icons.arrow_drop_down,
                                                  size: ScreenUtil().setHeight(20),
                                                  color: Color(0XFF585858),
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(8)),
                                  Text(
                                    'Descripción',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus3,
                                    controller: _descripcionController,
                                    maxLines: null,
                                    keyboardType: TextInputType.multiline,
                                    onChanged: (value) {
                                      if (value.length > 0 &&
                                          _precioController.text.length > 0 &&
                                          _nombreController.text.length > 0 &&
                                          _controller.idLinea != '') {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    decoration: InputDecoration(
                                      hintText: 'Ingredientes, tiempo de preparación, etc.',
                                      hintStyle: TextStyle(
                                        color: Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                                  SizedBox(height: ScreenUtil().setHeight(48)),
                                  InkWell(
                                    onTap: () async {
                                      _controller.changeCargando(true);
                                      _controller.changeText('');
                                      if (_controller.boton) {
                                        final _productoLineaApi = ProductoLineaApi();
                                        ProductoLineaModel producto = ProductoLineaModel();
                                        producto.idLinea = _controller.idLinea;
                                        producto.productoNombre = _nombreController.text;
                                        producto.productoPrecio = _precioController.text;
                                        producto.productoDescripcion = _descripcionController.text;

                                        final res = await _productoLineaApi.agregarNuevoProductoPorLinea(_controller.image, producto);
                                        if (res == 1) {
                                          final productosLineaBloc = ProviderBloc.productosLinea(context);
                                          productosLineaBloc.obtenerProductosPorLinea(_controller.idLinea);
                                          Navigator.pop(context);
                                        } else {
                                          _controller.changeText('Ocurrió un error. inténtelo nuevamente');
                                        }
                                      }

                                      _controller.changeCargando(false);
                                    },
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: (_controller.boton) ? Color(0XFFFF0036) : Color(0XFFFF0036).withOpacity(0.6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Agregar comida',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                              ),
                                              height: ScreenUtil().setHeight(44),
                                              width: ScreenUtil().setWidth(255),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(8)),
                                  Center(
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Text(
                                            _controller.text,
                                            style: TextStyle(
                                              color: Color(0XFFFF0036),
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: ScreenUtil().setSp(0.016),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: GoogleFonts.poppins(
                                          color: Color(0XFF8A8A8A),
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
                        ),
                      );
                    }),
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
                })
          ],
        );
      });
}

void _addCategoryModal(BuildContext context) {
  final _controller = ChangeController();

  TextEditingController _nombreLineaController = new TextEditingController();

  FocusNode _focus1 = FocusNode();

  showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Stack(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                color: Color.fromRGBO(0, 0, 0, 0.001),
                child: DraggableScrollableSheet(
                    initialChildSize: 0.93,
                    minChildSize: 0.2,
                    maxChildSize: 0.93,
                    builder: (_, controller) {
                      return Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                            topLeft: const Radius.circular(30),
                            topRight: const Radius.circular(30),
                          ),
                        ),
                        child: KeyboardActions(
                          config: KeyboardActionsConfig(keyboardSeparatorColor: Colors.white, keyboardBarColor: Colors.white, actions: [
                            KeyboardActionsItem(focusNode: _focus1),
                          ]),
                          child: Padding(
                            padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10), horizontal: ScreenUtil().setWidth(24)),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setWidth(4),
                                    child: Center(
                                      child: Container(
                                        width: ScreenUtil().setWidth(48),
                                        decoration: BoxDecoration(
                                          color: Color(0XFFBABABA),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(10),
                                  ),
                                  Center(
                                    child: Text(
                                      'Nueva categoría',
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFFFF0036),
                                        fontWeight: FontWeight.w600,
                                        fontSize: ScreenUtil().setSp(18),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setWidth(24),
                                  ),
                                  Text(
                                    'Categoría',
                                    style: GoogleFonts.poppins(
                                      color: Color(0XFF585858),
                                      fontWeight: FontWeight.w500,
                                      fontSize: ScreenUtil().setSp(16),
                                    ),
                                  ),
                                  TextField(
                                    focusNode: _focus1,
                                    controller: _nombreLineaController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.text,
                                    decoration: InputDecoration(
                                      hintText: 'Ingrese nombre de la categoría',
                                      hintStyle: TextStyle(
                                        color: Color(0XFFBEBEBE),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                        fontStyle: FontStyle.normal,
                                      ),
                                      filled: true,
                                      fillColor: Color(0XFFEDEDED),
                                      contentPadding: EdgeInsets.only(
                                          left: ScreenUtil().setWidth(10), top: ScreenUtil().setHeight(5), bottom: ScreenUtil().setHeight(1)),
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
                                  SizedBox(height: ScreenUtil().setHeight(48)),
                                  InkWell(
                                    onTap: () async {
                                      _controller.changeCargando(true);
                                      _controller.changeText('');
                                      if (_controller.boton) {
                                        final _lineaApi = LineaApi();
                                        final res = await _lineaApi.agregarNuevaLinea(_nombreLineaController.text);
                                        if (res == 1) {
                                          final lineasBloc = ProviderBloc.lineas(context);
                                          lineasBloc.obtenerLineasPorNegocio();
                                          Navigator.pop(context);
                                        } else {
                                          _controller.changeText('Ocurrió un error, inténtelo nuevamente');
                                        }
                                      }

                                      _controller.changeCargando(false);
                                    },
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(50),
                                                color: (_controller.boton) ? Color(0XFFFF0036) : Color(0XFFFF0036).withOpacity(0.6),
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'Agregar categoría',
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontWeight: FontWeight.w600,
                                                    fontSize: ScreenUtil().setSp(16),
                                                    fontStyle: FontStyle.normal,
                                                    letterSpacing: 1.5,
                                                  ),
                                                ),
                                              ),
                                              height: ScreenUtil().setHeight(44),
                                              width: ScreenUtil().setWidth(255),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(8)),
                                  Center(
                                    child: AnimatedBuilder(
                                        animation: _controller,
                                        builder: (_, s) {
                                          return Text(
                                            _controller.text,
                                            style: TextStyle(
                                              color: Color(0XFFFF0036),
                                              fontWeight: FontWeight.w600,
                                              fontSize: ScreenUtil().setSp(16),
                                              fontStyle: FontStyle.normal,
                                              letterSpacing: ScreenUtil().setSp(0.016),
                                            ),
                                          );
                                        }),
                                  ),
                                  SizedBox(height: ScreenUtil().setHeight(10)),
                                  Center(
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text(
                                        'Cancelar',
                                        style: GoogleFonts.poppins(
                                          color: Color(0XFF8A8A8A),
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
                        ),
                      );
                    }),
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
                })
          ],
        );
      });
}

_showLoading() {
  return Container(
    height: double.infinity,
    width: double.infinity,
    color: Color.fromRGBO(0, 0, 0, 0.5),
    child: Center(
      child: (Platform.isAndroid)
          ? CircularProgressIndicator(
              color: Color(0XFFFF0036),
            )
          : CupertinoActivityIndicator(),
    ),
  );
}
