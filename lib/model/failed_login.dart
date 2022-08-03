class FailedLogin {
  FailedLogin({
    this.status,
    this.debugParamSent,
    this.debugLive,
  });

  Status? status;
  DebugParamSent? debugParamSent;
  String? debugLive;

  factory FailedLogin.fromJson(Map<String, dynamic> json) => FailedLogin(
        status: json["status"] == null ? null : Status.fromJson(json["status"]),
        debugParamSent: json["debug-param-sent"] == null
            ? null
            : DebugParamSent.fromJson(json["debug-param-sent"]),
        debugLive: json["debug-live"] == null ? null : json["debug-live"],
      );

  Map<String, dynamic> toJson() => {
        "status": status == null ? null : status?.toJson(),
        "debug-param-sent":
            debugParamSent == null ? null : debugParamSent?.toJson(),
        "debug-live": debugLive == null ? null : debugLive,
      };
}

class DebugParamSent {
  DebugParamSent({
    this.actLoginUnAdminAdminComUpAdmins,
  });

  String? actLoginUnAdminAdminComUpAdmins;

  factory DebugParamSent.fromJson(Map<String, dynamic> json) => DebugParamSent(
        actLoginUnAdminAdminComUpAdmins: json[
                    "{\"act\":\"LOGIN\",\"un\":\"admin@admin_com\",\"up\":\"admins\"}"] ==
                null
            ? null
            : json[
                "{\"act\":\"LOGIN\",\"un\":\"admin@admin_com\",\"up\":\"admins\"}"],
      );

  Map<String, dynamic> toJson() => {
        "{\"act\":\"LOGIN\",\"un\":\"admin@admin_com\",\"up\":\"admins\"}":
            actLoginUnAdminAdminComUpAdmins == null
                ? null
                : actLoginUnAdminAdminComUpAdmins,
      };
}

class Status {
  Status({
    this.error,
    this.errInfo,
    this.apiVer,
    this.devDebugParam,
  });

  int? error;
  String? errInfo;
  String? apiVer;
  String? devDebugParam;

  factory Status.fromJson(Map<String, dynamic> json) => Status(
        error: json["error"] == null ? null : json["error"],
        errInfo: json["err-info"] == null ? null : json["err-info"],
        apiVer: json["api-ver"] == null ? null : json["api-ver"],
        devDebugParam:
            json["dev-debug-param"] == null ? null : json["dev-debug-param"],
      );

  Map<String, dynamic> toJson() => {
        "error": error == null ? null : error,
        "err-info": errInfo == null ? null : errInfo,
        "api-ver": apiVer == null ? null : apiVer,
        "dev-debug-param": devDebugParam == null ? null : devDebugParam,
      };
}
