
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

import '../firebase_options.dart';
import 'guest_book_message.dart';

enum Attending { yes, no, unknown }

class ApplicationState extends ChangeNotifier {
  ApplicationState() {
    init();
  }

  //Troubleshooting
  int _counter = 0;
  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    // ignore: avoid_print
    print('Counter has been incremented to $_counter');
    notifyListeners();
  }
  //-----------------

  bool _loggedIn = false;
  bool get loggedIn => _loggedIn;
  bool _emailVerified = false;
  bool get emailVerified => _emailVerified;

  final DateTime currentDate = DateTime.now();
  final DateFormat formatter = DateFormat('MMMM d, yyyy');

  late int daysUntilMonday = (DateTime.monday - currentDate.weekday) % 7;
  late DateTime nextMonday =
      currentDate.add(Duration(days: 14 + daysUntilMonday));
  late String formattedDate = formatter.format(nextMonday);
  late final int daysUntilWeekday;
  late final DateTime nextWeekday;

  StreamSubscription<QuerySnapshot>? _guestBookSubscription;
  
  List<GuestBookMessage> _guestBookMessages = [];

  List<GuestBookMessage> get guestBookMessages => _guestBookMessages;

  int _attendees = 0;
  int get attendees => _attendees;

  late final Map<String, dynamic> _defaultValues;

  void _setDefaultValues() {
    //daysUntilMonday = (DateTime.monday - currentDate.weekday) % 7;
    daysUntilWeekday = currentDate.weekday % 7;
    nextWeekday = currentDate.add(Duration(days: 3 + daysUntilWeekday));
    formattedDate = formatter.format(nextWeekday);
    _defaultValues = <String, dynamic>{
      'event_date': formattedDate.toString(),
      'enable_free_swag': false,
      'call_to_action':
          'Join us for a day full of Firebase Workshops and Pizza!',
    };
  }

  //   static Map<String, dynamic> defaultValues = <String, dynamic>{
  //   'event_date': 'October 18, 2022',
  //   'enable_free_swag': false,
  //   'call_to_action': 'Join us for a day full of Firebase Workshops and Pizza!',
  // };

  // ignoring lints on these fields since we are modifying them in a different
  // part of the codelab
  // ignore: prefer_final_fields
  late bool _enableFreeSwag = _defaultValues['enable_free_swag'] as bool;
  bool get enableFreeSwag => _enableFreeSwag;
  // ignore: prefer_final_fields
  late String _eventDate = _defaultValues['event_date'] as String;
  String get eventDate => _eventDate;
  // ignore: prefer_final_fields
  late String _callToAction = _defaultValues['call_to_action'] as String;
  String get callToAction => _callToAction;
  Attending _attending = Attending.unknown;
  StreamSubscription<DocumentSnapshot>? _attendingSubscription;
  Attending get attending => _attending;

  set attending(Attending attending) {
    final userDoc = FirebaseFirestore.instance
        .collection('attendees')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    if (attending == Attending.yes) {
      userDoc.set(<String, dynamic>{'attending': true});
    } else {
      userDoc.set(<String, dynamic>{'attending': false});
    }
  }

  Future<void> init() async {
    _setDefaultValues();
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FirebaseUIAuth.configureProviders([
      EmailAuthProvider(), //could add like Facebook auth etc
    ]);

    FirebaseFirestore.instance
        .collection('attendees')
        .where('attending', isEqualTo: true)
        .snapshots()
        .listen((snapshot) {
      _attendees = snapshot.docs.length;
      notifyListeners();
    });

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loggedIn = true;
        _emailVerified = user.emailVerified;
        _guestBookSubscription = FirebaseFirestore.instance
            .collection('guestbook')
            .orderBy('timestamp', descending: true)
            .snapshots()
            .listen((snapshot) {
          _guestBookMessages = [];
          for (final document in snapshot.docs) {
            _guestBookMessages.add(
              GuestBookMessage(
                name: document.data()['name'] as String,
                message: document.data()['text'] as String,
              ),
            );
          }
          notifyListeners();
        });
        _attendingSubscription = FirebaseFirestore.instance
            .collection('attendees')
            .doc(user.uid)
            .snapshots()
            .listen((snapshot) {
          if (snapshot.data() != null) {
            if (snapshot.data()!['attending'] as bool) {
              _attending = Attending.yes;
            } else {
              _attending = Attending.no;
            }
          } else {
            _attending = Attending.unknown;
          }
          notifyListeners();
        });
      } else {
        _loggedIn = false;
        _emailVerified = false;
        _guestBookMessages = [];
        _guestBookSubscription?.cancel();
        _attendingSubscription?.cancel();
      }
      notifyListeners();
    });
  }

  Future<void> refreshLoggedInUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser == null) {
      return;
    }

    await currentUser.reload();
  }

  Future<DocumentReference> addMessageToGuestBook(String message) {
    if (!_loggedIn) {
      throw Exception('Must be logged in');
    }

    return FirebaseFirestore.instance
        .collection('guestbook')
        .add(<String, dynamic>{
      'text': message,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
      'name': FirebaseAuth.instance.currentUser!.displayName,
      'userId': FirebaseAuth.instance.currentUser!.uid,
    });
  }
}
