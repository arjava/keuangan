// import 'dart:ffi';

import 'package:cron/cron.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keuangan/model/response_background_hit.dart';
import 'package:keuangan/provider/cron_provider.dart';
import 'package:keuangan/screens/home_page.dart';
import 'package:keuangan/screens/report_page.dart';
import 'package:keuangan/screens/tools_page.dart';
import 'package:keuangan/screens/transaction_page.dart';
import 'package:keuangan/utils/Constant.dart';

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
        if (kDebugMode) {
          print(DateTime.now());
        }
        CronApiProvider _apiProvider = CronApiProvider();
        Object response = await _apiProvider.hitBackground();
        HitBackgroundResponse responseBackground =
            response as HitBackgroundResponse;
        if (kDebugMode) {
          print(responseBackground.data?.sender?.email);
        }
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
          systemOverlayStyle:
              const SystemUiOverlayStyle(statusBarColor: Color(0xffffffff)),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xffffffff),
          title: SizedBox(
            height: MediaQuery.of(context).size.height / 5,
            width: MediaQuery.of(context).size.width,
            child: const Center(
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
              preferredSize: const Size.fromHeight(75.0),
              child: Container(
                margin: const EdgeInsets.only(bottom: 20),
                child: BottomNavigationBar(
                    currentIndex: indexTab,
                    onTap: (currentIndex) {
                      if (indexTab == 0) {
                        setState(() {
                          indexTab = currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                      } else if (indexTab == 1) {
                        setState(() {
                          indexTab = currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                      } else if (indexTab == 2) {
                        setState(() {
                          indexTab = currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                      } else if (indexTab == 3) {
                        setState(() {
                          indexTab = currentIndex;
                          _pageController.jumpToPage(indexTab);
                        });
                      }
                    },
                    showUnselectedLabels: true,
                    unselectedItemColor:
                        const Color.fromARGB(129, 39, 134, 189),
                    selectedItemColor: const Color(0xff2787BD),
                    elevation: 0,
                    backgroundColor: const Color(0xffffffff),
                    items: [
                      BottomNavigationBarItem(
                          activeIcon: Image.asset("assets/btn_home_aktif.png"),
                          backgroundColor: const Color(0xffffffff),
                          label: "Home",
                          icon: Image.asset("assets/btn_home_non_active.png")),
                      BottomNavigationBarItem(
                          activeIcon:
                              Image.asset("assets/btn_transaksi_aktif.png"),
                          backgroundColor: const Color(0xffffffff),
                          label: "Transaksi",
                          icon: Image.asset(
                              "assets/btn_transaction_non_active.png")),
                      BottomNavigationBarItem(
                          activeIcon:
                              Image.asset("assets/btn_laporan_aktif.png"),
                          backgroundColor: const Color(0xffffffff),
                          label: "Laporan",
                          icon:
                              Image.asset("assets/btn_report_non_active.png")),
                      BottomNavigationBarItem(
                          activeIcon: Image.asset("assets/btn_tools_aktif.png"),
                          backgroundColor: const Color(0xffffffff),
                          label: "Tools",
                          icon: Image.asset("assets/btn_tools_non_active.png"))
                    ]),
              )),
        ),
        body: PageView(
          controller: _pageController,
          children: const <Widget>[
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
        ));
  }
}
