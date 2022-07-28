import 'dart:core';

class LoginResponse {
  LoginResponse({
    required this.status,
    required this.data,
    required this.debugParamSent,
    required this.debugLive,
  });
  late final Status status;
  late final Data data;
  late final DebugParamSent debugParamSent;
  late final String debugLive;
  late final String error;

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = Status.fromJson(json['status']);
    data = Data.fromJson(json['data']);
    debugParamSent = DebugParamSent.fromJson(json['debug-param-sent']);
    debugLive = json['debug-live'];
    error = "";
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status.toJson();
    _data['data'] = data.toJson();
    _data['debug-param-sent'] = debugParamSent.toJson();
    _data['debug-live'] = debugLive;
    return _data;
  }

  LoginResponse.withError(String errorValue)
      : data = Data(
            user: User(
                userId: "",
                language: "",
                fullName: "",
                phone: "",
                emailAddress: "",
                role: "",
                designation: "",
                outletId: "")),
        error = errorValue;
}

class Status {
  Status({
    required this.error,
    required this.login,
    required this.userId,
    required this.role,
    required this.apiVer,
    required this.devDebugParam,
  });
  late final int error;
  late final bool login;
  late final String userId;
  late final String role;
  late final String apiVer;
  late final String devDebugParam;

  Status.fromJson(Map<String, dynamic> json) {
    error = json['error'];
    login = json['login'];
    userId = json['user_id'];
    role = json['role'];
    apiVer = json['api-ver'];
    devDebugParam = json['dev-debug-param'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['error'] = error;
    _data['login'] = login;
    _data['user_id'] = userId;
    _data['role'] = role;
    _data['api-ver'] = apiVer;
    _data['dev-debug-param'] = devDebugParam;
    return _data;
  }
}

class Data {
  Data({
    required this.user,
  });
  late final User user;

  Data.fromJson(Map<String, dynamic> json) {
    user = User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user'] = user.toJson();
    return _data;
  }
}

class User {
  User({
    required this.userId,
    required this.language,
    required this.fullName,
    required this.phone,
    required this.emailAddress,
    required this.role,
    required this.designation,
    required this.outletId,
  });
  late final String userId;
  late final String language;
  late final String fullName;
  late final String phone;
  late final String emailAddress;
  late final String role;
  late final String designation;
  late final String outletId;

  User.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    language = json['language'];
    fullName = json['full_name'];
    phone = json['phone'];
    emailAddress = json['email_address'];
    role = json['role'];
    designation = json['designation'];
    outletId = json['outlet_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['user_id'] = userId;
    _data['language'] = language;
    _data['full_name'] = fullName;
    _data['phone'] = phone;
    _data['email_address'] = emailAddress;
    _data['role'] = role;
    _data['designation'] = designation;
    _data['outlet_id'] = outletId;
    return _data;
  }
}

class DebugParamSent {
  DebugParamSent({
    this.actLoginUnAdminAdminComUpAdmin,
  });

  String? actLoginUnAdminAdminComUpAdmin;

  factory DebugParamSent.fromJson(Map<String, dynamic> json) => DebugParamSent(
        actLoginUnAdminAdminComUpAdmin: json[
                    "{\"act\":\"LOGIN\",\"un\":\"admin@admin_com\",\"up\":\"admin\"}"] ==
                null
            ? null
            : json[
                "{\"act\":\"LOGIN\",\"un\":\"admin@admin_com\",\"up\":\"admin\"}"],
      );

  Map<String, dynamic> toJson() => {
        "{\"act\":\"LOGIN\",\"un\":\"admin@admin_com\",\"up\":\"admin\"}":
            actLoginUnAdminAdminComUpAdmin == null
                ? null
                : actLoginUnAdminAdminComUpAdmin,
      };
}
