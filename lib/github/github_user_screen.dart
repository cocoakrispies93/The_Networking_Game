// ignore_for_file: library_private_types_in_public_api

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import '../firebase/github_firebase.dart';

class GetUserData extends StatefulWidget {
  final String? username;

  const GetUserData({super.key, required this.username});

  @override
  _GetUserDataState createState() => _GetUserDataState();

  //Map<String, dynamic> get getUserData => userProfile;
}

class _GetUserDataState extends State<GetUserData> {
  late Map<String, dynamic> userData;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _user;
  //final userProfile = GetUserData(username: widget.username).userProfile;

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  //Future<Map<String, dynamic>> getUserData() async {
  Future<void> getUserData() async {
    final url = 'https://api.github.com/users/${widget.username}';
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      setState(() {
        userData = json.decode(response.body) as Map<String, dynamic>;
      });
    } else {
      throw Exception('Failed to load user data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: const AssetImage('assets/moving_street.gif'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.darken,
            ),
          ),
        ),
      ),
      Scaffold(
          appBar: AppBar(
            title: const Text('GitHub Connect!!'),
            actions: <Widget>[
              ElevatedButton(
                child: const Text('Sign out'),
                onPressed: () async {
                  final User? user = _firebaseAuth.currentUser;
                  if (user == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('No one has signed in :('),
                      ),
                    );
                    return;
                  }
                  await _firebaseAuth.signOut();
                },
              )
            ],
          ),
          body: Column(
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(userData['avatar_url'] as String),
              ),
              const SizedBox(height: 20),
              Text(
                userData['name'] as String,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                userData['bio'] as String,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Column(
                    children: [
                      Text(
                        '${userData['public_repos']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Repositories',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${userData['followers']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Followers',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text(
                        '${userData['following']}',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        'Following',
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ))
    ]);
  }
}
