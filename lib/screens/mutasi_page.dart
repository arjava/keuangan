import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../common/dashed_line_vertical.dart';

class MutasiPage extends StatefulWidget {
  static const routName = "/dashboard/mutasi";
  final String? restorationId;
  const MutasiPage({Key? key, this.restorationId}) : super(key: key);

  @override
  State<MutasiPage> createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> with RestorationMixin {
  late StateSetter _setState;
  String? dateSelected;
  String? dateSelectedTo;
  DateTime? nowDate;
  @override
  String? get restorationId => widget.restorationId;
  final RestorableDateTime _selectedDate = RestorableDateTime(DateTime.now());
  final RestorableDateTime _selectedDateTo = RestorableDateTime(DateTime.now());
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

  late final RestorableRouteFuture<DateTime?>
      _restorableDatePickerRouteFutureTo = RestorableRouteFuture<DateTime?>(
    onComplete: _selectDateTo,
    onPresent: (NavigatorState navigator, Object? arguments) {
      return navigator.restorablePush(
        _datePickerRoute,
        arguments: _selectedDateTo.value.millisecondsSinceEpoch,
      );
    },
  );

  @override
  void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
    registerForRestoration(_selectedDate, 'selected_date');
    registerForRestoration(_selectedDateTo, 'selected_date');
    registerForRestoration(
        _restorableDatePickerRouteFuture, 'date_picker_route_future');
    registerForRestoration(
        _restorableDatePickerRouteFutureTo, 'date_picker_route_future');
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
      _setState(() {
        _selectedDate.value = newSelectedDate;
        dateSelected =
            "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
      });
    }
  }

  void _selectDateTo(DateTime? newSelectedDate) {
    if (newSelectedDate != null) {
      _setState(() {
        _selectedDateTo.value = newSelectedDate;
        dateSelectedTo =
            "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}";
      });
    }
  }

  final List<String> listItems = ['Outlet', 'Outlet 2', 'Outlet 3'];

  String? selectedValue;

  var ctlFieldInput = TextEditingController(text: "0");

  @override
  void initState() {
    nowDate = DateTime.now();
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
            "Mutasi",
            style: TextStyle(color: Color(0xff2787BD)),
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(125.0),
          child: Column(
            children: [
              Container(
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
                  items: listItems
                      .map((item) => DropdownMenuItem<String>(
                            value: item,
                            child: Text(
                              item,
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
                    //Do something when changing the item if you want.
                  },
                  onSaved: (value) {
                    selectedValue = value.toString();
                  },
                ),
              ),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return StatefulBuilder(builder: ((context, setState) {
                          _setState = setState;
                          return AlertDialog(
                            title: const Center(
                              child: Text(
                                'Filter',
                                style: TextStyle(
                                    color: Color(0xff2787BD),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            content: SizedBox(
                              height: MediaQuery.of(context).size.height / 5,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    width: 100,
                                    margin: const EdgeInsets.only(
                                        top: 20, bottom: 20),
                                    height: 30,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(12))),
                                    child: DropdownButtonFormField2(
                                      decoration: InputDecoration(
                                        //Add isDense true and zero Padding.
                                        //Add Horizontal padding using buttonPadding and Vertical padding by increasing buttonHeight instead of add Padding here so that The whole TextField Button become clickable, and also the dropdown menu open under The whole TextField Button.
                                        isDense: true,
                                        contentPadding: const EdgeInsets.all(4),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            borderSide: BorderSide.none),
                                        //Add more decoration as you want here
                                        //Add label If you want but add hint outside the decoration to be aligned in the button perfectly.
                                      ),
                                      isExpanded: true,
                                      hint: const Text(
                                        'Jenis Laporan',
                                        style: TextStyle(
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                            color: Color(0xff2787BD)),
                                      ),
                                      icon:
                                          Image.asset("assets/arrow_down.png"),
                                      iconSize: 15,
                                      buttonHeight: 30,
                                      buttonWidth: 75,
                                      buttonElevation: 4,
                                      buttonPadding: const EdgeInsets.only(
                                          left: 10, right: 5),
                                      dropdownDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          border: Border.all(
                                              style: BorderStyle.none)),
                                      items: listItems
                                          .map((item) =>
                                              DropdownMenuItem<String>(
                                                value: item,
                                                child: Text(
                                                  item,
                                                  style: const TextStyle(
                                                      fontSize: 11,
                                                      color: Color(0xff2787BD)),
                                                ),
                                              ))
                                          .toList(),
                                      validator: (value) {
                                        if (value == null) {
                                          return 'select jenis.';
                                        }
                                      },
                                      onChanged: (value) {
                                        //Do something when changing the item if you want.
                                      },
                                      onSaved: (value) {
                                        selectedValue = value.toString();
                                      },
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          const Text(
                                            "Start Date",
                                            style: TextStyle(
                                                color: Color(0xffC1DDED)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _restorableDatePickerRouteFuture
                                                  .present();
                                            },
                                            child: Container(
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
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              child: (dateSelected != null)
                                                  ? Text(
                                                      "${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff2787BD)),
                                                    )
                                                  : Text(
                                                      "${nowDate?.day.toString().padLeft(2, '0')}/${nowDate?.month.toString().padLeft(2, '0')}/${nowDate?.year.toString()}",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff2787BD))),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Column(
                                        children: [
                                          const Text(
                                            "To Date",
                                            style: TextStyle(
                                                color: Color(0xffC1DDED)),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _restorableDatePickerRouteFutureTo
                                                  .present();
                                            },
                                            child: Container(
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
                                                      BorderRadius.all(
                                                          Radius.circular(12))),
                                              alignment: Alignment.center,
                                              padding: const EdgeInsets.all(8),
                                              child: (dateSelectedTo != null)
                                                  ? Text(
                                                      "${_selectedDateTo.value.day}/${_selectedDateTo.value.month}/${_selectedDateTo.value.year}",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff2787BD)),
                                                    )
                                                  : Text(
                                                      "${nowDate?.day.toString().padLeft(2, '0')}/${nowDate?.month.toString().padLeft(2, '0')}/${nowDate?.year.toString()}",
                                                      style: const TextStyle(
                                                          color: Color(
                                                              0xff2787BD))),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                            actions: <Widget>[
                              Center(
                                child: TextButton(
                                  style: ButtonStyle(
                                      backgroundColor:
                                          MaterialStateProperty.all(
                                              const Color(0xff2787BD))),
                                  onPressed: () => Navigator.pop(context, 'OK'),
                                  child: const Text(
                                    'Submit',
                                    style: TextStyle(
                                        color: Color(0xffffffff),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          );
                        }));
                      });
                },
                child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    margin:
                        const EdgeInsets.only(bottom: 20, right: 30, left: 30),
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
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text(
                          "Jenis Laporan",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xff2787BD)),
                        ),
                        const Text(
                          "19/10/2012 - 19/10/2012",
                          style: TextStyle(color: Color(0xff2787BD)),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Image.asset("assets/arrow_down.png"))
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        color: const Color(0xff2787BD),
        child: Column(
          children: [
            const Text("Dari", style: TextStyle(color: Color(0xffffffff))),
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
                  Image.asset("assets/money_us.png"),
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
                      buttonPadding: const EdgeInsets.only(left: 10, right: 5),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(style: BorderStyle.none)),
                      items: listItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 11, color: Color(0xff2787BD)),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Ke", style: TextStyle(color: Color(0xffffffff))),
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
                  Image.asset("assets/money_us.png"),
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
                      buttonPadding: const EdgeInsets.only(left: 10, right: 5),
                      dropdownDecoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(style: BorderStyle.none)),
                      items: listItems
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                  style: const TextStyle(
                                      fontSize: 11, color: Color(0xff2787BD)),
                                ),
                              ))
                          .toList(),
                      validator: (value) {
                        if (value == null) {
                          return 'Please select gender.';
                        }
                      },
                      onChanged: (value) {
                        //Do something when changing the item if you want.
                      },
                      onSaved: (value) {
                        selectedValue = value.toString();
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
