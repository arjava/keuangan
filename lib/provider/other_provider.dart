import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../model/failed_login.dart';
import '../model/response_init_data.dart';
import '../utils/Constant.dart';

class OtherProvider {
  final String _initData = Constants.endpoint("/API/Auth/initData");

  Dio? _dio;

  OtherProvider() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: 50000,
      connectTimeout: 50000,
    );
    _dio = Dio(baseOptions);
    Constants.setupLoggingInterceptor(_dio);
  }

  Future<Object> getInitData() async {
    try {
      Response? response = await _dio
          ?.post(_initData, data: {"act": "initData", "outlet_id": 1});
      // var valueMap = json.decode(response?.data);
      if (response?.data['status']['error'] == 0) {
        if (kDebugMode) {
          print("RESPONSE LOGIN Atas");
        }
        return ResponseInitData.fromJson(response?.data);
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
