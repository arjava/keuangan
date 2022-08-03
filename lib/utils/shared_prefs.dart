import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefs {
  readMember(String? key) async {
    final prefs = await SharedPreferences?.getInstance();
    return await json.decode(prefs.getString(key!)!);
  }

  // saveMember(String key, Result value) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     Map valueMap = json.decode(value.toString());
  //     await prefs.setString(key, json.encode(valueMap));
  //     print("sukses :${json.encode(valueMap)}");
  //   } catch (e) {
  //     print(e.toString());
  //   }
  // }

  removeMember(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }

  saveData(key, String value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(key, value);
    } catch (e) {
      print(e.toString());
    }
  }

  readData(key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  saveDataInt(String key, int value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setInt(key, value);
      if (kDebugMode) {
        print("sukses : $value");
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }

  readDataInt(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(key);
  }

  saveDataBool(key, bool value) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool(key, value);
      print("sukses : $value");
    } catch (e) {
      print(e.toString());
    }
  }

  readDataBool(key) async {
    final prefs = await SharedPreferences?.getInstance();
    return prefs.getBool(key) ?? false;
  }

  clearData() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    } catch (e) {
      print(e.toString());
    }
  }
}
