import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesita_aplication_2/src/bloc/inicio_bloc.dart';
import 'package:mesita_aplication_2/src/pages/Bebidas/bebidas_page.dart';
import 'package:mesita_aplication_2/src/pages/Comidas/comidas_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/mesas_page.dart';
import 'package:mesita_aplication_2/src/pages/Pedidos/pedidos_page.dart';
import 'package:mesita_aplication_2/src/pages/Reportes/reportes_page.dart';
import 'package:mesita_aplication_2/src/pages/Ventas/ventas_page.dart';
import 'package:mesita_aplication_2/src/utils/colors.dart';

class Home extends StatefulWidget {
  const Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

double _getPanelWhite(PanelIniciostate state) {
  if (state == PanelIniciostate.open) {
    return -ScreenUtil().setWidth(50);
  } else {
    return 0;
  }
}

class _HomeState extends State<Home> {
  final bloc = InicioBloc();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (bloc.categoryProductState == PanelIniciostate.closed) {
          bloc.changeToOpen();
        } else {
          bloc.changeToClosed();
        }
        return false;
      },
      child: AnimatedBuilder(
        animation: bloc,
        builder: (context, _) {
          return Scaffold(
            body: Stack(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: Container(
                    width: ScreenUtil().setWidth(150),
                    color: colorPrimary1,
                  ),
                ),
                AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.decelerate,
                  right: _getPanelWhite(bloc.categoryProductState),
                  top: 0,
                  bottom: 0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: (bloc.categoryProductState == PanelIniciostate.open) ? const Radius.circular(35) : const Radius.circular(0),
                      bottomLeft: (bloc.categoryProductState == PanelIniciostate.open) ? const Radius.circular(35) : const Radius.circular(0),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xffededed),
                      ),
                      width: ScreenUtil().setWidth(375),
                      height: double.infinity,
                      child: (bloc.optionsInicio == OptionsInicio.table)
                          ? const MesasPage()
                          : (bloc.optionsInicio == OptionsInicio.comida)
                              ? const ComidasPage()
                              : (bloc.optionsInicio == OptionsInicio.bebida)
                                  ? const BebidasPage()
                                  : (bloc.optionsInicio == OptionsInicio.pedidos)
                                      ? const PedidosPage()
                                      : (bloc.optionsInicio == OptionsInicio.ventas)
                                          ? const VentasPage()
                                          : (bloc.optionsInicio == OptionsInicio.reportes)
                                              ? const ReportesPage()
                                              : Container(),
                    ),
                  ),
                ),
                Positioned(
                  left: 0,
                  top: 0,
                  bottom: 0,
                  child: (bloc.categoryProductState == PanelIniciostate.open)
                      ? Container(
                          width: ScreenUtil().setWidth(60),
                          color: Colors.transparent,
                          child: SafeArea(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: ScreenUtil().setWidth(8),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: ScreenUtil().setHeight(90),
                                  ),
                                  SizedBox(
                                    //color: Colors.black,
                                    height: ScreenUtil().setHeight(70),
                                    child: Stack(
                                      children: [
                                        (bloc.optionsInicio == OptionsInicio.table)
                                            ? Center(
                                                child: Container(
                                                  transform: Matrix4.translationValues(
                                                    0,
                                                    -ScreenUtil().setHeight(10),
                                                    0,
                                                  ),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(50),
                                                      color: colorPrimary1,
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: ScreenUtil().setHeight(5),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil().setWidth(6),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            bloc.changeToTable();
                                            bloc.changeToClosed();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                                width: ScreenUtil().setWidth(25),
                                                child: SvgPicture.asset(
                                                  'assets/svg/table_menu.svg',
                                                ),
                                              ),
                                              Text(
                                                'Mesas',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(8.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(70),
                                    child: Stack(
                                      children: [
                                        (bloc.optionsInicio == OptionsInicio.pedidos)
                                            ? Center(
                                                child: Container(
                                                  transform: Matrix4.translationValues(0, -ScreenUtil().setHeight(14), 0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(100),
                                                      color: colorPrimary1,
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: ScreenUtil().setHeight(5),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil().setWidth(6),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            bloc.changeToPedidos();
                                            bloc.changeToClosed();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                                width: ScreenUtil().setWidth(25),
                                                child: SvgPicture.asset(
                                                  'assets/svg/pedido_menu.svg',
                                                ),
                                              ),
                                              Text(
                                                'Pedidos',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(8.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(70),
                                    child: Stack(
                                      children: [
                                        (bloc.optionsInicio == OptionsInicio.comida)
                                            ? Center(
                                                child: Container(
                                                  transform: Matrix4.translationValues(0, -ScreenUtil().setHeight(14), 0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(100),
                                                      color: colorPrimary1,
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: ScreenUtil().setHeight(5),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil().setWidth(6),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            bloc.changeToComidas();
                                            bloc.changeToClosed();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                                width: ScreenUtil().setWidth(25),
                                                child: SvgPicture.asset(
                                                  'assets/svg/comida_menu.svg',
                                                ),
                                              ),
                                              Text(
                                                'Comidas',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(8.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(70),
                                    child: Stack(
                                      children: [
                                        (bloc.optionsInicio == OptionsInicio.bebida)
                                            ? Center(
                                                child: Container(
                                                  transform: Matrix4.translationValues(0, -ScreenUtil().setHeight(14), 0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(100),
                                                      color: colorPrimary1,
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: ScreenUtil().setHeight(5),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil().setWidth(6),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            bloc.changeToBebidas();
                                            bloc.changeToClosed();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                                width: ScreenUtil().setWidth(25),
                                                child: SvgPicture.asset(
                                                  'assets/svg/bebida_menu.svg',
                                                ),
                                              ),
                                              Text(
                                                'Bebidas',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(8.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(70),
                                    child: Stack(
                                      children: [
                                        (bloc.optionsInicio == OptionsInicio.ventas)
                                            ? Center(
                                                child: Container(
                                                  transform: Matrix4.translationValues(0, -ScreenUtil().setHeight(14), 0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(100),
                                                      color: colorPrimary1,
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: ScreenUtil().setHeight(5),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil().setWidth(6),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            bloc.changeToVentas();
                                            bloc.changeToClosed();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                                width: ScreenUtil().setWidth(25),
                                                child: SvgPicture.asset(
                                                  'assets/svg/ventas_menu.svg',
                                                ),
                                              ),
                                              Text(
                                                'Ventas',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(8.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(30),
                                  ),
                                  SizedBox(
                                    height: ScreenUtil().setHeight(70),
                                    child: Stack(
                                      children: [
                                        (bloc.optionsInicio == OptionsInicio.reportes)
                                            ? Center(
                                                child: Container(
                                                  transform: Matrix4.translationValues(0, -ScreenUtil().setHeight(14), 0),
                                                  child: ClipOval(
                                                    child: Container(
                                                      height: ScreenUtil().setHeight(100),
                                                      color: colorPrimary1,
                                                      child: Row(
                                                        children: [
                                                          const Spacer(),
                                                          CircleAvatar(
                                                            backgroundColor: Colors.white,
                                                            radius: ScreenUtil().setHeight(5),
                                                          ),
                                                          SizedBox(
                                                            width: ScreenUtil().setWidth(6),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            bloc.changeToReportes();
                                            bloc.changeToClosed();
                                          },
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.center,
                                            children: [
                                              SizedBox(
                                                height: ScreenUtil().setHeight(30),
                                                width: ScreenUtil().setWidth(25),
                                                child: SvgPicture.asset(
                                                  'assets/svg/reportes_menu.svg',
                                                ),
                                              ),
                                              Text(
                                                'Reportes',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: ScreenUtil().setSp(8.5),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Positioned(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(12),
                  child: SafeArea(
                    child: InkWell(
                      onTap: () {
                        if (bloc.categoryProductState == PanelIniciostate.closed) {
                          bloc.changeToOpen();
                        } else {
                          bloc.changeToClosed();
                        }
                      },
                      child: SizedBox(
                        height: ScreenUtil().setHeight(30),
                        width: ScreenUtil().setWidth(25),
                        child: SvgPicture.asset(
                          'assets/svg/options_menu.svg',
                          color: (bloc.categoryProductState == PanelIniciostate.open) ? Colors.white : const Color(0xff585858),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
