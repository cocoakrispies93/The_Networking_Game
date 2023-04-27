// ignore_for_file: avoid_print, camel_case_types

import 'dart:async';
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

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

class ConnectHome extends StatefulWidget {
  const ConnectHome({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConnectHomeState createState() => _ConnectHomeState();
}

class _ConnectHomeState extends State<ConnectHome> {
  List dataList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Firebase Screen!!!'),
      ),
      body: FutureBuilder(
        //future: FireStoreDataBase().getData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text(
              'Something went wrong',
            );
          }
          if (snapshot.connectionState == ConnectionState.done) {
            dataList = snapshot.data as List;
            return buildItems(dataList);
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Widget buildItems(dataList) => ListView.separated(
      padding: const EdgeInsets.all(8),
      itemCount: dataList.length as int,
      separatorBuilder: (context, index) => const Divider(),
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(
            dataList[index]['Name'] as String,
          ),
          subtitle: Text(dataList[index]['Dept'] as String),
          trailing: Text(
            dataList[index]['RollNo'] as String,
          ),
        );
      });
}

class AuthService {
  static Future<User?> signInWithLinkedIn(String code) async {
    final Map<String, dynamic> tokenResponse =
        await LinkedIn.getToken(code); //as Map<String, dynamic>;
    //gets token response

    final String accessToken = tokenResponse['access_token'] as String;
    final Map<String, dynamic> userInfoResponse =
        await LinkedIn.getUserInfo(accessToken); //as Map<String, dynamic>;
    //gets access token?

    final AuthCredential credential = OAuthCredential(
      providerId: 'linkedin.com',
      accessToken: accessToken,
      signInMethod: '',
    );

    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;

      if (user != null) {
        final UserObject userUpdateInfo; //= UserObject();
        await FirebaseAuth.instance.currentUser!
            .updateDisplayName(user.displayName);
        await FirebaseAuth.instance.currentUser!.updatePhotoURL(user.photoURL);
        //'updateProfile' is deprecated. Use updatePhotoURL and updateDisplayName
        //Future<void> updateProfile({String? displayName, String? photoURL})
        // userUpdateInfo.displayName =
        //     '${userInfoResponse['firstName']['localized']['en_US']}'
        //     '${userInfoResponse['lastName']['localized']['en_US']}';
        // userUpdateInfo.photoURL = userInfoResponse['profilePicture']
        //     ['displayImage~']['elements'][0]['identifiers'][0]['identifier'];

        //await user.updateProfile(userUpdateInfo);
        await user.updatePhotoURL(user.photoURL);
        await user.updateDisplayName(user.displayName);
      }

      return user;
    } on FirebaseAuthException catch (e) {
      print(e.toString());
      return null;
    }
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

  dynamic get profilePicture => null;

  //get profileImageUrl => profileImageUrl;

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
  bool _userLoggedIn = false;

  UserObject? get user => _user;
  bool get logoutUser => _logoutUser;
  bool get userLoggedIn => _userLoggedIn;

  void setUser(UserObject user) {
    _user = user;
    print('UserModel - setUser, _user: $_user');
    _userLoggedIn = true;
    notifyListeners();
  }

  void setLogoutUser(bool value) {
    _logoutUser = value;
    if (_logoutUser) {
      _userLoggedIn = false;
    }
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
        print('HAS THE USER_MODEL UPDATED WITH USER_OBJECT JSON VIA setUser');
        print('userModel is a UserModel object instance');
        print('HAS THE USER_MODEL UPDATED WITH USER_OBJECT JSON VIA setUser');
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
    //final userModel2 = Provider.of<UserModel>(context, listen: true);
    return Consumer<UserModel>(
      builder: (context, userModel, child) {
        final user = userModel.user;
        final logoutUser = userModel.logoutUser;
        print('_Linkedin_LoginState: user = ${userModel.user}');
        print('_Linkedin_LoginState: logoutUser = ${userModel.logoutUser}');
        if (logoutUser) {
          //_logout(userModel);
          _logout();
          userModel.setLogoutUser(false); //shouldn't this be true?
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














//==========================
// Change Provider UserModel
//==========================

// class UserModel extends ChangeNotifier {
//   UserObject? _user;
//   bool _logoutUser = false;

//   UserObject? get user => _user;
//   bool get logoutUser => _logoutUser;

//   void setUser(UserObject user) {
//     _user = user;
//     print('UserModel - setUser, _user: $_user');
//     notifyListeners();
//   }

//   void setLogoutUser(bool value) {
//     _logoutUser = value;
//     print('UserModel - setLogoutUser, bool value: $value');
//     notifyListeners();
//   }
// }













































































// class ConnectPage extends StatelessWidget {
//   ConnectPage({super.key});
//   final userModel = UserModel();

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider.value(
//       value: userModel,
//       child: MaterialApp(
//         theme: ThemeData(useMaterial3: true),
//         darkTheme: ThemeData(
//           brightness: Brightness.dark,
//           primaryColor: Colors.deepPurple,
//         ),
//         home: Scaffold(
//           backgroundColor: Colors.deepPurple.withOpacity(0.2), //better
//           body: const Linkedin_Login(),
//         ),
//       ),
//     );
//   }
// }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(useMaterial3: true),
//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Colors.deepPurple,
//       ),
//       //home: const WebViewApp(),
//       //home: const InternetPage(key: key),
//       home: Scaffold(
//         backgroundColor: Colors.grey[200],
//         body: const Linkedin_Login(),
//       ),
//     );
//   }
// }

//
//
//
//
//
//
//
//
//

// class InternetPage extends StatefulWidget {
//   const InternetPage({super.key});

//   @override
//   InternetPageState createState() => InternetPageState();
// }

// class InternetPageState extends State<InternetPage> {
//   late final WebViewController _controller;
//   // final GlobalKey<MyNavigationBarState> _navigationBarKey =
//   //     GlobalKey<MyNavigationBarState>(); //MyNavigationBarState

//   // final MyNavigationBarState _navigationBarKey =
//   //     MyNavigationBarState(); //MyNavigationBarState
//   // final int connectIndex = 4;

//   // @override
//   // void initState() {
//   //   super.initState();
//   //   _navigationBarKey.setSelectedIndex(connectIndex);
//   //   // ignore: avoid_print
//   //   print('connect_page: _navigationBarKey.setSelectedIndex($connectIndex);');
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connect Page!!'),
//         actions: [
//           NavigationControls(controller: _controller),
//           Menu(controller: _controller),
//         ],
//       ),
//       body: WebViewStack(controller: _controller),
//       bottomNavigationBar: const MyNavigationBar(),
//       //bottomNavigationBar: const MyNavigationBar(key: Key('navKey')),
//       //bottomNavigationBar: MyNavigationBar(key: widget.navigationBarKey ?? const Key('defaultNavigationBar')),
//       //myNavigationBarState.setSelectedIndex(4);
//     );
//   }
// }

// class NavigationControls extends StatelessWidget {
//   const NavigationControls({super.key, required this.controller});

//   final WebViewController controller;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         IconButton(
//           icon: const Icon(Icons.arrow_back_ios),
//           onPressed: () async {
//             if (await controller.canGoBack()) {
//               await controller.goBack();
//             }
//           },
//         ),
//         IconButton(
//           icon: const Icon(Icons.arrow_forward_ios),
//           onPressed: () async {
//             if (await controller.canGoForward()) {
//               await controller.goForward();
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class Menu extends StatelessWidget {
//   const Menu({super.key, required this.controller});

//   final WebViewController controller;

//   @override
//   Widget build(BuildContext context) {
//     return PopupMenuButton<String>(
//       onSelected: (value) async {
//         if (value == 'refresh') {
//           await controller.reload();
//         }
//       },
//       itemBuilder: (context) {
//         return [
//           const PopupMenuItem(
//             value: 'refresh',
//             child: Text('Refresh'),
//           ),
//         ];
//       },
//     );
//   }
// }
// //
// //
// //
// //
// //
// //

// //===============================================================

// //
// //
// //
// //
// //
// //
// //
// class WebViewStackGitHub extends StatefulWidget {
//   const WebViewStackGitHub({super.key, required this.controller});

//   final WebViewController controller;

//   @override
//   // ignore: library_private_types_in_public_api
//   WebViewStackGitHubState createState() => WebViewStackGitHubState();
// }

// class WebViewStackGitHubState extends State<WebViewStackGitHub> {
//   @override
//   Widget build(BuildContext context) {
//     return WebView(
//       initialUrl: 'https://github.com/',
//       javascriptMode: JavascriptMode.unrestricted,
//       onWebViewCreated: (controller) {
//         controller = controller;
//       },
//     );
//   }
// }

// //
// //
// //
// //
// //
// //
// //
// //
// //
// //
// //

// class WebViewApp extends StatefulWidget {
//   const WebViewApp({super.key});

//   @override
//   State<WebViewApp> createState() => _WebViewAppState();
// }

// class _WebViewAppState extends State<WebViewApp> {
//   late final WebViewController _controller;
//   late final NavigationControls _pageNavigator;

//   @override
//   void initState() {
//     super.initState();
//     _pageNavigator = NavigationControls(controller: _controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Connect Page!!'),
//         actions: [
//           NavigationControls(controller: _controller),
//           Menu(controller: _controller),
//         ],
//       ),
//       body: WebViewStack(controller: _controller),
//       //bottomNavigationBar: const MyNavigationBar(key: Key('navKey')),
//       bottomNavigationBar: const MyNavigationBar(),
//     );
//   }
// }
