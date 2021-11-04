import 'package:flutter/material.dart';
import 'package:mesita_aplication_2/src/bloc/buscar_user_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/comanda_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/linea_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/mesa_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/pedidos_atender_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/pedidos_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/planes_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/productos_linea_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/reporte_bloc.dart';
import 'package:mesita_aplication_2/src/bloc/ventas_bloc.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/bloc.dart';

class ProviderBloc extends InheritedWidget {
  static ProviderBloc _instancia;

  final mesasBloc = MesasBloc();
  final lineasBloc = LineaBloc();
  final productosLineaBloc = ProductosLineaBloc();
  final pedidosBloc = PedidosBloc();
  final comandaBloc = ComandaBloc();
  final atenderBloc = PedidosAtenderBloc();
  final ventasBloc = VentasBloc();
  final reporteBloc = ReporteBloc();
  final planesBloc = PlanesBloc();
  final blocMiembro = Bloc();
  final buscarBloc = BuscarUserBloc();

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

  static PedidosAtenderBloc atender(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).atenderBloc;
  }

  static VentasBloc ventas(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).ventasBloc;
  }

  static ReporteBloc reporte(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).reporteBloc;
  }

  static PlanesBloc planes(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).planesBloc;
  }

  static Bloc bloc(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).blocMiembro;
  }

  static BuscarUserBloc busqueda(BuildContext context) {
    return (context.dependOnInheritedWidgetOfExactType<ProviderBloc>()).buscarBloc;
  }
}
