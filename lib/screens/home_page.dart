import 'package:flutter/material.dart';
import 'package:keuangan/screens/keluar_page.dart';
import 'package:keuangan/screens/masuk_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: false);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(1.5, 0.0),
  ).animate(CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticIn,
  ));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2787BD),
      child: Column(
        children: [
          Center(
              child: Container(
                  margin: EdgeInsets.only(top: 40, right: 20, left: 20),
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(12.0),
                  decoration: BoxDecoration(
                      color: Color(0xffffffff),
                      borderRadius: BorderRadius.circular(12)),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Text(
                                "Nama Outlet",
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    color: Color(0xff2787BD),
                                    fontWeight: FontWeight.bold),
                              )),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/money_us.png"),
                                    const SizedBox(width: 5),
                                    const Text("IDR")
                                  ],
                                ),
                                const Text(
                                  "500.000",
                                  style: TextStyle(
                                      color: Color(0xff2787BD),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/money_us.png"),
                                    const SizedBox(width: 5),
                                    const Text("USD")
                                  ],
                                ),
                                const Text(
                                  "0",
                                  style: TextStyle(
                                      color: Color(0xff2787BD),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/money_us.png"),
                                    const SizedBox(width: 5),
                                    const Text("EUR")
                                  ],
                                ),
                                const Text(
                                  "20.000",
                                  style: TextStyle(
                                      color: Color(0xff2787BD),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Image.asset("assets/money_us.png"),
                                    const SizedBox(width: 5),
                                    const Text("SGD")
                                  ],
                                ),
                                const Text(
                                  "6.000",
                                  style: TextStyle(
                                      color: Color(0xff2787BD),
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          )
                        ],
                      ),
                      Container(
                          padding: EdgeInsets.all(12.0),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage("assets/tray_slide_full.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, MasukPage.routName);
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Image.asset(
                                              "assets/btn_input_masuk.png"),
                                          const Text(
                                            "MASUK",
                                            style: TextStyle(
                                                color: Color(0xff2787BD)),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pushNamed(
                                          context, KeluarPage.routName);
                                    },
                                    child: Column(
                                      children: [
                                        Image.asset(
                                            "assets/btn_input_keluar.png"),
                                        const Text(
                                          "KELUAR",
                                          style: TextStyle(
                                              color: Color(0xff2787BD)),
                                        )
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                          "assets/btn_input_pindah.png"),
                                      const Text(
                                        "PINDAH",
                                        style:
                                            TextStyle(color: Color(0xff2787BD)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset(
                                          "assets/btn_input_mutasi.png"),
                                      const Text(
                                        "MUTASI",
                                        style:
                                            TextStyle(color: Color(0xff2787BD)),
                                      )
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      Image.asset("assets/btn_input_kurs.png"),
                                      const Text(
                                        "KURS",
                                        style:
                                            TextStyle(color: Color(0xff2787BD)),
                                      )
                                    ],
                                  )
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.all(8),
                                padding: EdgeInsets.all(8),
                                color: Color(0xffffffff),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: const [
                                            Text(
                                              "Jumlah Barang",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 22, 24, 26),
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text("16")
                                          ],
                                        )),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("Total IDR"),
                                          Text(
                                            "Rp 100.000.000",
                                            style: TextStyle(
                                                color: Color(0xff2787BD),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("Total USD"),
                                          Text(
                                            "\$ 2.000",
                                            style: TextStyle(
                                                color: Color(0xff2787BD),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("Total EUR"),
                                          Text(
                                            "E 200.000",
                                            style: TextStyle(
                                                color: Color(0xff2787BD),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 20),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Text("Total SGD"),
                                          Text(
                                            "\$\$ 1.000",
                                            style: TextStyle(
                                                color: Color(0xff2787BD),
                                                fontWeight: FontWeight.bold),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          )),
                      // Positioned(
                      //     right: 0.0,
                      //     child: Image.asset("assets/tray_slide.png"))
                    ],
                  ))),
          // SlideTransition(
          //   position: _offsetAnimation,
          //   child: Container(
          //     padding: EdgeInsets.all(8.0),
          //     child: Image.asset("assets/tray_slide_full.png"),
          //   ),
          // )
        ],
      ),
    );
  }
}
