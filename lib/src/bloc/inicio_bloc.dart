import 'package:flutter/material.dart';

enum PanelIniciostate {
  open,
  closed,
}



enum OptionsInicio {
  table,
  pedidos,
  comida,
  bebida,
  ventas,
  reportes,
}

class InicioBloc with ChangeNotifier {
  PanelIniciostate categoryProductState = PanelIniciostate.open;
  OptionsInicio optionsInicio= OptionsInicio.table;

  void changeToOpen() {
    categoryProductState = PanelIniciostate.open;
    notifyListeners();
  }

  void changeToClosed() {
    categoryProductState = PanelIniciostate.closed;
    notifyListeners();
  }


//##################################################
  void changeToTable() {
    optionsInicio = OptionsInicio.table;
    notifyListeners();
  }


void changeToPedidos() {
    optionsInicio = OptionsInicio.pedidos;
    notifyListeners();
  }

void changeToComidas() {
    optionsInicio = OptionsInicio.comida;
    notifyListeners();
  }

void changeToBebidas() {
    optionsInicio = OptionsInicio.bebida;
    notifyListeners();
  }

void changeToVentas() {
    optionsInicio = OptionsInicio.ventas;
    notifyListeners();
  }

void changeToReportes() {
    optionsInicio = OptionsInicio.reportes;
    notifyListeners();
  }
}
