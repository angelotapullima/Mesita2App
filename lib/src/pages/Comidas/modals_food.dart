import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

class ChangeController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;

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
  final _controller = ChangeController();

  TextEditingController _precioController = new TextEditingController();
  TextEditingController _nombreController = new TextEditingController();
  TextEditingController _descripcionController = new TextEditingController();

  FocusNode _focus1 = FocusNode();
  FocusNode _focus2 = FocusNode();
  FocusNode _focus3 = FocusNode();

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
                                      Container(
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
                                                if (value.length > 0 && _nombreController.text.length > 0) {
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
                                      if (value.length > 0 && _precioController.text.length > 0) {
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
                                    child: Container(
                                      height: ScreenUtil().setHeight(48),
                                      width: double.infinity,
                                      decoration: BoxDecoration(color: Color(0XFFEDEDED), borderRadius: BorderRadius.circular(15)),
                                      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(10)),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            'Seleccionar categoria de comida',
                                            style: TextStyle(
                                              color: Color(0XFFBEBEBE),
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
                                    ),
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
                                      if (value.length > 0 && _precioController.text.length > 0) {
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
                                      if (_controller.boton) {}

                                      // }
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

  TextEditingController _precioController = new TextEditingController();

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
                                    controller: _precioController,
                                    maxLines: 1,
                                    onChanged: (value) {
                                      if (value.length > 0) {
                                        _controller.changeBoton(true);
                                      } else {
                                        _controller.changeBoton(false);
                                      }
                                    },
                                    keyboardType: TextInputType.number,
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
                                      if (_controller.boton) {}

                                      // }
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
