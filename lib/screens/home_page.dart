import 'package:flutter/material.dart';
import 'package:keuangan/bloc/other_bloc.dart';
import 'package:keuangan/model/response_init_data.dart';
import 'package:keuangan/screens/keluar_page.dart';
import 'package:keuangan/screens/kurs_page.dart';
import 'package:keuangan/screens/masuk_page.dart';
import 'package:keuangan/screens/mutasi_page.dart';
import 'package:keuangan/screens/pindah_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  bool _isOpened = false;

  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    otherBloc.getTrx();
    offset = const Offset(0.8, 0);
    super.initState();
  }

  Offset offset = Offset.zero;

  void _slideLeft() {
    setState(() {
      offset -= const Offset(0.8, 0);
      _isOpened = true;
    });
  }

  void _slideRight() {
    setState(() {
      offset += const Offset(0.8, 0);
      _isOpened = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xff2787BD),
      child: Padding(
          padding: const EdgeInsets.only(top: 40),
          child: StreamBuilder<Object>(
              stream: otherBloc.initAll.stream,
              builder: (context, AsyncSnapshot<Object> snapshot) {
                if (snapshot.hasData) {
                  ResponseInitData responseInitData =
                      snapshot.data as ResponseInitData;
                  return Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: const Color(0xffffffff),
                        ),
                        margin: const EdgeInsets.all(12),
                        width: MediaQuery.of(context).size.width - 50,
                        padding: const EdgeInsets.only(right: 40),
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "${responseInitData.data?.outlet?.outletName}, ${responseInitData.data?.outletSubs?.map((e) => e.outletName)}",
                                  textAlign: TextAlign.start,
                                  style: const TextStyle(
                                      color: Color(0xff2787BD),
                                      fontWeight: FontWeight.bold),
                                )),
                            const SizedBox(
                              height: 15,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/money_us.png"),
                                      const SizedBox(width: 5),
                                      Text(
                                          "${responseInitData.data?.curTipe?[0].ctNama}")
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/money_us.png"),
                                      const SizedBox(width: 5),
                                      Text(
                                          "${responseInitData.data?.curTipe?[1].ctNama}")
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/money_us.png"),
                                      const SizedBox(width: 5),
                                      Text(
                                          "${responseInitData.data?.curTipe?[2].ctNama}")
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
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Image.asset("assets/money_us.png"),
                                      const SizedBox(width: 5),
                                      Text(
                                          "${responseInitData.data?.curTipe?[3].ctNama}")
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
                      ),
                      AnimatedSlide(
                        offset: offset,
                        duration: const Duration(milliseconds: 700),
                        curve: Curves.easeInOut,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: 62,
                                  margin:
                                      const EdgeInsets.only(left: 25, top: 11),
                                  child: Image.asset("assets/tray_slide.png",
                                      fit: BoxFit.fill),
                                ),
                                Positioned(
                                    left: -45,
                                    bottom: 0,
                                    top: 0,
                                    child: GestureDetector(
                                        onTap: () {
                                          if (_isOpened) {
                                            _slideRight();
                                            return;
                                          }
                                          _slideLeft();
                                        },
                                        child: Image.asset((_isOpened)
                                            ? "assets/btn_close_slide.png"
                                            : "assets/btn_open_slide.png")))
                              ],
                            ),
                            Container(
                                margin: const EdgeInsets.only(top: 12),
                                decoration: const BoxDecoration(
                                  borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(12),
                                      bottomRight: Radius.circular(12)),
                                  color: Color(0xffC1DDED),
                                ),
                                width: MediaQuery.of(context).size.width - 110,
                                height: MediaQuery.of(context).size.height / 4,
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 12.0, right: 12, bottom: 12),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: [
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: ((context) => MasukPage(
                                                          listOutlet:
                                                              responseInitData
                                                                  .data
                                                                  ?.outletSubs,
                                                          listCurrency:
                                                              responseInitData
                                                                  .data
                                                                  ?.curTipe))));
                                            },
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
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, PindahPage.routName);
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/btn_input_pindah.png"),
                                                const Text(
                                                  "PINDAH",
                                                  style: TextStyle(
                                                      color: Color(0xff2787BD)),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, MutasiPage.routName);
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/btn_input_mutasi.png"),
                                                const Text(
                                                  "MUTASI",
                                                  style: TextStyle(
                                                      color: Color(0xff2787BD)),
                                                )
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, KursPage.routName);
                                            },
                                            child: Column(
                                              children: [
                                                Image.asset(
                                                    "assets/btn_input_kurs.png"),
                                                const Text(
                                                  "KURS",
                                                  style: TextStyle(
                                                      color: Color(0xff2787BD)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(12),
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                          color: const Color(0xffffffff),
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 20),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: const [
                                                  Text(
                                                    "Jumlah Barang",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        color: Color.fromARGB(
                                                            255, 22, 24, 26),
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text("16")
                                                ],
                                              )),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "Total ${responseInitData.data?.curTipe?[0].ctNama}"),
                                                Text(
                                                  "${responseInitData.data?.curTipe?[0].ctLogo} 100.000.000",
                                                  style: const TextStyle(
                                                      color: Color(0xff2787BD),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "Total ${responseInitData.data?.curTipe?[1].ctNama}"),
                                                Text(
                                                  "${responseInitData.data?.curTipe?[1].ctLogo} 2.000",
                                                  style: const TextStyle(
                                                      color: Color(0xff2787BD),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "Total ${responseInitData.data?.curTipe?[3].ctNama}"),
                                                Text(
                                                  "${responseInitData.data?.curTipe?[3].ctLogo} 200.000",
                                                  style: const TextStyle(
                                                      color: Color(0xff2787BD),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 20),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "Total ${responseInitData.data?.curTipe?[2].ctNama}"),
                                                Text(
                                                  "${responseInitData.data?.curTipe?[0].ctLogo} 1.000",
                                                  style: const TextStyle(
                                                      color: Color(0xff2787BD),
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          ],
                        ),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                      child: Text(
                    snapshot.error.toString(),
                  ));
                } else {
                  return const Padding(
                    padding: EdgeInsets.only(top: 175.0),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: Color(0xffffffff),
                      ),
                    ),
                  );
                }
              })),
    );
  }
}
