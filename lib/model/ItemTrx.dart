class ItemTrx {
  ItemTrx({this.trxId, this.status, this.dateStart, this.dateEnd});

  int? trxId;
  int? status;
  String? dateStart;
  String? dateEnd;

  factory ItemTrx.fromJson(Map<String, dynamic> json) => ItemTrx(
      trxId: json["trx_id"],
      status: json["status"],
      dateStart: json["date_start"],
      dateEnd: json["date_end"]);

  Map<String, dynamic> toJson() => {
        "trx_id": trxId,
        "status": status,
        "date_start": dateStart,
        "date_end": dateEnd
      };
}
