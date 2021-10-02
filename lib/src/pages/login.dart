import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

enum PageMostrar { inicioSesion, registro }

class Login extends StatefulWidget {
  const Login({Key key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  PageMostrar _currentPage = PageMostrar.registro;
  bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: -ScreenUtil().setWidth(150),
            top: -ScreenUtil().setHeight(250),
            child: Container(
              width: ScreenUtil().setHeight(280) * 2,
              height: ScreenUtil().setHeight(280) * 2,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/img/img_login.jpg'),
                ),
                borderRadius: BorderRadius.all(Radius.circular(900)),
                color: Colors.redAccent,
              ),
            ), /* CircleAvatar(
              radius: ScreenUtil().setHeight(280),
              backgroundImage: const AssetImage('assets/img/img_login.jpg'),
            ), */
          ),
          Positioned(
            left: -ScreenUtil().setWidth(120),
            top: -ScreenUtil().setHeight(250),
            child: Container(
              width: ScreenUtil().setHeight(280) * 2,
              height: ScreenUtil().setHeight(280) * 2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(ScreenUtil().setHeight(280)),
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      const Color(0xffFF6787).withOpacity(.6),
                      const Color(0xffFF0036).withOpacity(.8),
                    ],

                    //
                  ),
                  color: Colors.black),
            ),
          ),
          Positioned(
            left: -ScreenUtil().setWidth(150),
            top: -ScreenUtil().setHeight(250),
            child: Container(
              width: ScreenUtil().setHeight(280) * 2,
              height: ScreenUtil().setHeight(280) * 2,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(ScreenUtil().setHeight(280)),
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                  colors: [
                    const Color(0xffFF6787).withOpacity(.6),
                    const Color(0xffFF0036).withOpacity(.8),
                  ],

                  //
                ),
              ),
            ),
          ),
          SafeArea(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/mesita_logo.svg',
                  fit: BoxFit.cover,
                  color: Colors.white,
                  height: ScreenUtil().setHeight(240),
                  width: ScreenUtil().setHeight(240),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(
                top: ScreenUtil().setHeight(260),
                left: ScreenUtil().setWidth(30),
                right: ScreenUtil().setWidth(30),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xffb4b5e5).withOpacity(0.3),
                    spreadRadius: 0,
                    blurRadius: 15,
                    offset: const Offset(0, 5), // changes position of shadow
                  ),
                ],
              ),
              width: double.infinity,
              height: ScreenUtil().setHeight(470),
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _currentPage == PageMostrar.inicioSesion ? inicioSe() : registro(),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget inicioSe() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xffeaeaf5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(5),
                      horizontal: ScreenUtil().setWidth(5),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Center(
                      child: Text(
                        'Iniciar sesión',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(17),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(0),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = PageMostrar.registro;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(5),
                        horizontal: ScreenUtil().setWidth(5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Registrarse',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(32),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  /* border: OutlineInputBorder(
                    //borderSide: BorderSide(color: Colors.white),
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                  ), */
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Ingresa tu correo'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Contraseña'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            width: double.infinity,
            child: Text(
              '¿Olvidaste la contraseña?',
              textAlign: TextAlign.end,
              style: TextStyle(
                color: const Color(0xffa8a7a7),
                fontSize: ScreenUtil().setSp(18),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              elevation: 10,
              onPressed: () {},
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: const Text('Continuar'),
            ),
          )
        ],
      ),
    );
  }

  Widget registro() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: ScreenUtil().setWidth(30)),
      child: Column(
        children: [
          SizedBox(
            height: ScreenUtil().setHeight(10),
          ),
          Container(
            // margin: EdgeInsets.symmetric(
            //   horizontal: ScreenUtil().setWidth(30),
            // ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: const Color(0xffeaeaf5),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _currentPage = PageMostrar.inicioSesion;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: ScreenUtil().setHeight(5),
                        horizontal: ScreenUtil().setWidth(5),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          'Iniciar sesión',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: ScreenUtil().setSp(17),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(10),
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      vertical: ScreenUtil().setHeight(5),
                      horizontal: ScreenUtil().setWidth(5),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(15),
                      border: Border.all(color: Colors.red),
                    ),
                    child: Center(
                      child: Text(
                        'Registrar',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(17),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(32),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Negocio'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Nombre'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.emailAddress,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Email'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              obscureText: _passwordVisible,
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: ScreenUtil().setHeight(15),
                  horizontal: ScreenUtil().setWidth(10),
                ),
                hintStyle: const TextStyle(
                  color: Color(0xffa8a7a7),
                ),
                hintText: 'Contraseña',
                suffixIcon: IconButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    setState(() {
                      if (_passwordVisible) {
                        _passwordVisible = false;
                      } else {
                        _passwordVisible = true;
                      }
                    });
                  },
                  icon: _passwordVisible
                      ? Icon(
                          Icons.visibility,
                          color: Color(0xffa8a7a7),
                        )
                      : Icon(
                          Icons.visibility_off,
                          color: Color(0xffa8a7a7),
                        ),
                ),
              ),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(50),
            child: TextField(
              obscureText: _passwordVisible,
              cursorColor: Colors.transparent,
              keyboardType: TextInputType.text,
              maxLines: 1,
              decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: ScreenUtil().setHeight(5),
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  hintStyle: const TextStyle(
                    color: Color(0xffa8a7a7),
                  ),
                  hintText: 'Confirma contraseña'),
              enableInteractiveSelection: true,
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(30),
          ),
          SizedBox(
            width: double.infinity,
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              elevation: 10,
              onPressed: () {},
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(20.0),
                ),
              ),
              child: const Text('Continuar'),
            ),
          )
        ],
      ),
    );
  }
}
