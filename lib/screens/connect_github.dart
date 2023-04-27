// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';

import '../firebase/guest_state_firebase.dart';
//this allows me to add LinkedIn API auth to Firebase
import '../firebase_options.dart';
import 'profile_page.dart';
import '../firebase/github_firebase.dart';
import '../app_styles/nav_bar_v2.dart';
// import '../app_styles/nav_bar_v2_ooooooold.dart';
// Try const ConnectGitHub
//or const GitHubSignInScreen

class ConnectGitHub extends StatefulWidget {
  const ConnectGitHub({super.key});

  @override
  _ConnectGitHubState createState() => _ConnectGitHubState();
}

class _ConnectGitHubState extends State<ConnectGitHub> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _user;
  // String username = 'YOUR_GITHUB_USERNAME';
  // String url = 'https://api.github.com/users/$username';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                signInWithGitHub();
              },
              child: const Text('Sign In With GitHub'),
            ),
            Text(_user?.user?.displayName ?? 'Not logged in'),
          ],
        ),
      ),
      //bottomNavigationBar: const MyNavigationBar(),
      bottomNavigationBar: const MyNavigationBar(),
      extendBody: true,
    );
  }

  Future<void> signInWithGitHub() async {
    try {
      final GithubAuthProvider githubProvider = GithubAuthProvider();
      githubProvider.addScope('repo'); //optional, check for more scopes

      final UserCredential userCredential =
          await _firebaseAuth.signInWithPopup(githubProvider);

      setState(() {
        _user = userCredential;
      });
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with GitHub: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with GitHub'),
        ),
      );
    }
  }
}































// class GitHubSignInScreen extends StatefulWidget {
//   const GitHubSignInScreen({super.key});

//   @override
//   _GitHubSignInScreenState createState() => _GitHubSignInScreenState();
// }

// class _GitHubSignInScreenState extends State<GitHubSignInScreen> {
//   final FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<UserCredential?> _signInWithGitHub() async {
//     try {
//       final GithubAuthProvider githubProvider = GithubAuthProvider();
//       githubProvider.addScope('repo'); // Optional
//       final UserCredential userCredential =
//           await _auth.signInWithPopup(githubProvider);
//       return userCredential;
//     } catch (e) {
//       debugPrint(e.toString());
//       return null;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('GitHub Sign In'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () async {
//             final UserCredential? userCredential = await _signInWithGitHub();
//             if (userCredential != null) {
//               // Handle successful sign in
//             } else {
//               // Handle sign in failure
//             }
//           },
//           child: const Text('Sign in with GitHub'),
//         ),
//       ),
//       bottomNavigationBar: const MyNavigationBar(),
//     );
//   }
// }
