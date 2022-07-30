// import 'dart:ffi';

import 'package:cron/cron.dart';
import 'package:floating_navbar/floating_navbar.dart';
import 'package:floating_navbar/floating_navbar_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keuangan/model/response_background_hit.dart';
import 'package:keuangan/provider/cron_provider.dart';
import 'package:keuangan/screens/home_page.dart';
import 'package:keuangan/screens/report_page.dart';
import 'package:keuangan/screens/tools_page.dart';
import 'package:keuangan/screens/transaction_page.dart';
import 'package:keuangan/utils/Constant.dart';
import 'package:shape_of_view_null_safe/shape_of_view_null_safe.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  var indexTab = 0;
  final PageController _pageController = PageController();

  @override
  void initState() {
    startCron();
    super.initState();
  }

  Future<void> startCron() async {
    final cron = Cron();

    try {
      cron.schedule(Schedule.parse('0/30 * * * * ?'), () async {
        print(DateTime.now());
        CronApiProvider _apiProvider = CronApiProvider();
        Object response = await _apiProvider.hitBackground();
        HitBackgroundResponse responseBackground =
            response as HitBackgroundResponse;
        print(responseBackground.data?.sender?.email);
      });

      // await Future.delayed(Duration(seconds: 30));
      // await cron.close();
    } on ScheduleParseException {
      // "ScheduleParseException" is thrown if cron parsing is failed.
      // await cron.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Container(
          margin: EdgeInsets.only(top: 25),
          child: Image.asset(
            "assets/ic_refresh.png",
            width: 100,
            height: 50,
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
        appBar: AppBar(
          backgroundColor: Color(0xffffffff),
          title: Container(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            child: Center(
                child: Text(
              Constants.appName,
              style: TextStyle(color: Color(0xff2787BD)),
            )),
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Image.asset("assets/btn_notifikasi.png"))
          ],
          bottom: PreferredSize(
              child: Container(
                margin: EdgeInsets.only(bottom: 20),
                child: BottomNavigationBar(
                    currentIndex: indexTab,
                    onTap: (_currentIndex) {
                      if (indexTab == 0) {
                        setState(() {
                          indexTab = _currentIndex;
                          SnackBar(content: Text("Home Page"));
                          _pageController.jumpToPage(indexTab);
                          // Navigator.pushNamed(context, '/home');
                          // Navigator.push(
                          // context,
                          // MaterialPageRoute(
                          // builder: (context) => HomePage()));
                        });
                      } else if (indexTab == 1) {
                        setState(() {
                          indexTab = _currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                        SnackBar(content: Text("Transaksi Page"));
                      } else if (indexTab == 2) {
                        setState(() {
                          indexTab = _currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                        SnackBar(content: Text("Report Page"));
                      } else if (indexTab == 3) {
                        setState(() {
                          indexTab = _currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                        SnackBar(content: Text("Tools Page"));
                      }
                    },
                    showUnselectedLabels: true,
                    unselectedItemColor: Color.fromARGB(129, 39, 134, 189),
                    selectedItemColor: Color(0xff2787BD),
                    elevation: 0,
                    backgroundColor: Color(0xffffffff),
                    items: [
                      BottomNavigationBarItem(
                          activeIcon: Image.asset("assets/btn_home_aktif.png"),
                          backgroundColor: Color(0xffffffff),
                          label: "Home",
                          icon: Image.asset("assets/btn_home_non_active.png")),
                      BottomNavigationBarItem(
                          activeIcon:
                              Image.asset("assets/btn_transaksi_aktif.png"),
                          backgroundColor: Color(0xffffffff),
                          label: "Transaksi",
                          icon: Image.asset(
                              "assets/btn_transaction_non_active.png")),
                      BottomNavigationBarItem(
                          activeIcon:
                              Image.asset("assets/btn_laporan_aktif.png"),
                          backgroundColor: Color(0xffffffff),
                          label: "Laporan",
                          icon:
                              Image.asset("assets/btn_report_non_active.png")),
                      BottomNavigationBarItem(
                          activeIcon: Image.asset("assets/btn_tools_aktif.png"),
                          backgroundColor: Color(0xffffffff),
                          label: "Tools",
                          icon: Image.asset("assets/btn_tools_non_active.png"))
                    ]),
              ),
              preferredSize: Size.fromHeight(75.0)),
        ),
        body: PageView(
          controller: _pageController,
          children: <Widget>[
            HomePage(),
            TransactionPage(),
            ReportPage(),
            ToolsPage()
          ],
          onPageChanged: (page) {
            setState(() {
              indexTab = page;
            });
          },
        )
        // Material(
        //   child: FloatingNavBar(
        //       index: indexTab,
        //       resizeToAvoidBottomInset: true,
        //       horizontalPadding: 20,
        //       items: [
        //         FloatingNavBarItem(
        //             icon: ImageIcon(AssetImage("assets/btn_home_aktif.png")),
        //             useImageIcon: true,
        //             title: "Home",
        //             page: HomePage()),
        //         FloatingNavBarItem(
        //             icon: ImageIcon(
        //                 AssetImage("assets/btn_transaction_non_active.png")),
        //             useImageIcon: true,
        //             title: "Transaksi",
        //             page: TransactionPage()),
        //         FloatingNavBarItem(
        //             icon:
        //                 ImageIcon(AssetImage("assets/btn_report_non_active.png")),
        //             useImageIcon: true,
        //             title: "Laporan",
        //             page: ReportPage()),
        //         FloatingNavBarItem(
        //             icon:
        //                 ImageIcon(AssetImage("assets/btn_tools_non_active.png")),
        //             useImageIcon: true,
        //             title: "Tools",
        //             page: ToolsPage())
        //       ],
        //       color: Color(0xffffffff),
        //       hapticFeedback: true),
        // ),
        );
  }
}
