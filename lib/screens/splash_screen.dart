import 'package:flutter/material.dart';
import 'package:keuangan/screens/dashboard.dart';
import 'package:keuangan/screens/login_page.dart';
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
      Future.delayed(const Duration(seconds: 2), () {
        checkSession();
      });
    }
    super.initState();
  }

  void checkSession() async {
    if (sharedPrefs.readData("reg_member_id") != null) {
      // Navigator.pushNamed(context, "/dashboard");
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => DashboardScreen()));
    } else {
      // Navigator.pushNamed(context, "/auth");
      Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
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
