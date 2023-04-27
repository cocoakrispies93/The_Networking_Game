// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Modified by Shane D. May

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../app_styles/nav_bar_v2.dart';
import '../a_check_weather/geo_auth_router.dart';
import '../firebase/guest_state_firebase.dart';
import 'home_page.dart';
import 'task_page.dart';
import 'events_page.dart';
//import 'screens/login_screen.dart';

final _router = GoRouter(routes: [
  GoRoute(
    path: '/', //Home path must be '/'
    builder: (context, state) => const EventsPage(),
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
            path: 'sign-in/forgot-password',
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

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(ChangeNotifierProvider(
//     create: (context) => ApplicationState(),
//     builder: ((context, child) => const App()),
//   ));
// }

//==========================
//   Main App Widget Build
//==========================
class Events extends StatelessWidget {
  const Events({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'The Networking Game',
      theme: ThemeData(
        //brightness: Brightness.light,
        buttonTheme: Theme.of(context).buttonTheme.copyWith(
              highlightColor:
                  Colors.deepPurple, // set highlight color to deep purple
              colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(
                    255, 152, 137, 180), // set primary color to deep purple
                onPrimary: Colors.deepPurple, // set text color to white
              ),
            ),
        textTheme: GoogleFonts.robotoTextTheme(
          Theme.of(context).textTheme,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
        // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
        //     .copyWith(background: const Color.fromARGB(255, 172, 228, 200)),
        //scaffoldBackgroundColor: Colors.transparent,
        scaffoldBackgroundColor: const Color.fromARGB(255, 172, 228, 200),
      ),
      routerConfig: _router,
      builder: (context, router) {
        return Stack(
          children: [
            router!,
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: MyNavigationBar(),
            ),
          ],
        );
      },
    );
  }
}
