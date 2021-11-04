import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/models/buscar_user_model.dart';

class BuscarUsuario extends StatefulWidget {
  BuscarUsuario({Key key}) : super(key: key);

  @override
  _BuscarUsuarioState createState() => _BuscarUsuarioState();
}

class _BuscarUsuarioState extends State<BuscarUsuario> {
  final TextEditingController _queryController = TextEditingController();

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final busquedaBloc = ProviderBloc.busqueda(context);
      busquedaBloc.buscarUsers('');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final busquedaBloc = ProviderBloc.busqueda(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(16),
          ),
          child: Column(
            children: [
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  BackButton(),
                  Container(
                    width: ScreenUtil().setWidth(260),
                    child: CupertinoSearchTextField(
                      controller: _queryController,
                      backgroundColor: Colors.white,
                      placeholderStyle: GoogleFonts.poppins(
                        color: Color(0XFFA8A7A7),
                        fontWeight: FontWeight.w400,
                        fontSize: ScreenUtil().setSp(16),
                      ),
                      placeholder: 'Ingrese nombre de usuario',
                      onChanged: (value) {
                        if (value != '') {
                          busquedaBloc.buscarUsers(value);
                        } else {
                          _queryController.text = '';
                          busquedaBloc.buscarUsers('');
                        }
                      },
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: ScreenUtil().setHeight(16),
              ),
              Expanded(
                child: StreamBuilder(
                  stream: busquedaBloc.busquedaStream,
                  builder: (context, AsyncSnapshot<List<BuscarUserModel>> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.length > 0) {
                        var users = snapshot.data;

                        return ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  final miembroBloc = ProviderBloc.bloc(context);
                                  miembroBloc.changeId(users[index].id);
                                  miembroBloc.changeName(users[index].nombre);
                                  Navigator.pop(context);
                                },
                                child: Card(
                                  margin: EdgeInsets.all(8),
                                  child: Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text(
                                      users[index].nombre,
                                      style: GoogleFonts.poppins(
                                        color: Color(0XFF585858),
                                        fontWeight: FontWeight.w400,
                                        fontSize: ScreenUtil().setSp(16),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            });
                      } else {
                        return Center(
                          child: Text('No hay resultados'),
                        );
                      }
                    } else {
                      return _showLoading();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _showLoading() {
    return Center(
      child: (Platform.isAndroid)
          ? CircularProgressIndicator(
              color: Color(0XFFFF0036),
            )
          : CupertinoActivityIndicator(),
    );
  }
}
