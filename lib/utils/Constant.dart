// ignore: file_names
import 'package:dio/dio.dart'
    show
        Dio,
        DioError,
        DioErrorType,
        InterceptorsWrapper,
        RequestOptions,
        Response;
import 'package:flutter/foundation.dart';

class Constants {
  static String endpoint(String url) {
    String baseUrl = "dev";
    final buildVariant = baseUrl;
    if (buildVariant == "dev") {
      baseUrl = "http://test-tech.api.jtisrv.com/md/public";
    }
    return baseUrl + url;
  }

  static const String appName = "App Keuangan";
  static const String logoTag = 'com.arjavax.logo';
  static const String titleTag = 'com.arjavax.title';

  static void setupLoggingInterceptor(Dio? dio) {
    int? maxCharactersPerLine = 200;

    dio?.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
      if (kDebugMode) {
        print(options.data);
      }
      return handler.next(options);
    }, onResponse: (Response? response, handler) async {
      if (kDebugMode) {
        print(
            "<-- ${response?.statusCode} ${response?.requestOptions.method} ${response?.requestOptions.path}");
      }
      String? responseAsString = response?.data.toString();
      if (responseAsString!.length > maxCharactersPerLine) {
        int? iterations =
            (responseAsString.length / maxCharactersPerLine).floor();
        for (int? i = 0; i! <= iterations; i++) {
          int? endingIndex = i * maxCharactersPerLine + maxCharactersPerLine;
          if (endingIndex > responseAsString.length) {
            endingIndex = responseAsString.length;
          }
          if (kDebugMode) {
            print(responseAsString.substring(
                i * maxCharactersPerLine, endingIndex));
          }
        }
      } else {
        if (kDebugMode) {
          print(response?.data);
        }
      }
      if (kDebugMode) {
        print("<-- END HTTP");
      }
      return handler.next(response!);
    }, onError: (DioError e, handler) async {
      switch (e.type) {
        case DioErrorType.cancel:
          break;
        case DioErrorType.connectTimeout:
          break;
        case DioErrorType.other:
          break;
        case DioErrorType.receiveTimeout:
          break;
        case DioErrorType.response:
          break;
        case DioErrorType.sendTimeout:
          break;
      }
      return handler.next(e);
    }));
  }

  static String handleError(var error) {
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
}
