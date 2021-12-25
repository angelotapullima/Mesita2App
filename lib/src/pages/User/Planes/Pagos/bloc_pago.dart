import 'package:flutter/cupertino.dart';
import 'package:flutter/rendering.dart';

class PagoBLoc extends ChangeNotifier {
  final ValueNotifier<bool> _cargando = ValueNotifier(false);
  ValueNotifier<bool> get cargando => _cargando;
  final ValueNotifier<bool> _show = ValueNotifier(true);
  ValueNotifier<bool> get show => _show;

  final ValueNotifier<bool> _animacionCalendar = ValueNotifier(false);
  ValueNotifier<bool> get animacionCalendar => _animacionCalendar;

  final ScrollController _controller = ScrollController();
  ScrollController get controller => _controller;

  PagoBLoc() {
    _init();
  }

  void _init() {
    _controller.addListener(_listener);
  }

  void _listener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      _show.value = false;
    } else if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      _show.value = true;
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_listener);
    _controller?.dispose();
    super.dispose();
  }

  void changeCargandoTrue() {
    _cargando.value = true;
    notifyListeners();
  }

  void changeCargandoFalse() {
    _cargando.value = false;
    notifyListeners();
  }

  //void setIndex(bool value) => this._cargando.value = value;
  void setEstadoAnimacion(bool value) => _animacionCalendar.value = value;
}
