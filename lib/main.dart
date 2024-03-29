import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/pages/Comidas/comidas_page.dart';
import 'package:mesita_aplication_2/src/pages/Renovacion_Plan/mostrar_planes.dart';
import 'package:mesita_aplication_2/src/pages/Renovacion_Plan/solicitud_pendiente.dart';
import 'package:mesita_aplication_2/src/pages/User/Planes/Pagos/bloc_pago.dart';
import 'package:mesita_aplication_2/src/pages/home.dart';
import 'package:mesita_aplication_2/src/pages/login.dart';
import 'package:mesita_aplication_2/src/pages/splash.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = Preferences();
  await prefs.initPrefs();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PagoBLoc>(
          create: (_) => PagoBLoc(),
        ),
        ChangeNotifierProvider<CategoryController>(
          create: (_) => CategoryController(),
        ),
      ],
      child: ProviderBloc(
        child: ScreenUtilInit(
          designSize: const Size(375, 812),
          builder: () => MaterialApp(
            title: 'Flutter Demo',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              textTheme: GoogleFonts.poppinsTextTheme(),
            ),
            builder: (BuildContext context, Widget child) {
              final MediaQueryData data = MediaQuery.of(context);
              return MediaQuery(
                data: data.copyWith(
                  textScaleFactor: data.textScaleFactor > 2.0 ? 1.2 : data.textScaleFactor,
                ),
                child: child,
              );
            },
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: const [
              Locale('es'),
              Locale('es', 'ES'), // Spanish, no country code
              //const Locale('en', 'EN'), // English, no country code
            ],
            localeResolutionCallback: (Locale locale, Iterable<Locale> supportedLocales) {
              //print("change language");
              return locale;
            },
            initialRoute: 'splash',
            routes: {
              'splash': (BuildContext context) => const Splash(),
              'home': (BuildContext context) => const Home(),
              'login': (BuildContext context) => const Login(),
              'planes': (BuildContext context) => const MostrarPlanesPage(),
              'solicituPlan': (BuildContext context) => const SolicitudPendiente(),
            },
          ),
        ),
      ),
    );
  }
}
