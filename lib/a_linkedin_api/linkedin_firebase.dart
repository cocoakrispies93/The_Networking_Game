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
import 'package:linkedin_login/linkedin_login.dart';

import '../firebase/firebase_options.dart';
import '../firebase/guest_book_message.dart';
import 'connect_startover.dart';

class LinkedInAuthState extends ChangeNotifier {
  LinkedInAuthState() {
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

    FirebaseUIAuth.configureProviders([
      // LinkedInAuthProvider(),
      // GithubAuthProvider(),
      EmailAuthProvider(),
      // LinkedInDeepEmailHandle(),
      // LinkedInAuthCodeWidget(onGetAuthCode: onGetAuthCode, redirectUrl: redirectUrl, clientId: clientId, onError: onError),
      // LinkedInDeepEmail(),
      // Add any other providers you want to use here
    ]);

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

    // Refresh the user's LinkedIn auth information here
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
      // Add any other relevant fields here
    }) as Future<DocumentReference>; //not sure if that's a good idea
  }

  // Add any other methods you need here
}
