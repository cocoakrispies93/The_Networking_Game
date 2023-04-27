// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../firebase/guest_state_firebase.dart';
//this allows me to add LinkedIn API auth to Firebase
import '../firebase_options.dart';
import '../screens/profile_page.dart';
import '../firebase/github_firebase.dart';

//void main() => runApp(const MyApp());

class LoginConnectScreen extends StatelessWidget {
  const LoginConnectScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LinkedInAuthProvider(),
      child: const MaterialApp(
        title: 'Login Connect Screen!!',
        home: LoginPage(),
      ),
    );
  }
}

//
//
//
//
//

//=========================================================
// LinkedIn API Auth - Without Future<Map<String, dynamic>>
//=========================================================

//Use multiple methods with multiple implementations, see which one works!

class LinkedInAuthProvider extends ChangeNotifier {
  static const String clientId = '86ydjzjvea9mw2';
  static const String clientSecret = 'CvKLqkJ6S7Fp1wY7';
  static const String redirectUri = 'http://localhost:3000/oauth/callback';
  static const String scope = 'r_emailaddress r_liteprofile w_member_social';

  static const String authorizationEndpoint =
      'https://www.linkedin.com/oauth/v2/authorization';
  static const String tokenEndpoint =
      'https://www.linkedin.com/oauth/v2/accessToken';
  static const String userInfoEndpoint =
      'https://api.linkedin.com/v2/me?projection=(id,firstName,lastName,profilePicture(displayImage~:playableStreams))';

  String _accessToken = '';
  String _userId = '';
  String _name = '';
  String _profilePictureUrl = '';
  late List<String> _notifications;
  late List<String> _skills;
  late List<String> _messages;

  String get accessToken => _accessToken;
  String get userId => _userId;
  String get name => _name;
  String get profilePictureUrl => _profilePictureUrl;
  List<String> get skills => _skills;
  List<String> get notifications => _notifications;
  List<String> get messages => _messages;

//=============================
//  login (username, password)
//====================================================================================
  Future<void> login(String username, String password) async {
    // Replace this with your social media API login logic
    final response = await http.post(
      Uri.parse(userInfoEndpoint),
      headers: {'Authorization': 'Bearer $_accessToken'},
      body: {'username': username, 'password': password},
    );

    //200 status code is good!!
    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      _accessToken = json['access_token'] as String;
      _userId = json['user_id'] as String;
      _name = json['name'] as String;
      _skills = List<String>.from(json['skills'] as Iterable<dynamic>);
      _profilePictureUrl = json['profile_picture'] as String;
      _notifications =
          List<String>.from(json['notifications'] as Iterable<dynamic>);
      _messages = List<String>.from(json['messages'] as Iterable<dynamic>);
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', _accessToken);
      await prefs.setString('user_id', _userId);

      notifyListeners();
    } else {
      throw Exception('Failed to log in');
    }
  } //==============================================================================

//=========================
//  getToken (code)
//=================================================================================
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
  } //==============================================================================

  //=========================
  //     void logout()
  //=========================
  Future<void> logout() async {
    _accessToken = '';
    _userId = '';
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    notifyListeners();
  }

  //=========================
  //  void isLoggedIn()
  //=========================
  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    _accessToken = prefs.getString('access_token') as String;
    _userId = prefs.getString('user_id') as String;
    return _accessToken != '' && _userId != '';
  }
}

//
//
//
//
//

//=========================================================
// LinkedIn API Auth - Without Future<Map<String, dynamic>>
//=========================================================

//Use multiple methods with multiple implementations, see which one works!

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    checkLoggedIn();
  }

  Future<void> checkLoggedIn() async {
    final isLoggedIn =
        await Provider.of<GitHubAuthState>(context, listen: false).loggedIn;
    if (isLoggedIn as bool) {
      await Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ProfilePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<GitHubAuthState>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Log in')),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter your username';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  validator: (value) {
                    if (value == '') {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  obscureText: true,
                ),
                const SizedBox(height: 16.0),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final username = _usernameController.text;
                      final password = _passwordController.text;
                      try {
                        //await auth.login(username, password);
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                          //Change this later! Or just keep?
                        );
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(e.toString()),
                            backgroundColor: Colors.red,
                          ),
                        );
                      }
                    }
                  },
                  child: const Text('Log in'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<LinkedInAuthProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('LinkedIn Authorize SUCCESS!!')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome, ${auth.userId}'),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                await auth.logout();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const LoginConnectScreen()),
                );
              },
              child: const Text('Log out'),
            ),
          ],
        ),
      ),
    );
  }
}
