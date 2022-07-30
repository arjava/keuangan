import 'dart:convert';

HitBackgroundResponse hitBackgroundResponseFromJson(String str) =>
    HitBackgroundResponse.fromJson(json.decode(str));

String hitBackgroundResponseToJson(HitBackgroundResponse data) =>
    json.encode(data.toJson());

class HitBackgroundResponse {
  HitBackgroundResponse({
    this.status,
    this.data,
    this.debugParamSent,
    this.debugLive,
  });

  Status? status;
  Data? data;
  DebugParamSent? debugParamSent;
  String? debugLive;

  factory HitBackgroundResponse.fromJson(Map<String, dynamic> json) =>
      HitBackgroundResponse(
        status: Status.fromJson(json["status"]),
        data: Data.fromJson(json["data"]),
        debugParamSent: DebugParamSent.fromJson(json["debug-param-sent"]),
        debugLive: json["debug-live"],
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": data?.toJson(),
        "debug-param-sent": debugParamSent?.toJson(),
        "debug-live": debugLive,
      };
}

class Data {
  Data({
    this.serverTime,
    this.sender,
  });

  DateTime? serverTime;
  Sender? sender;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        serverTime: DateTime.parse(json["Server-Time"]),
        sender: Sender.fromJson(json["Sender"]),
      );

  Map<String, dynamic> toJson() => {
        "Server-Time": serverTime?.toIso8601String(),
        "Sender": sender?.toJson(),
      };
}

class Sender {
  Sender({
    this.nama,
    this.email,
    this.nohp,
  });

  String? nama;
  String? email;
  String? nohp;

  factory Sender.fromJson(Map<String, dynamic> json) => Sender(
        nama: json["nama"],
        email: json["email"],
        nohp: json["nohp"],
      );

  Map<String, dynamic> toJson() => {
        "nama": nama,
        "email": email,
        "nohp": nohp,
      };
}

class DebugParamSent {
  DebugParamSent({
    this.namaNamanyaEmailEmailnyaMailComNohp083333,
  });

  String? namaNamanyaEmailEmailnyaMailComNohp083333;

  factory DebugParamSent.fromJson(Map<String, dynamic> json) => DebugParamSent(
        namaNamanyaEmailEmailnyaMailComNohp083333: json[
            "{\"nama\":\"namanya\",\"email\":\"emailnya@mail_com\",\"nohp\":\"083333\"}"],
      );

  Map<String, dynamic> toJson() => {
        "{\"nama\":\"namanya\",\"email\":\"emailnya@mail_com\",\"nohp\":\"083333\"}":
            namaNamanyaEmailEmailnyaMailComNohp083333,
      };
}

class Status {
  Status({
    this.error,
    this.login,
    this.apiVer,
    this.devDebugParam,
  });

  int? error;
  bool? login;
  String? apiVer;
  String? devDebugParam;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        error: json["error"],
        login: json["login"],
        apiVer: json["api-ver"],
        devDebugParam: json["dev-debug-param"],
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "login": login,
        "api-ver": apiVer,
        "dev-debug-param": devDebugParam,
      };
}
