import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:keuangan/model/failed_login.dart';
import 'package:keuangan/model/response_login.dart';
import 'package:keuangan/provider/login_provider.dart';
import 'package:keuangan/utils/shared_prefs.dart';

import '../model/users.dart';
import '../utils/Constant.dart';
import '../utils/custome_route.dart';
import 'dashboard.dart';

class LoginPage extends StatelessWidget {
  static const routeName = '/auth';

  const LoginPage({Key? key}) : super(key: key);

  Duration get loginTime => Duration(milliseconds: timeDilation.ceil() * 2250);

  Future<String?> _loginUser(LoginData data) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(data.name)) {
        return 'User not exists';
      }
      if (mockUsers[data.name] != data.password) {
        return 'Password does not match';
      }
      return null;
    });
  }

  Future<String?> _signupUser(SignupData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      if (!mockUsers.containsKey(name)) {
        return 'User not exists';
      }
      return null;
    });
  }

  Future<String?> _signupConfirm(String error, LoginData data) {
    return Future.delayed(loginTime).then((_) {
      return null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: Constants.appName,
      logo: const AssetImage('assets/logo_jni.png'),
      logoTag: Constants.logoTag,
      titleTag: Constants.titleTag,
      navigateBackAfterRecovery: true,
      onConfirmRecover: _signupConfirm,
      onConfirmSignup: _signupConfirm,
      loginAfterSignUp: false,
      termsOfService: [
        TermOfService(
            id: 'newsletter',
            mandatory: false,
            text: 'Newsletter subscription'),
        TermOfService(
            id: 'general-term',
            mandatory: true,
            text: 'Term of services',
            linkUrl: 'https://github.com/NearHuscarl/flutter_login'),
      ],
      additionalSignupFields: [
        const UserFormField(
            keyName: 'Username', icon: Icon(FontAwesomeIcons.userLarge)),
        const UserFormField(keyName: 'Name'),
        const UserFormField(keyName: 'Surname'),
        UserFormField(
          keyName: 'phone_number',
          displayName: 'Phone Number',
          userType: LoginUserType.phone,
          fieldValidator: (value) {
            var phoneRegExp = RegExp(
                '^(\\+\\d{1,2}\\s)?\\(?\\d{3}\\)?[\\s.-]?\\d{3}[\\s.-]?\\d{4}\$');
            if (value != null &&
                value.length < 7 &&
                !phoneRegExp.hasMatch(value)) {
              return "This isn't a valid phone number";
            }
            return null;
          },
        ),
      ],
      initialAuthMode: AuthMode.login,
      userValidator: (value) {
        if (value!.contains('@') ||
            value.endsWith('.com') ||
            value.endsWith('.co.id')) {
          return null;
        }
        return "Email must contain '@' and end with '.com'";
      },
      passwordValidator: (value) {
        if (value!.isEmpty) {
          return 'Password is empty';
        }
        return null;
      },
      onLogin: (loginData) async {
        try {
          ApiLoginProvider _accountApiProvider = ApiLoginProvider();
          Object response = await _accountApiProvider.getUserLogin(
              loginData.name, loginData.password);
          if (response is LoginResponse) {
            LoginResponse loginResponse = response;
            if (loginResponse.status.login) {
              SharedPrefs sharedPref = SharedPrefs();
              // await sharedPref.saveDataInt("reg_member_id", 1);
              await sharedPref.saveData(
                  "reg_member_id", response.data.user.userId);
              return null;
            } else {
              return "ops ada maintenance server nih!";
            }
          } else {
            FailedLogin failedLogin = response as FailedLogin;
            return failedLogin.status?.errInfo;
          }
        } catch (e) {
          print(e);
        }
      },
      onSignup: (signupData) {
        debugPrint('Signup info');
        debugPrint('Name: ${signupData.name}');
        debugPrint('Password: ${signupData.password}');

        signupData.additionalSignupData?.forEach((key, value) {
          debugPrint('$key: $value');
        });
        if (signupData.termsOfService.isNotEmpty) {
          debugPrint('Terms of service: ');
          for (var element in signupData.termsOfService) {
            debugPrint(
                ' - ${element.term.id}: ${element.accepted == true ? 'accepted' : 'rejected'}');
          }
        }
        return _signupUser(signupData);
      },
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(FadePageRoute(
          builder: (context) => const DashboardScreen(),
        ));
      },
      onRecoverPassword: (name) {
        debugPrint('Recover password info');
        debugPrint('Name: $name');
        return _recoverPassword(name);
        // Show new password dialog
      },
      showDebugButtons: false,
    );
  }
}
