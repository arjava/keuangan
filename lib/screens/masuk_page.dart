import 'dart:convert';
import 'dart:developer';
import 'dart:io' as Io;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:keuangan/model/response_add_trx.dart';
import 'package:keuangan/model/response_init_data.dart';
import 'package:keuangan/provider/trx_provider.dart';

import '../common/dashed_line_vertical.dart';
import '../model/failed_login.dart';

class MasukPage extends StatefulWidget {
  final List<OutletSub?>? listOutlet;
  final String? restorationId;

  final List<CurTipe?>? listCurrency;
  const MasukPage(
      {Key? key, this.restorationId, this.listOutlet, this.listCurrency})
      : super(key: key);

  @override
  State<MasukPage> createState() => _MasukPageState();
}

class _MasukPageState extends State<MasukPage> with RestorationMixin {
  String? dateSelected = "";
  DateTime? nowDate;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _imageFileList;
  Io.File? photo1;
  Io.File? photo2;
  Io.File? photo3;
  Io.File? photo4;

  String? _retrieveDataError;

  dynamic _pickImageError;

  var isSelectedValueCur = false;
  void _setImageFileListFromFile(XFile? value) {
    _imageFileList = value == null ? null : <XFile>[value];
  }

  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
      RestorableRouteFuture<DateTime?>(
    onComplete: _selectDate,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDate.value.millisecondsSinceEpoch,
      );
    },
  );

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
  }

  static Route<DateTime> _datePickerRoute(
    BuildContext context,
    Object? arguments,
  ) {
    return DialogRoute<DateTime>(
      context: context,
      builder: (BuildContext context) {
        return DatePickerDialog(
          restorationId: 'date_picker_dialog',
          initialEntryMode: DatePickerEntryMode.calendarOnly,
          initialDate: DateTime.fromMillisecondsSinceEpoch(arguments! as int),
          firstDate: DateTime(2021),
          lastDate: DateTime(2045),
        );
      },
    );
  }

  void _selectDate(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      setState(() {
        _selectedDate.value = newSelectedDate;
        dateSelected =
            "${_selectedDate.value.year.toString().padLeft(2, "0")}-${_selectedDate.value.month.toString().padLeft(2, "0")}-${_selectedDate.value.day}";
      });
    }
  }

  List<OutletSub?>? listOutlet;
  List<CurTipe?>? listCurrency;
  List<String?>? listOutletsName = ['Outlet', 'Outlet 2', 'Outlet 3'];
  List<String?>? listCurrencyName = ['IDR', 'USD', 'SGD'];

  String? selectedValueOutlet = "";
  String? selectedValueCur = "";

  var ctlFieldInput = TextEditingController(text: "0");

  var ctlFieldKeterangan = TextEditingController(text: "");

  @override
  void initState() {
    nowDate = DateTime.now();
    listOutlet = widget.listOutlet;
    listCurrency = widget.listCurrency;
    listOutletsName = widget.listOutlet?.map((e) => e?.outletName).toList();
    listCurrencyName = widget.listCurrency?.map((e) => e?.ctNama).toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle:
            const SystemUiOverlayStyle(statusBarColor: Color(0xffffffff)),
        backgroundColor: const Color(0xffffffff),
        // leading: Container(
        //   margin: const EdgeInsets.only(top: 20),
        //   child: const BackButton(
        //     color: Color(0xff2787BD),
        //   ),
        // ),
        leading: GestureDetector(
          child: Container(
              margin: const EdgeInsets.only(top: 10),
              child:
                  const Icon(Icons.arrow_back_ios, color: Color(0xff2787BD))),
          onTap: () {
            Navigator.pop(context);
          },
        ),
        title: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 10, right: 50),
          child: const Text(
            "Masuk",
            style: TextStyle(color: Color(0xff2787BD)),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(75.0),
          child: Container(
            alignment: Alignment.center,
            width: 100,
            margin: const EdgeInsets.only(top: 20, bottom: 20),
            height: 30,
            decoration: const BoxDecoration(
                color: Color(0xffC1DDED),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    offset: Offset(0.0, 0.3),
                    blurRadius: 0.2,
                    spreadRadius: 0.0,
                  ), //BoxShadow
                ],
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                //Add isDense true and zero Padding.
                //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                isDense: true,
                contentPadding: const EdgeInsets.all(4),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none),
                //Add more decoration as you want here
                //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
              ),
              isExpanded: true,
              hint: const Text(
                'Select Outlet',
                style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2787BD)),
              ),
              icon: Image.asset("assets/arrow_down.png"),
              iconSize: 15,
              buttonHeight: 30,
              buttonWidth: 75,
              buttonElevation: 4,
              buttonPadding: const EdgeInsets.only(left: 10, right: 5),
              dropdownDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(style: BorderStyle.none)),
              items: listOutletsName
                  ?.map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item!,
                          style: const TextStyle(
                              fontSize: 11, color: Color(0xff2787BD)),
                        ),
                      ))
                  .toList(),
              validator: (value) {
                if (value == null) {
                  return 'Please select Outlet.';
                }
              },
              onChanged: (value) {
                selectedValueOutlet = value.toString();
              },
              onSaved: (value) {
                selectedValueOutlet = value.toString();
              },
            ),
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        alignment: Alignment.topCenter,
        color: const Color(0xff2787BD),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Text(
                "Start Date",
                style: TextStyle(color: Color(0xffffffff)),
              ),
              const SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _restorableDatePickerRouteFuture.present();
                },
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 0.3),
                          blurRadius: 0.2,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  child: (dateSelected != null)
                      ? Text(
                          "${_selectedDate.value.day.toString().padLeft(2, '0')}/${_selectedDate.value.month.toString().padLeft(2, '0')}/${_selectedDate.value.year}",
                          style: const TextStyle(color: Color(0xff2787BD)),
                        )
                      : Text(
                          "${nowDate?.day.toString().padLeft(2, '0')}/${nowDate?.month.toString().padLeft(2, '0')}/${nowDate?.year.toString()}",
                          style: const TextStyle(color: Color(0xff2787BD))),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Input", style: TextStyle(color: Color(0xffffffff))),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 0.3),
                        blurRadius: 0.2,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 150,
                      height: 20,
                      child: TextFormField(
                          maxLines: 1,
                          textAlign: TextAlign.end,
                          style: const TextStyle(color: Color(0xff2787BD)),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          autofillHints: const ['0'],
                          cursorColor: const Color(0xff2787BD),
                          controller: ctlFieldInput,
                          decoration: const InputDecoration(
                              isCollapsed: true,
                              isDense: true,
                              alignLabelWithHint: true,
                              border: InputBorder.none,
                              focusColor: Color(0xff2787BD),
                              hoverColor: Color(0xff2787BD),
                              fillColor: Color(0xff2787BD))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    SizedBox(
                      height: 20,
                      child: CustomPaint(
                          size: const Size(1, double.infinity),
                          painter: DashedLineVerticalPainter()),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    (isSelectedValueCur)
                        ? Container()
                        : Image.asset("assets/money_us.png"),
                    SizedBox(
                      height: 20,
                      width: 75,
                      child: DropdownButtonFormField2(
                        decoration: InputDecoration(
                          //Add isDense true and zero Padding.
                          //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                          isDense: true,
                          contentPadding: const EdgeInsets.all(0),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none),
                          //Add more decoration as you want here
                          //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                        ),
                        isExpanded: true,
                        hint: const Text(
                          'IDR',
                          style:
                              TextStyle(fontSize: 11, color: Color(0xff2787BD)),
                        ),
                        icon: Image.asset("assets/arrow_down.png"),
                        iconSize: 15,
                        buttonHeight: 30,
                        buttonWidth: 55,
                        buttonElevation: 4,
                        buttonPadding:
                            const EdgeInsets.only(left: 10, right: 5),
                        dropdownDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(style: BorderStyle.none)),
                        items: listCurrencyName
                            ?.map((item) => DropdownMenuItem<String>(
                                  value: item,
                                  child: Row(
                                    children: [
                                      Image.asset("assets/money_us.png"),
                                      const SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        item!,
                                        style: const TextStyle(
                                            fontSize: 11,
                                            color: Color(0xff2787BD)),
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                        validator: (value) {
                          if (value == null) {
                            return 'Please select currency';
                          }
                        },
                        onChanged: (value) {
                          setState(() {
                            isSelectedValueCur = true;
                          });
                          selectedValueCur = value.toString();
                        },
                        onSaved: (value) {
                          selectedValueCur = value.toString();
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Photo",
                style: TextStyle(color: Color(0xffffffff)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  decoration: const BoxDecoration(
                      color: Color(0xffffffff),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          offset: Offset(0.0, 0.3),
                          blurRadius: 0.2,
                          spreadRadius: 0.0,
                        ), //BoxShadow
                      ],
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          showDialogChoosePhoto(1);
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 4 - 15,
                            height: 63,
                            decoration: const BoxDecoration(
                                color: Color(0xffC1DDED),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(0.0, 0.3),
                                    blurRadius: 0.2,
                                    spreadRadius: 0.0,
                                  ), //BoxShadow
                                ],
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            child: (_imageFileList != null)
                                ? FutureBuilder<void>(
                                    future: retrieveLostData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return const Text(
                                            'You have not yet picked an image.',
                                            textAlign: TextAlign.center,
                                          );
                                        case ConnectionState.done:
                                          return _previewImages(0);
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                              'Pick image error: ${snapshot.error}}',
                                              textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return const Text(
                                              'You have not yet picked an image.',
                                              textAlign: TextAlign.center,
                                            );
                                          }
                                      }
                                    })
                                : Column(
                                    children: [
                                      Image.asset(
                                        "assets/ic_camera.png",
                                        width: 32,
                                        height: 32,
                                      ),
                                      const Text(
                                        "Tambahkan Foto",
                                        textAlign: TextAlign.center,
                                        style:
                                            TextStyle(color: Color(0xff2787BD)),
                                      )
                                    ],
                                  )),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (photo1 != null) {
                            showDialogChoosePhoto(2);
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 4 - 15,
                            height: 63,
                            decoration: BoxDecoration(
                                color: const Color(0xffC1DDED).withOpacity(0.5),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Colors.black,
                                //     offset: Offset(0.0, 0.3),
                                //     blurRadius: 0.2,
                                //     spreadRadius: 0.0,
                                //   ), //BoxShadow
                                // ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: (photo2 != null)
                                ? FutureBuilder<void>(
                                    future: retrieveLostData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return const Text(
                                            'You have not yet picked an image.',
                                            textAlign: TextAlign.center,
                                          );
                                        case ConnectionState.done:
                                          return _previewImages(1);
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                              'Pick image error: ${snapshot.error}}',
                                              textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return const Text(
                                              'You have not yet picked an image.',
                                              textAlign: TextAlign.center,
                                            );
                                          }
                                      }
                                    })
                                : (photo1 != null)
                                    ? Column(
                                        children: [
                                          Image.asset(
                                            "assets/ic_camera.png",
                                            width: 32,
                                            height: 32,
                                          ),
                                          const Text(
                                            "Tambahkan Foto",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff2787BD)),
                                          )
                                        ],
                                      )
                                    : Container()),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (photo1 != null && photo2 != null) {
                            showDialogChoosePhoto(3);
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 4 - 15,
                            height: 63,
                            decoration: BoxDecoration(
                                color: const Color(0xffC1DDED).withOpacity(0.5),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Colors.black,
                                //     offset: Offset(0.0, 0.3),
                                //     blurRadius: 0.2,
                                //     spreadRadius: 0.0,
                                //   ), //BoxShadow
                                // ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: (photo3 != null)
                                ? FutureBuilder<void>(
                                    future: retrieveLostData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return const Text(
                                            'You have not yet picked an image.',
                                            textAlign: TextAlign.center,
                                          );
                                        case ConnectionState.done:
                                          return _previewImages(2);
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                              'Pick image error: ${snapshot.error}}',
                                              textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return const Text(
                                              'You have not yet picked an image.',
                                              textAlign: TextAlign.center,
                                            );
                                          }
                                      }
                                    })
                                : (photo2 != null)
                                    ? Column(
                                        children: [
                                          Image.asset(
                                            "assets/ic_camera.png",
                                            width: 32,
                                            height: 32,
                                          ),
                                          const Text(
                                            "Tambahkan Foto",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff2787BD)),
                                          )
                                        ],
                                      )
                                    : Container()),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (photo1 != null &&
                              photo2 != null &&
                              photo3 != null) {
                            showDialogChoosePhoto(4);
                          }
                        },
                        child: Container(
                            alignment: Alignment.center,
                            width: MediaQuery.of(context).size.width / 4 - 15,
                            height: 63,
                            decoration: BoxDecoration(
                                color: const Color(0xffC1DDED).withOpacity(0.5),
                                // boxShadow: const [
                                //   BoxShadow(
                                //     color: Colors.black,
                                //     offset: Offset(0.0, 0.3),
                                //     blurRadius: 0.2,
                                //     spreadRadius: 0.0,
                                //   ), //BoxShadow
                                // ],
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(12))),
                            child: (photo4 != null)
                                ? FutureBuilder<void>(
                                    future: retrieveLostData(),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<void> snapshot) {
                                      switch (snapshot.connectionState) {
                                        case ConnectionState.none:
                                        case ConnectionState.waiting:
                                          return const Text(
                                            'You have not yet picked an image.',
                                            textAlign: TextAlign.center,
                                          );
                                        case ConnectionState.done:
                                          return _previewImages(3);
                                        default:
                                          if (snapshot.hasError) {
                                            return Text(
                                              'Pick image error: ${snapshot.error}}',
                                              textAlign: TextAlign.center,
                                            );
                                          } else {
                                            return const Text(
                                              'You have not yet picked an image.',
                                              textAlign: TextAlign.center,
                                            );
                                          }
                                      }
                                    })
                                : (photo3 != null)
                                    ? Column(
                                        children: [
                                          Image.asset(
                                            "assets/ic_camera.png",
                                            width: 32,
                                            height: 32,
                                          ),
                                          const Text(
                                            "Tambahkan Foto",
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                                color: Color(0xff2787BD)),
                                          )
                                        ],
                                      )
                                    : Container()),
                      )
                    ],
                  )),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Keterangan",
                style: TextStyle(color: Color(0xffffffff)),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xffffffff),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        offset: Offset(0.0, 0.3),
                        blurRadius: 0.2,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                alignment: Alignment.center,
                padding: const EdgeInsets.all(8),
                width: MediaQuery.of(context).size.width,
                child: SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: TextFormField(
                      maxLines: 1,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Color(0xff2787BD)),
                      cursorColor: const Color(0xff2787BD),
                      controller: ctlFieldKeterangan,
                      decoration: const InputDecoration(
                          isDense: true,
                          isCollapsed: true,
                          alignLabelWithHint: true,
                          border: InputBorder.none,
                          focusColor: Color(0xff2787BD),
                          hoverColor: Color(0xff2787BD),
                          fillColor: Color(0xff2787BD))),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 150.0),
                  child: SizedBox(
                    width: 100,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (selectedValueOutlet!.isEmpty) {
                          showToastError("please select outlet");
                          return;
                        }
                        if (dateSelected!.isEmpty) {
                          dateSelected =
                              "${nowDate?.year.toString()}-${nowDate?.month.toString().padLeft(2, "0")}-${nowDate?.day.toString().padLeft(2, "0")}";
                        }
                        if (ctlFieldInput.text.isEmpty ||
                            ctlFieldInput.text == "0") {
                          showToastError("please input nominal");
                          return;
                        }
                        if (selectedValueCur!.isEmpty) {
                          showToastError("please select currency");
                          return;
                        }
                        if (photo1 == null) {
                          showToastError("please choose one photo");
                          return;
                        }
                        if (ctlFieldKeterangan.text.isEmpty) {
                          showToastError("please input keterangan");
                          return;
                        }
                        // final bytes = await Io.File(image).readAsBytes();
                        final bytes = Io.File(photo1!.path).readAsBytesSync();
                        String base64Encodep1(List<int> bytes) =>
                            base64.encode(bytes);
                        TrxApiProvider _trxApiProvider = TrxApiProvider();
                        Object response = await _trxApiProvider.addTrx(
                            1,
                            int.parse(listCurrency![listCurrency!.indexWhere(
                                    (element) =>
                                        element?.ctNama == selectedValueCur)]!
                                .ctId
                                .toString()),
                            ctlFieldInput.text.toString(),
                            ctlFieldKeterangan.text.toString(),
                            int.parse(listOutlet![listOutlet!.indexWhere(
                                    (element) =>
                                        element?.outletName ==
                                        selectedValueOutlet)]!
                                .id
                                .toString()),
                            0,
                            dateSelected,
                            base64Encodep1(bytes),
                            "",
                            "",
                            "");
                        if (response is ResponseAddTrx) {
                          ResponseAddTrx responseAddTrx =
                              response as ResponseAddTrx;
                          if (responseAddTrx.status!.login!) {
                            showToastSuccess("Success add trx");
                            Navigator.of(context).pop();
                          } else {
                            showToastError("opps terjadi kesalahan");
                          }
                        } else {
                          FailedLogin failedLogin = response as FailedLogin;
                          showToastError("anda belum login.");
                        }
                      },
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                              const Color(0xffC1DDED)),
                          shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)))),
                      child: const Text(
                        "Submit",
                        style: TextStyle(color: Color(0xff2787BD)),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _onImageButtonPressed(ImageSource source,
      {BuildContext? context, int? photo}) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 400,
        maxHeight: 400,
        imageQuality: 70,
      );
      setState(() {
        _setImageFileListFromFile(pickedFile);
        if (photo == 1) {
          photo1 = Io.File(pickedFile!.path);
        } else if (photo == 2) {
          photo2 = Io.File(pickedFile!.path);
        } else if (photo == 3) {
          photo3 = Io.File(pickedFile!.path);
        } else if (photo == 4) {
          photo4 = Io.File(pickedFile!.path);
        }
      });
    } catch (e) {
      setState(() {
        _pickImageError = e;
      });
    }
  }

  Future<void> retrieveLostData() async {
    final LostDataResponse response = await _picker.retrieveLostData();
    if (response.file != null) {
      setState(() {
        if (response.files == null) {
          _setImageFileListFromFile(response.file);
        } else {
          _imageFileList = response.files;
        }
      });
    } else {
      _retrieveDataError = response.exception!.code;
    }
    if (response.isEmpty) {
      return;
    }
  }

  Text? _getRetrieveErrorWidget() {
    if (_retrieveDataError != null) {
      final Text result = Text(_retrieveDataError!);
      _retrieveDataError = null;
      return result;
    }
    return null;
  }

  Widget _previewImages(index) {
    final Text? retrieveError = _getRetrieveErrorWidget();
    Io.File? photo;
    if (index == 0) {
      photo = photo1;
    } else if (index == 1) {
      photo = photo2;
    } else if (index == 2) {
      photo = photo3;
    } else if (index == 3) {
      photo = photo4;
    }
    if (retrieveError != null) {
      return retrieveError;
    }
    if (_imageFileList != null) {
      return Semantics(
        label: 'image_picked_images',
        child: Image.file(Io.File(photo!.path)),
      );
    } else if (_pickImageError != null) {
      return Text(
        'Pick image error: $_pickImageError',
        textAlign: TextAlign.center,
      );
    } else {
      return const Text(
        'You have not yet picked an image.',
        textAlign: TextAlign.center,
      );
    }
  }

  void showDialogChoosePhoto(int? photo) {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: const Center(
                child: Text(
                  "Choose Image",
                  style: TextStyle(color: Color(0xff2787BD)),
                ),
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              content: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TextButton(
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.gallery,
                            context: context, photo: photo);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Gallery")),
                  TextButton(
                      onPressed: () {
                        _onImageButtonPressed(ImageSource.camera,
                            context: context, photo: photo);
                        Navigator.of(context).pop();
                      },
                      child: const Text("Picture"))
                ],
              ),
            ));
  }

  void showToastSuccess(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  void showToastError(String error) {
    Fluttertoast.showToast(
        msg: error,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
