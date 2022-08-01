class ResponseTrx {
  ResponseTrx({
    this.status,
    this.data,
    this.debugParamSent,
    this.debugLive,
  });

  Status? status;
  List<Datum>? data;
  DebugParamSent? debugParamSent;
  String? debugLive;

  factory ResponseTrx.fromJson(Map<String, dynamic> json) => ResponseTrx(
        status: Status.fromJson(json["status"]),
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        debugParamSent: DebugParamSent.fromJson(json["debug-param-sent"]),
        debugLive: json["debug-live"],
      );

  Map<String, dynamic> toJson() => {
        "status": status?.toJson(),
        "data": List<dynamic>.from(data!.map((x) => x.toJson())),
        "debug-param-sent": debugParamSent?.toJson(),
        "debug-live": debugLive,
      };
}

class Datum {
  Datum({
    this.trxPtipeNama,
    this.trxCurtipeVar,
    this.trxAsalOutletNama,
    this.trxDarikeOutletId,
    this.trxDarikeOutletNama,
    this.trxId,
    this.trxTgl,
    this.trxPtipe,
    this.trxDateCreated,
    this.trxNominal,
    this.trxKet,
    this.trxStatus,
    this.trxIsStok,
    this.trxAsalOutletId,
    this.trxOutletId,
  });

  String? trxPtipeNama;
  String? trxCurtipeVar;
  String? trxAsalOutletNama;
  String? trxDarikeOutletId;
  String? trxDarikeOutletNama;
  String? trxId;
  DateTime? trxTgl;
  String? trxPtipe;
  DateTime? trxDateCreated;
  String? trxNominal;
  String? trxKet;
  String? trxStatus;
  String? trxIsStok;
  String? trxAsalOutletId;
  String? trxOutletId;

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        trxPtipeNama: json["trx_ptipe_nama"],
        trxCurtipeVar: json["trx_curtipe_var"],
        trxAsalOutletNama: json["trx_asal_outlet_nama"],
        trxDarikeOutletId: json["trx_darike_outlet_id"],
        trxDarikeOutletNama: json["trx_darike_outlet_nama"],
        trxId: json["trx_id"],
        trxTgl: DateTime.parse(json["trx_tgl"]),
        trxPtipe: json["trx_ptipe"],
        trxDateCreated: DateTime.parse(json["trx_date_created"]),
        trxNominal: json["trx_nominal"],
        trxKet: json["trx_ket"],
        trxStatus: json["trx_status"],
        trxIsStok: json["trx_is_stok"],
        trxAsalOutletId: json["trx_asal_outlet_id"],
        trxOutletId: json["trx_outlet_id"],
      );

  Map<String, dynamic> toJson() => {
        "trx_ptipe_nama": trxPtipeNama,
        "trx_curtipe_var": trxCurtipeVar,
        "trx_asal_outlet_nama": trxAsalOutletNama,
        "trx_darike_outlet_id": trxDarikeOutletId,
        "trx_darike_outlet_nama": trxDarikeOutletNama,
        "trx_id": trxId,
        "trx_tgl":
            "${trxTgl?.year.toString().padLeft(4, '0')}-${trxTgl?.month.toString().padLeft(2, '0')}-${trxTgl?.day.toString().padLeft(2, '0')}",
        "trx_ptipe": trxPtipe,
        "trx_date_created": trxDateCreated?.toIso8601String(),
        "trx_nominal": trxNominal,
        "trx_ket": trxKet,
        "trx_status": trxStatus,
        "trx_is_stok": trxIsStok,
        "trx_asal_outlet_id": trxAsalOutletId,
        "trx_outlet_id": trxOutletId,
      };
}

class DebugParamSent {
  DebugParamSent({
    this.actTrxGetOutletId1UserId1DataTrxId0Status1DateStartDateEnd,
  });

  String? actTrxGetOutletId1UserId1DataTrxId0Status1DateStartDateEnd;

  factory DebugParamSent.fromJson(Map<String, dynamic> json) => DebugParamSent(
        actTrxGetOutletId1UserId1DataTrxId0Status1DateStartDateEnd: json[
            "{\"act\":\"trxGet\",\"outlet_id\":1,\"user_id\":1,\"data\":{\"trx_id\":0,\"status\":1,\"date_start\":\"\",\"date_end\":\"\"}}"],
      );

  Map<String, dynamic> toJson() => {
        "{\"act\":\"trxGet\",\"outlet_id\":1,\"user_id\":1,\"data\":{\"trx_id\":0,\"status\":1,\"date_start\":\"\",\"date_end\":\"\"}}":
            actTrxGetOutletId1UserId1DataTrxId0Status1DateStartDateEnd,
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
