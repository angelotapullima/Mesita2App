import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mesita_aplication_2/src/bloc/provider.dart';
import 'package:mesita_aplication_2/src/pages/home.dart';
import 'package:mesita_aplication_2/src/pages/login.dart';
import 'package:mesita_aplication_2/src/pages/splash.dart';
import 'package:mesita_aplication_2/src/preferences/preferences.dart';

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
    return ProviderBloc(
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
          localizationsDelegates: [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: [
            const Locale('es'),
            const Locale('es', 'ES'), // Spanish, no country code
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
          },
        ),
      ),
    );
  }
}
