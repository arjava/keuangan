import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keuangan/utils/shared_prefs.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  static const routName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SystemUiOverlayStyle _currentStyle = SystemUiOverlayStyle.light;

  int? isLogged;

  @override
  void initState() {
    setState(() {
      _currentStyle = SystemUiOverlayStyle.dark.copyWith(
        statusBarColor: const Color(0xffffffff),
      );

      // if (kDebugMode) {
      //   print("SHARED LOG: $isLogged");
      // }
    });
    if (mounted) {
      Future.delayed(const Duration(seconds: 2), () {
        checkSession();
      });
    }
    super.initState();
  }

  void checkSession() async {
    // Obtain shared preferences.
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the 'counter' key. If it doesn't exist, returns null.
    isLogged = prefs.getInt('reg_member_id');
    if (isLogged == 1) {
      Navigator.pushNamed(context, "/dashboard");
    } else {
      Navigator.pushNamed(context, "/auth");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      body: Center(
        child: Container(
            color: const Color(0xffffffff),
            child: Image.asset(
              "assets/logo_jni.png",
              width: 150,
              height: 150,
            )),
      ),
    );
  }
}
