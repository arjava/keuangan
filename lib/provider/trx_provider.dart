import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:keuangan/model/request_add_trx.dart';
import 'package:keuangan/model/response_trx.dart';
import 'package:keuangan/utils/Constant.dart';
import '../model/ItemTrx.dart';
import '../model/failed_login.dart';
import '../utils/Constant.dart';

class TrxApiProvider {
  final String _trxGet = Constants.endpoint("/API/Trx/Get");
  final String _trxAdd = Constants.endpoint("/API/Trx/Add");
  final String _trxDelete = Constants.endpoint("/API/Trx/Del");

  Dio? _dio;

  TrxApiProvider() {
    BaseOptions baseOptions = BaseOptions(
      receiveTimeout: 50000,
      connectTimeout: 50000,
    );
    _dio = Dio(baseOptions);
    Constants.setupLoggingInterceptor(_dio);
  }

  Future<Object> getTrx() async {
    try {
      Response? response = await _dio?.post(_trxGet, data: {
        "act": "trxGet",
        "outlet_id": 1,
        "user_id": 1,
        "data": ItemTrx(trxId: 0, status: 1, dateStart: "", dateEnd: "")
      });
      if (response?.data['status']['error'] == 0) {
        if (kDebugMode) {
          print("RESPONSE LOGIN Atas");
        }
        return ResponseTrx.fromJson(response?.data);
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

  Future<Object> addTrx(
      int ptipe,
      int? currId,
      String nominal,
      String ket,
      int? outletId1,
      int? outletId2,
      String? tanggal,
      String photo,
      String photo2,
      String photo3,
      String photo4) async {
    try {
      Response? response = await _dio?.post(_trxAdd, data: {
        "act": "trxAdd",
        "outlet_id": 1,
        "user_id": 1,
        "data": RequestAddTrx(
            ptipe: ptipe,
            currId: currId,
            ket: ket,
            nominal: nominal,
            outletId1: outletId1,
            outletId2: outletId2,
            tgl: tanggal.toString(),
            photo: photo)
      });
      if (response?.data['status']['login'] == true) {
        return ResponseTrx.fromJson(response?.data);
      } else {
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
