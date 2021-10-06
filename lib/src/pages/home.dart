import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mesita_aplication_2/src/bloc/inicio_bloc.dart';
import 'package:mesita_aplication_2/src/pages/Comidas/comidas_page.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/mesas_page.dart';

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
    return AnimatedBuilder(
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
                  color: Color(0xffFF0036),
                ),
              ),
              AnimatedPositioned(
                duration: Duration(milliseconds: 300),
                curve: Curves.decelerate,
                right: _getPanelWhite(bloc.categoryProductState),
                top: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xffededed),
                    borderRadius: BorderRadius.only(
                      topLeft: (bloc.categoryProductState == PanelIniciostate.open) ? Radius.circular(35) : Radius.circular(0),
                      bottomLeft: (bloc.categoryProductState == PanelIniciostate.open) ? Radius.circular(35) : Radius.circular(0),
                    ),
                  ),
                  width: ScreenUtil().setWidth(375),
                  height: double.infinity,
                  child: (bloc.optionsInicio == OptionsInicio.table)
                      ? MesasPage()
                      : (bloc.optionsInicio == OptionsInicio.comida)
                          ? ComidasPage()
                          : Container(),
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
                            padding: EdgeInsets.only(left: ScreenUtil().setWidth(8)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: ScreenUtil().setHeight(90),
                                ),
                                Container(
                                  height: ScreenUtil().setHeight(70),
                                  child: Stack(
                                    children: [
                                      (bloc.optionsInicio == OptionsInicio.table)
                                          ? Center(
                                              child: Container(
                                                transform: Matrix4.translationValues(0, -ScreenUtil().setHeight(14), 0),
                                                child: ClipOval(
                                                  child: Container(
                                                    height: ScreenUtil().setHeight(100),
                                                    color: Color(0xffFF0036),
                                                    //color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
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
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/table_menu.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(50),
                                ),
                                Container(
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
                                                    color: Color(0xffFF0036),
                                                    //color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
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
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/pedido_menu.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(50),
                                ),
                                Container(
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
                                                    color: Color(0xffFF0036),
                                                    //color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
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
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/comida_menu.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(50),
                                ),
                                Container(
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
                                                    color: Color(0xffFF0036),
                                                    //color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
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
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/bebida_menu.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(50),
                                ),
                                Container(
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
                                                    color: Color(0xffFF0036),
                                                    //color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
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
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/ventas_menu.svg',
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: ScreenUtil().setHeight(50),
                                ),
                                Container(
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
                                                    color: Color(0xffFF0036),
                                                    //color: Colors.blue,
                                                    child: Row(
                                                      children: [
                                                        Spacer(),
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
                                        },
                                        child: Container(
                                          height: ScreenUtil().setHeight(40),
                                          width: ScreenUtil().setWidth(35),
                                          child: SvgPicture.asset(
                                            'assets/svg/reportes_menu.svg',
                                          ),
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
                    child: Container(
                      height: ScreenUtil().setHeight(30),
                      width: ScreenUtil().setWidth(25),
                      child: SvgPicture.asset(
                        'assets/svg/options_menu.svg',
                        color: (bloc.categoryProductState == PanelIniciostate.open) ? Colors.white : Color(0xff585858),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
