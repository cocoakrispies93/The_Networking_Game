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
import '../github/github_user_screen.dart';
import '../app_styles/widget_styles.dart';
// import '../app_styles/nav_bar_v2_ooooooold.dart';
// Try const ConnectGitHub2 const GitHubSignInScreen

class ConnectGitHub2 extends StatefulWidget {
  const ConnectGitHub2({super.key});

  @override
  _ConnectGitHub2 createState() => _ConnectGitHub2();
}

class _ConnectGitHub2 extends State<ConnectGitHub2> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  UserCredential? _user;
  //final userData = await GetUserData(username: "example_username").getUserData();

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: const Text('GitHub Connect!!'),
  //       actions: <Widget>[
  //         ElevatedButton(
  //           //change signout color button, add icon
  //           child: const Text('Sign out'),
  //           onPressed: () async {
  //             final User? user = _firebaseAuth.currentUser;
  //             if (user == null) {
  //               ScaffoldMessenger.of(context).showSnackBar(
  //                 const SnackBar(
  //                   content: Text('No one has signed in :('),
  //                 ),
  //               );
  //               return;
  //             }
  //             await _firebaseAuth.signOut();
  //           },
  //         )
  //       ],
  //     ),
  //     //body: Scaffold(
  //     resizeToAvoidBottomInset: false,
  //     body: Stack(
  //       children: [
  //         Container(
  //           decoration: BoxDecoration(
  //             image: DecorationImage(
  //               image: const AssetImage('assets/moving_street.gif'),
  //               fit: BoxFit.cover,
  //               colorFilter: ColorFilter.mode(
  //                 Colors.black.withOpacity(0.2),
  //                 BlendMode.darken,
  //               ),
  //             ),
  //           ),
  //         ),
  //         Positioned.fill(
  //           child: Align(
  //             alignment: Alignment.topLeft,
  //             child: Padding(
  //               padding:
  //                   EdgeInsets.only(top: MediaQuery.of(context).padding.top),
  //               child: Column(
  //                 mainAxisAlignment: MainAxisAlignment.center,
  //                 children: [
  //                   ElevatedButton(
  //                     onPressed: () {
  //                       signInWithGitHub();
  //                     },
  //                     child: const Text('Sign In With GitHub'),
  //                   ),
  //                   const SizedBox(height: 16),
  //                   //Text(_user?.user?.displayName ?? 'Not logged in'),
  //                   Center(
  //                     child: Container(
  //                       color: Colors.white,
  //                       child: Text(
  //                         _user?.user?.displayName ?? 'Not logged in',
  //                         style: Theme.of(context).textTheme.bodyLarge,
  //                       ),
  //                     ),
  //                   ),
  //                   if (_user?.user?.displayName != null)
  //                     GetUserData(username: _user?.user?.displayName),
  //                 ],
  //               ),
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //     bottomNavigationBar: const MyNavigationBar(),
  //     extendBody: true,
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //debugShowCheckedModeBanner: false,
      appBar: AppBar(
        title: const Text('GitHub Connect!!'),
        actions: <Widget>[
          ElevatedButton(
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
            //style: MyElevatedButtonTheme().style,
            style: MyElevatedButtonStyle.style(context),
            child: const Text('Sign out'),
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
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
          Positioned.fill(
            child: Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).padding.top,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        signInWithGitHub();
                      },
                      style: MyElevatedButtonStyle.style(context),
                      child: const Text('Sign In With GitHub'),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Container(
                        color: Colors.white,
                        child: Text(
                          _user?.user?.displayName ?? 'Not logged in',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    if (_user?.user?.displayName != null)
                      GetUserData(username: _user?.user?.displayName),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
      extendBody: true,
    );
  }

  Future<void> signInWithGitHub() async {
    try {
      final GithubAuthProvider githubProvider = GithubAuthProvider();
      githubProvider.addScope('repo');
      //optional, check for Indeed scopes!!!

      final UserCredential userCredential =
          await _firebaseAuth.signInWithPopup(githubProvider);

      setState(() {
        _user = userCredential;
      });
    } on FirebaseAuthException catch (e) {
      print('Failed to sign in with GitHub: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to sign in with GitHub :('),
        ),
      );
    }
  }
}




// Future<void> signInWithGitHub() async {
  //   try {
  //     final GithubAuthProvider githubProvider = GithubAuthProvider();
  //     githubProvider.addScope('repo');
  //     //optional, check for Indeed scopes!!!

  //      showDialog(
  //       context: context,
  //       barrierDismissible: false,
  //       builder: (context) {
  //         return AlertDialog(
  //           backgroundColor: Colors.transparent,
  //           content: Container(
  //             decoration: BoxDecoration(
  //               image: DecorationImage(
  //                 image: const AssetImage('assets/moving_street.gif'),
  //                 fit: BoxFit.cover,
  //                 colorFilter: ColorFilter.mode(
  //                   Colors.black.withOpacity(0.5),
  //                   BlendMode.darken,
  //                 ),
  //               ),
  //             ),
  //             child: const Center(
  //               child: CircularProgressIndicator(),
  //             ),
  //           ),
  //         );
  //       },
  //     );

  //   final UserCredential userCredential =
  //     await _firebaseAuth.signInWithPopup(githubProvider);

  //     Navigator.pop(context); // Close the dialog

  //     setState(() {
  //       _user = userCredential;
  //     });
  //   } on FirebaseAuthException catch (e) {
  //     print('Failed to sign in with GitHub: $e');
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       const SnackBar(
  //         content: Text('Failed to sign in with GitHub :('),
  //       ),
  //     );
  //   }
  // }



