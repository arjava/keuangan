import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MasukPage extends StatefulWidget {
  static const routName = "/dashboard/masuk";
  const MasukPage({Key? key}) : super(key: key);

  @override
  State<MasukPage> createState() => _MasukPageState();
}

class _MasukPageState extends State<MasukPage> {
  final List<String> listItems = ['Outlet', 'Outlet 2', 'Outlet 3'];

  String? selectedValue;

  final _formKey = GlobalKey<FormState>();
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
                style: TextStyle(fontSize: 11),
              ),
              icon: const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              ),
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
                            fontSize: 11,
                          ),
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
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(top: 20, right: 12, left: 12),
        height: MediaQuery.of(context).size.height,
        alignment: Alignment.topCenter,
        color: const Color(0xff2787BD),
        child: Column(
          children: [
            const Text("Start Date"),
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
              child: const Text(
                "29/07/2022",
                style: TextStyle(color: Color(0xff2787BD)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
