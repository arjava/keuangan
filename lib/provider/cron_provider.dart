import 'package:dio/dio.dart';
import 'package:keuangan/model/response_background_hit.dart';
import 'package:keuangan/utils/Constant.dart';

class CronApiProvider {
  final String _hitBackground = Constants.endpoint("/API/BgService/Hit");

  Dio? _dio;
  CronApiProvider() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: 50000,
      connectTimeout: 50000,
    );
    _dio = Dio(baseOptions);
    Constants.setupLoggingInterceptor(_dio);
  }

  Future<Object> hitBackground() async {
    try {
      Response? response = await _dio?.post(_hitBackground, data: {
        "nama": "Abdurrokhman",
        "email": "arjava379@gmail.com",
        "nohp": "08988825256",
      });
      // var valueMap = json.decode(response?.data);
      if (response?.data['status']['error'] == 0) {
        print("RESPONSE LOGIN Atas");
        return HitBackgroundResponse.fromJson(response?.data);
      } else {
        print("RESPONSE LOGIN Bawah");
        return HitBackgroundResponse.fromJson(response?.data);
      }
    } catch (error, stacktrace) {
      print("Exception occured: $error stackTrace: $stacktrace");
      return "Exception occured: $error stackTrace: $stacktrace";
    }
  }
}
