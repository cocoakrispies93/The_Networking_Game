// ignore_for_file: camel_case_types, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:linkedin_login/linkedin_login.dart';
import 'linkedin_api_auth.dart';
import 'linkedin_share.dart';
import "package:http/http.dart" as http;
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

//==================
//   Connect Page
//==================

class ConnectPage extends StatelessWidget {
  ConnectPage({super.key});
  final UserModel userModel = UserModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: userModel,
      child: MaterialApp(
        theme: ThemeData(useMaterial3: true),
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
        ),
        home: Scaffold(
          backgroundColor: Colors.deepPurple.withOpacity(0.2), //better
          body: const Linkedin_Login(),
        ),
      ),
    );
  }
}

//==================
//   User JSON
//==================

class AuthCodeObject {
  AuthCodeObject({required this.code, required this.state});

  final String code;
  final String state;
}

class UserObject {
  UserObject({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImageUrl,
  });

  final String firstName;
  final String lastName;
  final String email;
  final String profileImageUrl;

  get profilePicture => String;

  static dynamic fromJson(Map<String, dynamic> userInfo) {
    return UserObject(
      firstName: userInfo['firstName']['localized']['en_US'].toString(),
      lastName: userInfo['lastName']['localized']['en_US'].toString(),
      email: userInfo['emailAddress'].toString(),
      profileImageUrl: userInfo['profilePicture']['displayImage~']['elements']
              [0]['identifiers'][0]['identifier']
          .toString(),
    );
  }
}

//==========================
// Change Provider UserModel
//==========================

class UserModel extends ChangeNotifier {
  UserObject? _user;
  bool _logoutUser = false;

  UserObject? get user => _user;
  bool get logoutUser => _logoutUser;

  void setUser(UserObject user) {
    _user = user;
    print('UserModel - setUser, _user: $_user');
    notifyListeners();
  }

  void setLogoutUser(bool value) {
    _logoutUser = value;
    print('UserModel - setLogoutUser, bool value: $value');
    notifyListeners();
  }
}

class Linkedin_Login extends StatefulWidget {
  const Linkedin_Login({super.key});

  @override
  State<Linkedin_Login> createState() => _Linkedin_LoginState();
}

class _Linkedin_LoginState extends State<Linkedin_Login> {
  //_user is never initialized
  //UserObject? _user;
  bool logoutUser = false;
  late http.Client httpClient;

  Future<void> _onLinkedInLogin(UserObject? user, UserModel userModel) async {
    userModel.setUser(user!);
  }

  Future<void> _login() async {
    final authorizationUrl = LinkedIn.getAuthorizationUrl().toString();

    final result = await FlutterWebAuth.authenticate(
      url: authorizationUrl,
      //callbackUrlScheme: LinkedIn.redirectUri,
      callbackUrlScheme: 'http',
      //callbackUrlScheme: 'tng',
    );

    final code = Uri.parse(result).queryParameters['code'];

    if (code != null) {
      final token = await LinkedIn.getToken(code);
      final userInfo =
          await LinkedIn.getUserInfo(token['access_token'] as String);
      setState(() {
        final userModel = Provider.of<UserModel>(context, listen: true);

        userModel.setUser(UserObject.fromJson(userInfo) as UserObject);
      });
    }
  }

  //void _logout(UserModel userModel) {
  //Future<void> _logout() async {
  void _logout() {
    // final UserModel userModel = UserModel();
    final userModel = Provider.of<UserModel>(context);
    print('_Linkedin_LoginState - _logout called');
    setState(() {
      userModel.setLogoutUser(true);
      print('_Linkedin_LoginState - setLogoutuser(true)');
      //_user = '' as UserObject;
    });
  }

  @override
  Widget build(BuildContext context) {
    final userModel2 = Provider.of<UserModel>(context, listen: true);
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        final user = userModel2.user;
        final logoutUser = userModel2.logoutUser;
        print('_Linkedin_LoginState: user = ${userModel.user}');
        print('_Linkedin_LoginState: logoutUser = ${userModel.logoutUser}');
        if (logoutUser) {
          //_logout(userModel);
          _logout();
          userModel.setLogoutUser(false);
          return ElevatedButton(
            //onPressed: () => _logout(userModel),
            onPressed: () => _logout(),
            child: const Text('Logged out. Click to log in again.'),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('LinkedIn Screen!!'),
            ),
            body: Center(
              child: user != null
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.network(
                          user.profilePicture?.displayImageElements?.first
                                  ?.identifiers?.first?.identifier
                                  .toString() ??
                              '',
                          width: 100,
                          height: 100,
                        ),
                        const SizedBox(height: 16),
                        Text('Hello, ${user.firstName} ${user.lastName}!'),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: _logout,
                          child: const Text('Logout'),
                        ),
                      ],
                    )
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text('Login with LinkedIn'),
                    ),
            ),
          );
        }
      },
    );
  }
}

//==================
// LinkedIn API Auth
//==================

class LinkedIn {
  static const String clientId = '86ydjzjvea9mw2';
  static const String clientSecret = 'CvKLqkJ6S7Fp1wY7';
  //static const String redirectUri = 'http://example.com:8000/oauth2callback';
  static const String redirectUri = 'http://localhost:3000/oauth/callback';
  //static const String redirectUri = 'http';
  static const String scope = 'r_emailaddress r_liteprofile w_member_social';

  static const String authorizationEndpoint =
      'https://www.linkedin.com/oauth/v2/authorization';
  static const String tokenEndpoint =
      'https://www.linkedin.com/oauth/v2/accessToken';
  static const String userInfoEndpoint =
      'https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))';

  static Future<Map<String, dynamic>> getToken(String code) async {
    final response = await http.post(
      Uri.parse(tokenEndpoint),
      headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      body: {
        'grant_type': 'authorization_code',
        'code': code,
        'redirect_uri': redirectUri,
        'client_id': clientId,
        'client_secret': clientSecret,
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve access token');
    }

    return json.decode(response.body) as Future<Map<String, dynamic>>;
  }

  static Future<Map<String, dynamic>> getUserInfo(String accessToken) async {
    final response = await http.get(
      Uri.parse(userInfoEndpoint),
      headers: {'Authorization': 'Bearer $accessToken'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve user info');
    }

    return json.decode(response.body) as Future<Map<String, dynamic>>;
  }

  static Uri getAuthorizationUrl() {
    return Uri.parse(
        '$authorizationEndpoint?response_type=code&client_id=$clientId&redirect_uri=$redirectUri&scope=$scope');
  }
}

















//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('LinkedIn Screen!!'),
//       ),
//       body: Center(
//         child: _user != null
//             ? Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Image.network(
//                     _user!.profilePicture?.displayImageElements?.first
//                             ?.identifiers?.first?.identifier
//                             .toString() ??
//                         '',
//                     width: 100,
//                     height: 100,
//                   ),
//                   const SizedBox(height: 16),
//                   Text('Hello, ${_user!.firstName} ${_user!.lastName}!'),
//                   const SizedBox(height: 16),
//                   ElevatedButton(
//                     onPressed: _logout,
//                     child: const Text('Logout'),
//                   ),
//                 ],
//               )
            // : ElevatedButton(
            //     onPressed: _login,
            //     child: const Text('Login with LinkedIn'),
            //   ),
//       ),
//     );
//   }
// }

