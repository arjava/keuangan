import 'package:flutter/material.dart';
import 'package:keuangan/screens/login_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ToolsPage extends StatelessWidget {
  const ToolsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        color: const Color(0xff2787BD),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("Tools"),
            const SizedBox(
              height: 20,
            ),
            TextButton(
                style: ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith(
                        (states) => const Color(0xffffffff))),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Navigator.pushNamed(context, LoginPage.routeName);
                },
                child: const Text("Logout"))
          ],
        )),
      ),
    );
  }

  Future<bool> removeSession() async {
    final prefs = await SharedPreferences.getInstance();
    final success = await prefs.remove('reg_member_id');
    return success;
  }
}
