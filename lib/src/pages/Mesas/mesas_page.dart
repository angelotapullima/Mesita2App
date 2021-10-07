import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/mesa_model.dart';
import 'package:mesita_aplication_2/src/pages/Mesas/modal_agregar_mesa.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

class MesasPage extends StatelessWidget {
  const MesasPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mesasBloc = ProviderBloc.mesas(context);
    mesasBloc.obtenerMesasPorNegocio();
    final prefs = Preferences();

    return Scaffold(
      backgroundColor: Color(0XFFE5E5E5),
      appBar: AppBar(
        backgroundColor: Color(0XFFE5E5E5),
        leading: InkWell(
          child: Container(),
        ),
        actions: [
          InkWell(
            onTap: () {
              mesaModal(context);
            },
            child: Container(
              width: ScreenUtil().setWidth(20),
              height: ScreenUtil().setHeight(20),
              child: SvgPicture.asset('assets/food_svg/add_food.svg'),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
          InkWell(
            child: Container(
              width: ScreenUtil().setWidth(32),
              height: ScreenUtil().setHeight(32),
              child: CachedNetworkImage(
                placeholder: (context, url) => Container(
                  child: SvgPicture.asset('assets/settings_svg/porfile.svg'),
                ),
                errorWidget: (context, url, error) => Container(
                  child: Container(
                    child: SvgPicture.asset(
                      'assets/settings_svg/porfile.svg',
                    ),
                  ),
                ),
                imageUrl: '${prefs.userImage}',
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white,
                      width: 2,
                    ),
                    image: DecorationImage(
                      image: imageProvider,
                      //fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            width: ScreenUtil().setWidth(24),
          ),
        ],
        elevation: 0,
        title: Text(
          'Mesas',
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.w600,
            fontSize: ScreenUtil().setSp(24),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(5),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Color(0xffff0036),
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(5),
                ),
                Text(
                  'Ocupado',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(30),
                ),
                Container(
                  width: ScreenUtil().setWidth(20),
                  height: ScreenUtil().setHeight(7),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(5),
                ),
                Text(
                  'Disponible',
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(14),
                  ),
                ),
              ],
            ),
            Expanded(
              child: StreamBuilder(
                stream: mesasBloc.mesasStream,
                builder: (BuildContext context, AsyncSnapshot<List<MesaModel>> snapsdhot) {
                  if (snapsdhot.hasData) {
                    if (snapsdhot.data.length > 0) {
                      return GridView.builder(
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 1.5,
                            mainAxisSpacing: 0,
                            crossAxisSpacing: ScreenUtil().setWidth(10),
                          ),
                          itemCount: snapsdhot.data.length,
                          itemBuilder: (BuildContext context, int index) {
                            return LayoutBuilder(builder: (context, constraints) {
                              return Container(
                                padding: EdgeInsets.only(
                                  right: ScreenUtil().setWidth(10),
                                  left: ScreenUtil().setWidth(10),
                                ),
                                width: constraints.maxWidth,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: constraints.maxWidth * 0.12,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: (index.isOdd) ? Colors.white : Color(0xffff0036),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          height: constraints.maxHeight * 0.55,
                                          width: constraints.maxWidth * 0.2,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.05,
                                    ),
                                    Container(
                                      height: constraints.maxHeight - constraints.maxHeight * 0.20,
                                      width: constraints.maxWidth * 0.52,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        gradient: LinearGradient(
                                          begin: Alignment.bottomLeft,
                                          end: Alignment.topRight,
                                          colors: [
                                            (index.isOdd) ? Colors.white : Color(0xffff6787),
                                            (index.isOdd) ? Colors.white : Color(0xffff0036),
                                          ],

                                          //
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            offset: Offset(0, 0),
                                            blurRadius: 20.0,
                                            color: (index.isOdd) ? Color(0xff585858).withOpacity(.15) : Color(0xffff0036).withOpacity(.3),
                                          ),
                                        ],
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ScreenUtil().setWidth(10),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  '${snapsdhot.data[index].idMesa}',
                                                  style: TextStyle(
                                                    fontSize: ScreenUtil().setSp(45),
                                                    color: (index.isOdd) ? Color(0xfff9708d) : Colors.white,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Spacer(),
                                            Row(
                                              children: [
                                                Spacer(),
                                                Text(
                                                  'cap .${snapsdhot.data[index].mesaCapacidad}',
                                                  style: TextStyle(
                                                      color: (index.isOdd) ? Color(0xff585858) : Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: ScreenUtil().setSp(18)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: constraints.maxWidth * 0.05,
                                    ),
                                    Container(
                                      width: constraints.maxWidth * 0.12,
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(vertical: ScreenUtil().setHeight(10)),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: (index.isOdd) ? Colors.white : Color(0xffff0036),
                                            borderRadius: BorderRadius.circular(5),
                                          ),
                                          height: constraints.maxHeight * 0.55,
                                          width: constraints.maxWidth * 0.2,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            });
                          });
                    } else {
                      return Center(
                        child: Text('Aún no se agregaron mesas'),
                      );
                    }
                  } else {
                    return _showLoading();
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
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
}
