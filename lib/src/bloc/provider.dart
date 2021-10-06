
import 'package:flutter/material.dart';
import 'package:mesita_aplication_2/src/bloc/mesa_bloc.dart';


class ProviderBloc extends InheritedWidget {


  static ProviderBloc _instancia;


  final mesasBloc = MesasBloc();


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

}