import 'dart:convert';

RequestAddTrx requestAddTrxFromJson(String str) =>
    RequestAddTrx.fromJson(json.decode(str));

String requestAddTrxToJson(RequestAddTrx data) => json.encode(data.toJson());

class RequestAddTrx {
  RequestAddTrx({
    this.ptipe,
    this.currId,
    this.nominal,
    this.ket,
    this.photo,
    this.outletId1,
    this.outletId2,
    this.tgl,
  });

  int? ptipe;
  int? currId;
  String? nominal;
  String? ket;
  String? photo;
  int? outletId1;
  int? outletId2;
  String? tgl;

  factory RequestAddTrx.fromJson(Map<String, dynamic> json) => RequestAddTrx(
        ptipe: json["ptipe"],
        currId: json["curr_id"],
        nominal: json["nominal"],
        ket: json["ket"],
        photo: json["photo"],
        outletId1: json["outlet_id1"],
        outletId2: json["outlet_id2"],
        tgl: json["tgl"],
      );

  Map<String, dynamic> toJson() => {
        "ptipe": ptipe,
        "curr_id": currId,
        "nominal": nominal,
        "ket": ket,
        "photo": photo,
        "outlet_id1": outletId1,
        "outlet_id2": outletId2,
        "tgl": tgl,
      };
}
