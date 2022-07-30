import 'package:dio/dio.dart';

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

  static void setupLoggingInterceptor(Dio? _dio) {
    int? maxCharactersPerLine = 200;

    _dio?.interceptors.add(
        InterceptorsWrapper(onRequest: (RequestOptions options, handler) async {
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
