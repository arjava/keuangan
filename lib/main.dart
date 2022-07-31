import 'package:flutter/material.dart';
import 'package:keuangan/screens/dashboard.dart';
import 'package:keuangan/screens/keluar_page.dart';
import 'package:keuangan/screens/kurs_page.dart';
import 'package:keuangan/screens/login_page.dart';
import 'package:keuangan/screens/masuk_page.dart';
import 'package:keuangan/screens/mutasi_page.dart';
import 'package:keuangan/screens/pindah_page.dart';
import 'package:keuangan/screens/splash_screen.dart';
import 'package:keuangan/utils/transaction_route_observer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Keuangan',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textSelectionTheme:
            const TextSelectionThemeData(cursorColor: Colors.orange),
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          headline3: const TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.orange,
          ),
          button: const TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.deepPurple[300],
          ),
          headline1: const TextStyle(fontFamily: 'Quicksand'),
          headline2: const TextStyle(fontFamily: 'Quicksand'),
          headline4: const TextStyle(fontFamily: 'Quicksand'),
          headline5: const TextStyle(fontFamily: 'NotoSans'),
          headline6: const TextStyle(fontFamily: 'NotoSans'),
          subtitle1: const TextStyle(fontFamily: 'NotoSans'),
          bodyText1: const TextStyle(fontFamily: 'NotoSans'),
          bodyText2: const TextStyle(fontFamily: 'NotoSans'),
          subtitle2: const TextStyle(fontFamily: 'NotoSans'),
          overline: const TextStyle(fontFamily: 'NotoSans'),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
            .copyWith(secondary: Colors.orange),
      ),
      navigatorObservers: [TransitionRouteObserver()],
      initialRoute: SplashScreen.routName,
      routes: {
        SplashScreen.routName: (context) => const SplashScreen(),
        LoginPage.routeName: (context) => const LoginPage(),
        DashboardScreen.routeName: (context) => const DashboardScreen(),
        MasukPage.routName: ((context) => const MasukPage()),
        KeluarPage.routName: ((context) => const KeluarPage()),
        PindahPage.routName: ((context) => const PindahPage()),
        MutasiPage.routName: ((context) => const MutasiPage()),
        KursPage.routName: ((context) => const KursPage())
      },
    );
  }
}
