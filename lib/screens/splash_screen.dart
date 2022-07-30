import 'package:flutter/material.dart';
import 'package:keuangan/utils/shared_prefs.dart';

class SplashScreen extends StatefulWidget {
  static const routName = "/splash";
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  SharedPrefs sharedPrefs = SharedPrefs();
  @override
  void initState() {
    if (mounted) {
      checkSession();
    }
    super.initState();
  }

  void checkSession() async {
    if (sharedPrefs.readData("reg_member_id") != null) {
      Navigator.pushNamed(context, "/dashboard");
    } else {
      Navigator.pushNamed(context, "/auth");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            color: Color(0xffffffff),
            child: Image.asset(
              "assets/logo_jni.png",
              width: 150,
              height: 150,
            )),
      ),
    );
  }
}
