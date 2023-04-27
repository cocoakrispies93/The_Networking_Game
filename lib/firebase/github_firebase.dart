// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
//import 'package:firebase_auth_ui/providers.dart';

import '../firebase_options.dart';
import 'guest_book_message.dart';
import '../a_linkedin_api/connect_startover.dart';

class GitHubAuthState extends ChangeNotifier {
  GitHubAuthState() {
    init();
  }

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;

  late final Map<String, dynamic> _defaultValues;

  void _setDefaultValues() {
    _defaultValues = <String, dynamic>{
      'userID': '',
      'accessToken': '',
      'name': '',
      'profilePictureUrl': '',
      // Add any other relevant fields here
    };
  }

  Future<void> init() async {
    _setDefaultValues();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    // FirebaseUIAuth.configureProviders([
    //   //LinkedInAuthProvider(),
    //   GithubAuthProvider(),
    //   // Add any other providers you want to use here
    // ]);

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
      } else {
        _loggedIn = false;
      }
      notifyListeners();
    });
  }

  Future<void> refreshLoggedInUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    // Refresh the user's auth info
  }

  Future<DocumentReference> addLinkedInAuthInfo(String userID,
      String accessToken, String name, String profilePictureUrl) {
    final userDoc = FirebaseFirestore.instance
        .collection('linkedin_auth_info')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    return userDoc.set(<String, dynamic>{
      'userID': userID,
      'accessToken': accessToken,
      'name': name,
      'profilePictureUrl': profilePictureUrl,
      // Add more stuff here
    }) as Future<DocumentReference>; //added typecast, may be an issue later
  }


  //potentially add more methods here later
}
