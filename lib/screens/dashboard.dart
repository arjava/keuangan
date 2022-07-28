import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuangan/utils/Constant.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/home';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xffffffff),
        title: Center(
            child: Text(
          Constants.appName,
          style: TextStyle(color: Color(0xff2787BD)),
        )),
        actions: [
          IconButton(
              onPressed: () {}, icon: Image.asset("assets/btn_notifikasi.png"))
        ],
      ),
    );
  }
}
