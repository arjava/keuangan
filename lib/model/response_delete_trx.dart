import 'dart:convert';

ResponseDeleteTrx responseDeleteTrxFromJson(String str) =>
    ResponseDeleteTrx.fromJson(json.decode(str));

String responseDeleteTrxToJson(ResponseDeleteTrx data) =>
    json.encode(data.toJson());

class ResponseDeleteTrx {
  ResponseDeleteTrx({
    this.status,
    this.data,
    this.debugParamSent,
    this.debugLive,
  });

  Status? status;
  bool? data;
  DebugParamSent? debugParamSent;
  String? debugLive;

  factory ResponseDeleteTrx.fromJson(Map<String, dynamic> json) =>
      ResponseDeleteTrx(
        status: Status.fromJson(json["status"]),
        data: json["data"],
        debugParamSent: DebugParamSent.fromJson(json["debug-param-sent"]),
        debugLive: json["debug-live"],
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data,
        "debug-param-sent": debugParamSent?.toJson(),
        "debug-live": debugLive,
      };
}

class DebugParamSent {
  DebugParamSent({
    this.actTrxDelOutletId1UserId1DataTrxId12334245,
  });

  String? actTrxDelOutletId1UserId1DataTrxId12334245;

  factory DebugParamSent.fromJson(Map<String, dynamic> json) => DebugParamSent(
        actTrxDelOutletId1UserId1DataTrxId12334245: json[
            "{\"act\":\"trxDel\",\"outlet_id\":1,\"user_id\":1,\"data\":{\"trx_id\":12334245}}"],
      );

  Map<String, dynamic> toJson() => {
        "{\"act\":\"trxDel\",\"outlet_id\":1,\"user_id\":1,\"data\":{\"trx_id\":12334245}}":
            actTrxDelOutletId1UserId1DataTrxId12334245,
      };
}

class Status {
  Status({
    this.error,
    this.login,
    this.userId,
    this.role,
    this.apiVer,
    this.devDebugParam,
  });

  int? error;
  bool? login;
  String? userId;
  String? role;
  String? apiVer;
  String? devDebugParam;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        error: json["error"],
        login: json["login"],
        userId: json["user_id"],
        role: json["role"],
        apiVer: json["api-ver"],
        devDebugParam: json["dev-debug-param"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "login": login,
        "user_id": userId,
        "role": role,
        "api-ver": apiVer,
        "dev-debug-param": devDebugParam,
      };
}
