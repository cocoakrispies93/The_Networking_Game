
// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_events.dart';
import '../firebase/guest_state_firebase.dart';
import '../app_styles/nav_bar_v2.dart';
import 'authentication.dart';
import '../a_check_weather/geo_auth_router.dart';


// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(ChangeNotifierProvider(
//     create: (context) => ApplicationState(),
//     builder: ((context, child) => const App()),
//   ));
// }

// class EventsMain extends StatelessWidget {
//   const EventsMain({super.key});

//   @override
//   Widget build(BuildContext context) {
//     // return ChangeNotifierProvider(
//     //   create: (context) => ApplicationState(),
//     //   builder: ((context, child) => const EventsMainState()),
//     // );
//     return const EventsMainState();
//   }
// }

final _router = GoRouter(routes: [
  GoRoute(
    path: '/', //Home path must be '/'
    builder: (context, state) => const EventsHome(), //changed!!!!!!!!
    //Maybe should be a separate screen just for the login
    //========================================
    //          New Set of Routes
    //========================================

    //=============
    //SIGN IN ROUTE
    //=============
    routes: [
      GoRoute(
        path: 'sign-in',
        builder: (context, state) {
          return SignInScreen(
            actions: [
              ForgotPasswordAction(((context, email) {
                final uri = Uri(
                  path: 'sign-in/forgot-password',
                  queryParameters: <String, String?>{
                    'email': email,
                  },
                );
                context.push(uri.toString());
                //GoRouter.of(context).go(uri.toString());
              })),
              AuthStateChangeAction(((context, state) {
                if (state is SignedIn || state is UserCreated) {
                  var user = (state is SignedIn)
                      ? state.user
                      : (state as UserCreated).credential.user;
                  if (user == null) {
                    return;
                  }
                  if (state is UserCreated) {
                    user.updateDisplayName(user.email!.split('@')[0]);
                  }
                  if (!user.emailVerified) {
                    user.sendEmailVerification();
                    const snackBar = SnackBar(
                        content: Text(
                            'Please check your email to verify your email address'));
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  }
                  context.pushReplacement('/');
                }
              })),
            ],
          );
        },
        //=======================
        //Sign-in/forgot password
        //=======================
        routes: [
          GoRoute(
            path: 'forgot-password',
            builder: (context, state) {
              final arguments = state.queryParams;
              return ForgotPasswordScreen(
                email: arguments['email'],
                headerMaxExtent: 200,
              );
            },
          ),
        ],
      ),
      //=======================
      //Sign-in/forgot password
      //=======================
      GoRoute(
        path: 'profile',
        builder: (context, state) {
          return Consumer<ApplicationState>(
            builder: (context, appState, _) => ProfileScreen(
              key: ValueKey(appState.emailVerified),
              providers: const [],
              actions: [
                SignedOutAction(
                  ((context) {
                    context.pushReplacement('/');
                  }),
                ),
              ],
              children: [
                Visibility(
                  visible: !appState.emailVerified,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.deepPurple,
                      backgroundColor: Colors.deepPurple.withOpacity(0.25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      appState.refreshLoggedInUser();
                    },
                    child: const Text('Recheck Verification State'),
                  ),
                )
              ],
            ),
          );
        },
      ),
      //=======================
      // Check weather button
      //=======================
      GoRoute(
        path: 'weather-forecast',
        builder: (context, state) {
          return const GeoAuth();
        },
      ),
    ],
  )
]);

// class EventsMainState extends StatelessWidget {
//   const EventsMainState({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'The Networking Game!',
//       theme: ThemeData(
//         buttonTheme: Theme.of(context).buttonTheme.copyWith(
//               highlightColor: Colors.deepPurple,
//             ),
//         primarySwatch: Colors.deepPurple,
//         textTheme: GoogleFonts.robotoTextTheme(
//           Theme.of(context).textTheme,
//         ),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         useMaterial3: true,
//       ),
//      
//       routerConfig: _router,
//     );
//   }
// }
