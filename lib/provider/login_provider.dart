import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:keuangan/model/failed_login.dart';
import 'package:keuangan/model/response_login.dart';

import '../utils/Constant.dart';

class ApiLoginProvider {
  final String _login = Constants.endpoint("/API/Auth");

  Dio? _dio;

  ApiLoginProvider() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: 50000, connectTimeout: 50000,
      // contentType: Headers.formUrlEncodedContentType,
      // headers: {
      //   "X-Api-Key":
      //   "YUV0MldIcFlNMnQyVDNKQ1ZFWTNiVTlqTnpNckwybDRRVTVpZFdKeVMzaHRjMnN6UW1aaWRrRkxjejA9",
      //   "Content-Type": "application/x-www-form-urlencoded"
      // }
    );
    _dio = Dio(baseOptions);
    _setupLoggingInterceptor();
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
        print("RESPONSE LOGIN Atas");
        return LoginResponse.fromJson(response?.data);
      } else {
        print("RESPONSE LOGIN Bawah");
        return FailedLogin.fromJson(response?.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      // return LoginResponse.withError(_handleError(error));
      return "Exception occured: $error stackTrace: $stacktrace";
    }
  }

  String _handleError(var error) {
    String errorDescription = "";
    if (error is DioError) {
      switch (error.type) {
        case DioErrorType.cancel:
          errorDescription = "Request to API server was cancelled";
          break;
        case DioErrorType.connectTimeout:
          errorDescription = "Connection timeout with API server";
          break;
        case DioErrorType.other:
          errorDescription =
              "Connection to API server failed due to internet connection";
          break;
        case DioErrorType.receiveTimeout:
          errorDescription = "Receive timeout in connection with API server";
          break;
        case DioErrorType.response:
          errorDescription =
              "Received invalid status code: ${error.response?.statusCode}";
          break;
        case DioErrorType.sendTimeout:
          break;
      }
    } else {
      errorDescription = "Unexpected error occured";
    }
    return errorDescription;
  }

  void _setupLoggingInterceptor() {
    int? maxCharactersPerLine = 200;

    _dio?.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      // options.headers['X-Api-Key'] =
      // 'YUV0MldIcFlNMnQyVDNKQ1ZFWTNiVTlqTnpNckwybDRRVTVpZFdKeVMzaHRjMnN6UW1aaWRrRkxjejA9';
      // options.headers['Content-Type'] = 'application/x-www-form-urlencoded';

      print(options.data);
      return handler.next(options);
    }, onResponse: (Response? response, handler) async {
      print(
          "<-- ${response?.statusCode} ${response?.requestOptions.method} ${response?.requestOptions.path}");
      String? responseAsString = response?.data.toString();
      if (responseAsString!.length > maxCharactersPerLine) {
        int? iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int? i = 0; i! <= iterations; i++) {
          int? endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          print(responseAsString.substring(
              i * maxCharactersPerLine, endingIndex));
        }
      } else {
        print(response?.data);
      }
      print("<-- END HTTP");
      return handler.next(response!);
    }, onError: (DioError e, handler) async {
      String errorDescription = "";
      if (e is DioError) {
        switch (e.type) {
          case DioErrorType.cancel:
            errorDescription = "Request to API server was cancelled";
            break;
          case DioErrorType.connectTimeout:
            errorDescription = "Connection timeout with API server";
            break;
          case DioErrorType.other:
            errorDescription =
                "Connection to API server failed due to internet connection";
            break;
          case DioErrorType.receiveTimeout:
            errorDescription = "Receive timeout in connection with API server";
            break;
          case DioErrorType.response:
            errorDescription =
                "Received invalid status code: ${e.response?.statusCode}";
            break;
          case DioErrorType.sendTimeout:
            break;
        }
      } else {
        errorDescription = "Unexpected error occured";
      }

      return handler.next(e);
    }));
    // _dio?.interceptors.add(alice.getDioInterceptor());
  }
}
