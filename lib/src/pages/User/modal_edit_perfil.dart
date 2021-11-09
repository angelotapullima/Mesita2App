import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/file.dart';

class ChangeEditPerfilController extends ChangeNotifier {
  bool cargando = false;
  String text = '';
  bool boton = false;
  File image;

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
