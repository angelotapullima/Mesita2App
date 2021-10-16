import 'package:flutter/material.dart';
import 'package:mesita_aplication_2/src/bloc/comanda_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/linea_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/mesa_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/pedidos_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/productos_linea_bloc.dart';

class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  final mesasBloc = MesasBloc();
  final lineasBloc = LineaBloc();
  final productosLineaBloc = ProductosLineaBloc();
  final pedidosBloc = PedidosBloc();
  final comandaBloc = ComandaBloc();

  factory ProviderBloc({Key key, Widget child}) {
    if (_instancia == null) {
      _instancia = new ProviderBloc._internal(key: key, child: child);
    }

    return _instancia;
  }

  ProviderBloc._internal({Key key, Widget child}) : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => true;

  static MesasBloc mesas(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).mesasBloc;
  }

  static LineaBloc lineas(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).lineasBloc;
  }

  static ProductosLineaBloc productosLinea(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).productosLineaBloc;
  }

  static PedidosBloc pedidos(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).pedidosBloc;
  }

  static ComandaBloc comanda(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).comandaBloc;
  }
}
