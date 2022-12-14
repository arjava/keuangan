import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:keuangan/model/failed_login.dart';
import 'package:keuangan/model/response_login.dart';

import '../utils/Constant.dart';

class ApiLoginProvider {
  final String _login = Constants.endpoint("/API/Auth");

  Dio? _dio;

  ApiLoginProvider() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: 50000,
      connectTimeout: 50000,
    );
    _dio = Dio(baseOptions);
    Constants.setupLoggingInterceptor(_dio);
  }

  Future<Object> getUserLogin(username, password) async {
    try {
      Response? response = await _dio?.post(_login, data: {
        "act": "LOGIN",
        "un": username,
        "up": password,
      });
      // var valueMap = json.decode(response?.data);
      if (response?.data['status']['error'] == 0) {
        if (kDebugMode) {
          print("RESPONSE LOGIN Atas");
        }
        return LoginResponse.fromJson(response?.data);
      } else {
        if (kDebugMode) {
          print("RESPONSE LOGIN Bawah");
        }
        return FailedLogin.fromJson(response?.data);
      }
    } catch (error, stacktrace) {
      if (kDebugMode) {
        print("Exception occured: $error stackTrace: $stacktrace");
      }
      return "Exception occured: $error stackTrace: $stacktrace";
    }
  }
}
