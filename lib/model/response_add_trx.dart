import 'dart:convert';

ResponseAddTrx responseAddTrxFromJson(String str) =>
    ResponseAddTrx.fromJson(json.decode(str));

String responseAddTrxToJson(ResponseAddTrx data) => json.encode(data.toJson());

class ResponseAddTrx {
  ResponseAddTrx({
    this.status,
    this.data,
    this.debugParamSent,
    this.debugLive,
  });

  Status? status;
  Data? data;
  DebugParamSent? debugParamSent;
  String? debugLive;

  factory ResponseAddTrx.fromJson(Map<String, dynamic> json) => ResponseAddTrx(
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
    this.trxId,
    this.trxDateCreated,
    this.trxTgl,
    this.trxPtipe,
    this.trxNominal,
    this.trxCurTipe,
    this.trxKet,
    this.trxPhoto,
    this.trxAsalOutletId,
    this.trxDarikeOutletId,
    this.trxBayarVia,
    this.trxUserId,
    this.trxOutletId,
    this.trxStatus,
    this.trxIsStok,
    this.trxDateModif,
    this.trxDeleted,
    this.trxDeletedBy,
    this.trxDeletedKet,
  });

  String? trxId;
  DateTime? trxDateCreated;
  DateTime? trxTgl;
  String? trxPtipe;
  String? trxNominal;
  String? trxCurTipe;
  String? trxKet;
  dynamic trxPhoto;
  String? trxAsalOutletId;
  String? trxDarikeOutletId;
  String? trxBayarVia;
  String? trxUserId;
  String? trxOutletId;
  String? trxStatus;
  String? trxIsStok;
  DateTime? trxDateModif;
  String? trxDeleted;
  String? trxDeletedBy;
  dynamic trxDeletedKet;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        trxId: json["trx_id"],
        trxDateCreated: DateTime.parse(json["trx_date_created"]),
        trxTgl: DateTime.parse(json["trx_tgl"]),
        trxPtipe: json["trx_ptipe"],
        trxNominal: json["trx_nominal"],
        trxCurTipe: json["trx_cur_tipe"],
        trxKet: json["trx_ket"],
        trxPhoto: json["trx_photo"],
        trxAsalOutletId: json["trx_asal_outlet_id"],
        trxDarikeOutletId: json["trx_darike_outlet_id"],
        trxBayarVia: json["trx_bayar_via"],
        trxUserId: json["trx_user_id"],
        trxOutletId: json["trx_outlet_id"],
        trxStatus: json["trx_status"],
        trxIsStok: json["trx_is_stok"],
        trxDateModif: DateTime.parse(json["trx_date_modif"]),
        trxDeleted: json["trx_deleted"],
        trxDeletedBy: json["trx_deleted_by"],
        trxDeletedKet: json["trx_deleted_ket"],
      );

  Map<String, dynamic> toJson() => {
        "trx_id": trxId,
        "trx_date_created": trxDateCreated?.toIso8601String(),
        "trx_tgl":
            "${trxTgl?.year.toString().padLeft(4, '0')}-${trxTgl?.month.toString().padLeft(2, '0')}-${trxTgl?.day.toString().padLeft(2, '0')}",
        "trx_ptipe": trxPtipe,
        "trx_nominal": trxNominal,
        "trx_cur_tipe": trxCurTipe,
        "trx_ket": trxKet,
        "trx_photo": trxPhoto,
        "trx_asal_outlet_id": trxAsalOutletId,
        "trx_darike_outlet_id": trxDarikeOutletId,
        "trx_bayar_via": trxBayarVia,
        "trx_user_id": trxUserId,
        "trx_outlet_id": trxOutletId,
        "trx_status": trxStatus,
        "trx_is_stok": trxIsStok,
        "trx_date_modif": trxDateModif?.toIso8601String(),
        "trx_deleted": trxDeleted,
        "trx_deleted_by": trxDeletedBy,
        "trx_deleted_ket": trxDeletedKet,
      };
}

class DebugParamSent {
  DebugParamSent({
    this.actTrxAddOutletId1UserId1DataPtipe1CurrId1Nominal123KetIniIsiKeteranganPhotoOutletId11OutletId20Tgl20220204,
  });

  String?
      actTrxAddOutletId1UserId1DataPtipe1CurrId1Nominal123KetIniIsiKeteranganPhotoOutletId11OutletId20Tgl20220204;

  factory DebugParamSent.fromJson(Map<String, dynamic> json) => DebugParamSent(
        actTrxAddOutletId1UserId1DataPtipe1CurrId1Nominal123KetIniIsiKeteranganPhotoOutletId11OutletId20Tgl20220204:
            json[
                "{\"act\":\"trxAdd\",\"outlet_id\":1,\"user_id\":1,\"data\":{\"ptipe\":1,\"curr_id\":1,\"nominal\":\"123\",\"ket\":\"ini_isi_keterangan\",\"photo\":\"\",\"outlet_id1\":1,\"outlet_id2\":0,\"tgl\":\"2022-02-04\"}}"],
      );

  Map<String, dynamic> toJson() => {
        "{\"act\":\"trxAdd\",\"outlet_id\":1,\"user_id\":1,\"data\":{\"ptipe\":1,\"curr_id\":1,\"nominal\":\"123\",\"ket\":\"ini_isi_keterangan\",\"photo\":\"\",\"outlet_id1\":1,\"outlet_id2\":0,\"tgl\":\"2022-02-04\"}}":
            actTrxAddOutletId1UserId1DataPtipe1CurrId1Nominal123KetIniIsiKeteranganPhotoOutletId11OutletId20Tgl20220204,
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
