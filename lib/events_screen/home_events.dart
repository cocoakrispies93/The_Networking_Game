// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

//Modified by Shane

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

import '../firebase/guest_book.dart';
import '../firebase/guest_state_firebase.dart';
import 'authentication.dart';
import '../app_styles/widget_styles.dart';
import '../firebase/yes_no_selection.dart';
import '../app_styles/nav_bar_v2.dart';

// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// //import '../app_styles/authentication.dart';
// import '../app_styles/widget_styles.dart';
// import '../firebase/guest_state_firebase.dart';
// import '../firebase/guest_book.dart';
// import '../firebase/yes_no_selection.dart';
// import '../app_styles/nav_bar_v2.dart';
// import '../main.dart';
// //import '../login_screen.dart';
// import '../firebase/guest_state_firebase.dart';
// //import 'event_page/yes_no_selection.dart';

// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../app_styles/nav_bar_v2.dart';
// import '../check_weather/geo_auth_router.dart';
// import '../firebase/guest_state_firebase.dart';
// import '../screens/home_page.dart';
// import '../screens/task_page.dart';
// import '../screens/job_page.dart';
// import '../screens/events_page.dart';
// import '../screens/profile_page.dart';
// import '../linkedin_api/connect_page.dart';
// import '../firebase/guest_state_firebase.dart';

class EventsHome extends StatelessWidget {
  const EventsHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('The Networking Game!'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/work_meet.jpg'),
          const SizedBox(height: 8),
          Consumer<ApplicationState>(
            builder: (context, appState, _) =>
                IconAndDetail(Icons.calendar_today, appState.eventDate),
          ),
          const IconAndDetail(Icons.location_city, 'San Francisco'),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => AuthFunc(
              loggedIn: appState.loggedIn,
              signOut: () {
                FirebaseAuth.instance.signOut();
              },
              enableFreeSwag: appState.enableFreeSwag,
            ),
          ),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.grey,
          ),
          const Header("What we'll be doing"),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Paragraph(
              appState.callToAction,
            ),
          ),
          Consumer<ApplicationState>(
            builder: (context, appState, _) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (appState.attendees >= 2)
                  Paragraph('${appState.attendees} people going')
                else if (appState.attendees == 1)
                  const Paragraph('1 person going')
                else
                  const Paragraph('No one going'),
                if (appState.loggedIn) ...[
                  YesNoSelection(
                    state: appState.attending,
                    onSelection: (attending) => appState.attending = attending,
                  ),
                  const Header('Discussion'),
                  GuestBook(
                    addMessage: (message) =>
                        appState.addMessageToGuestBook(message),
                    messages: appState.guestBookMessages,
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
      extendBody: true,
      //routerConfig: _router,
    );
  }
}
