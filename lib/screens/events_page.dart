// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

//Modified by Shane

// ignore_for_file: avoid_print

import 'package:firebase_auth/firebase_auth.dart'
    hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//import '../app_styles/authentication.dart';
import '../app_styles/widget_styles.dart';
import '../firebase/guest_state_firebase.dart';
import '../firebase/guest_book.dart';
import '../firebase/yes_no_selection.dart';
import '../app_styles/nav_bar_v2.dart';
import '../main.dart';
//import '../login_screen.dart';
import '../firebase/guest_state_firebase.dart';
//import 'event_page/yes_no_selection.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../app_styles/nav_bar_v2.dart';
import '../a_check_weather/geo_auth_router.dart';
import '../firebase/guest_state_firebase.dart';
import '../screens/home_page.dart';
import '../screens/task_page.dart';
import '../screens/job_page.dart';
import '../screens/profile_page.dart';
import '../a_linkedin_api/connect_page.dart';
import '../firebase/guest_state_firebase.dart';
import '../events_screen/authentication.dart';
// import '../app_styles/nav_bar_v2_ooooooold.dart';

//==================
//NEWEST OLD VERSION
//==================

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Events Page!!'),
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        //   darkTheme: ThemeData(
        //   brightness: Brightness.dark,
        //   primaryColor: Colors.deepPurple,
        // ),
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
                  const Paragraph('No one going :('),
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
    );
  }
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/', //Home path must be '/'
    builder: (context, state) => const EventsPage(), //changed!!!!!!!!
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




































// // class EventsPage extends StatelessWidget {
// //   const EventsPage({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('The Networking Game'),
// //       ),
// //       body: ListView(
// //         children: <Widget>[
// //           Image.asset('assets/work_meet.jpg'),
// //           const SizedBox(height: 8),
// //           Consumer<ApplicationState>(
// //             builder: (context, appState, _) =>
// //                 IconAndDetail(Icons.calendar_today, appState.eventDate),
// //           ),
// //           const IconAndDetail(Icons.location_city, 'San Francisco'),
// //           Consumer<ApplicationState>(
// //             builder: (context, appState, _) => AuthFunc(
// //               loggedIn: appState.loggedIn,
// //               signOut: () {
// //                 FirebaseAuth.instance.signOut();
// //               },
// //               enableFreeSwag: appState.enableFreeSwag,
// //             ),
// //           ),
// //           const Divider(
// //             height: 8,
// //             thickness: 1,
// //             indent: 8,
// //             endIndent: 8,
// //             color: Colors.grey,
// //           ),
// //           const Header("What we'll be doing"),
// //           Consumer<ApplicationState>(
// //             builder: (context, appState, _) => Paragraph(
// //               appState.callToAction,
// //             ),
// //           ),
// //           Consumer<ApplicationState>(
// //             builder: (context, appState, _) => Column(
// //               crossAxisAlignment: CrossAxisAlignment.start,
// //               children: [
// //                 if (appState.attendees >= 2)
// //                   Paragraph('${appState.attendees} people going')
// //                 else if (appState.attendees == 1)
// //                   const Paragraph('1 person going')
// //                 else
// //                   const Paragraph('No one going'),
// //                 if (appState.loggedIn) ...[
// //                   YesNoSelection(
// //                     state: appState.attending,
// //                     onSelection: (attending) => appState.attending = attending,
// //                   ),
// //                   const Header('Discussion'),
// //                   GuestBook(
// //                     addMessage: (message) =>
// //                         appState.addMessageToGuestBook(message),
// //                     messages: appState.guestBookMessages,
// //                   ),
// //                 ],
// //               ],
// //             ),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// class LogInClass extends StatefulWidget {
//   // ignore: use_super_parameters
//   const LogInClass({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _LogInClassState createState() => _LogInClassState();
// }

// final _router = GoRouter(routes: [
//   GoRoute(
//     path: '/', //Home path must be '/'
//     builder: (context, state) => const EventsPage(), //changed!!!!!!!!
//     //Maybe should be a separate screen just for the login
//     //========================================
//     //          New Set of Routes
//     //========================================

//     //=============
//     //SIGN IN ROUTE
//     //=============
//     routes: [
//       GoRoute(
//         path: 'sign-in',
//         builder: (context, state) {
//           return SignInScreen(
//             actions: [
//               ForgotPasswordAction(((context, email) {
//                 final uri = Uri(
//                   path: 'sign-in/forgot-password',
//                   queryParameters: <String, String?>{
//                     'email': email,
//                   },
//                 );
//                 context.push(uri.toString());
//                 //GoRouter.of(context).go(uri.toString());
//               })),
//               AuthStateChangeAction(((context, state) {
//                 if (state is SignedIn || state is UserCreated) {
//                   var user = (state is SignedIn)
//                       ? state.user
//                       : (state as UserCreated).credential.user;
//                   if (user == null) {
//                     return;
//                   }
//                   if (state is UserCreated) {
//                     user.updateDisplayName(user.email!.split('@')[0]);
//                   }
//                   if (!user.emailVerified) {
//                     user.sendEmailVerification();
//                     const snackBar = SnackBar(
//                         content: Text(
//                             'Please check your email to verify your email address'));
//                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                   }
//                   context.pushReplacement('/');
//                 }
//               })),
//             ],
//           );
//         },
//         //=======================
//         //Sign-in/forgot password
//         //=======================
//         routes: [
//           GoRoute(
//             path: 'forgot-password',
//             builder: (context, state) {
//               final arguments = state.queryParams;
//               return ForgotPasswordScreen(
//                 email: arguments['email'],
//                 headerMaxExtent: 200,
//               );
//             },
//           ),
//         ],
//       ),
//       //=======================
//       //Sign-in/forgot password
//       //=======================
//       GoRoute(
//         path: 'profile',
//         builder: (context, state) {
//           return Consumer<ApplicationState>(
//             builder: (context, appState, _) => ProfileScreen(
//               key: ValueKey(appState.emailVerified),
//               providers: const [],
//               actions: [
//                 SignedOutAction(
//                   ((context) {
//                     context.pushReplacement('/');
//                   }),
//                 ),
//               ],
//               children: [
//                 Visibility(
//                   visible: !appState.emailVerified,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       foregroundColor: Colors.deepPurple,
//                       backgroundColor: Colors.deepPurple.withOpacity(0.25),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(8),
//                       ),
//                     ),
//                     onPressed: () {
//                       appState.refreshLoggedInUser();
//                     },
//                     child: const Text('Recheck Verification State'),
//                   ),
//                 )
//               ],
//             ),
//           );
//         },
//       ),
//       //=======================
//       // Check weather button
//       //=======================
//       GoRoute(
//         path: 'weather-forecast',
//         builder: (context, state) {
//           return const GeoAuth();
//         },
//       ),
//     ],
//   )
// ]);

// //==================================
// //  Previous Main App Widget Build
// //==================================

// class _LogInClassState extends State<LogInClass> {
//   //const _SignInState();

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'The Networking Game',
//       theme: ThemeData(
//         //brightness: Brightness.light,
//         buttonTheme: Theme.of(context).buttonTheme.copyWith(
//               highlightColor:
//                   Colors.deepPurple, // set highlight color to deep purple
//               colorScheme: const ColorScheme.light(
//                 primary: Color.fromARGB(
//                     255, 152, 137, 180), // set primary color to deep purple
//                 onPrimary: Colors.deepPurple, // set text color to white
//               ),
//             ),
//         textTheme: GoogleFonts.robotoTextTheme(
//           Theme.of(context).textTheme,
//         ),
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//         useMaterial3: true,
//         // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
//         //     .copyWith(background: const Color.fromARGB(255, 172, 228, 200)),
//         //scaffoldBackgroundColor: Colors.transparent,
//         scaffoldBackgroundColor: const Color.fromARGB(255, 172, 228, 200),
//       ),
//       routerConfig: _router,
//     );
//   }
// }

// class AuthFunc extends StatelessWidget {
//   const AuthFunc({
//     super.key,
//     required this.loggedIn,
//     required this.signOut,
//     this.enableFreeSwag = false,
//   });

//   final bool loggedIn;
//   final void Function() signOut;
//   final bool enableFreeSwag;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Padding(
//           padding: const EdgeInsets.only(left: 24, bottom: 8),
//           child: StyledButton(
//               onPressed: () {
//                 !loggedIn ? context.push('/sign-in') : signOut();
//               },
//               child: !loggedIn ? const Text('Going') : const Text('Logout')),
//         ),
//         Visibility(
//             visible: loggedIn,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 24, bottom: 8),
//               child: StyledButton(
//                   onPressed: () {
//                     context.push('/profile');
//                   },
//                   child: const Text('Profile')),
//             )),
//         Visibility(
//             visible: enableFreeSwag,
//             child: Padding(
//               padding: const EdgeInsets.only(left: 24, bottom: 8),
//               child: StyledButton(
//                   onPressed: () {
//                     throw Exception('free swag unimplemented');
//                   },
//                   child: const Text('Free swag!')),
//             )),
//         Padding(
//           padding: const EdgeInsets.only(left: 24, bottom: 8),
//           child: StyledButton(
//             onPressed: () {
//               context.push('/weather-forecast');
//             },
//             child: const Text('Check Weather'),
//           ),
//         ),
//       ],
//     );
//   }
// }













// // class EventsPage extends StatefulWidget {
// //   const EventsPage({super.key});

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _EventsPageState createState() => _EventsPageState();
// // }

// // final _router = GoRouter(routes: [
// //   GoRoute(
// //     path: '/', //Home path must be '/'
// //     builder: (context, state) => const EventsPage(), //changed!!!!!!!!
// //     //Maybe should be a separate screen just for the login
// //     //========================================
// //     //          New Set of Routes
// //     //========================================

// //     //=============
// //     //SIGN IN ROUTE
// //     //=============
// //     routes: [
// //       GoRoute(
// //         path: 'sign-in',
// //         builder: (context, state) {
// //           return SignInScreen(
// //             actions: [
// //               ForgotPasswordAction(((context, email) {
// //                 final uri = Uri(
// //                   path: 'sign-in/forgot-password',
// //                   queryParameters: <String, String?>{
// //                     'email': email,
// //                   },
// //                 );
// //                 context.push(uri.toString());
// //               })),
// //               AuthStateChangeAction(((context, state) {
// //                 if (state is SignedIn || state is UserCreated) {
// //                   var user = (state is SignedIn)
// //                       ? state.user
// //                       : (state as UserCreated).credential.user;
// //                   if (user == null) {
// //                     return;
// //                   }
// //                   if (state is UserCreated) {
// //                     user.updateDisplayName(user.email!.split('@')[0]);
// //                   }
// //                   if (!user.emailVerified) {
// //                     user.sendEmailVerification();
// //                     const snackBar = SnackBar(
// //                         content: Text(
// //                             'Please check your email to verify your email address'));
// //                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //                   }
// //                   context.pushReplacement('/');
// //                 }
// //               })),
// //             ],
// //           );
// //         },
// //         //=======================
// //         //Sign-in/forgot password
// //         //=======================
// //         routes: [
// //           GoRoute(
// //             path: 'forgot-password',
// //             builder: (context, state) {
// //               final arguments = state.queryParams;
// //               return ForgotPasswordScreen(
// //                 email: arguments['email'],
// //                 headerMaxExtent: 200,
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //       //=======================
// //       //Sign-in/forgot password
// //       //=======================
// //       GoRoute(
// //         path: 'profile',
// //         builder: (context, state) {
// //           return Consumer<ApplicationState>(
// //             builder: (context, appState, _) => ProfileScreen(
// //               key: ValueKey(appState.emailVerified),
// //               providers: const [],
// //               actions: [
// //                 SignedOutAction(
// //                   ((context) {
// //                     context.pushReplacement('/');
// //                   }),
// //                 ),
// //               ],
// //               children: [
// //                 Visibility(
// //                   visible: !appState.emailVerified,
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.deepPurple,
// //                       backgroundColor: Colors.deepPurple.withOpacity(0.25),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     onPressed: () {
// //                       appState.refreshLoggedInUser();
// //                     },
// //                     child: const Text('Recheck Verification State'),
// //                   ),
// //                 )
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //       //=======================
// //       // Check weather button
// //       //=======================
// //       GoRoute(
// //         path: 'weather-forecast',
// //         builder: (context, state) {
// //           return const GeoAuth();
// //         },
// //       ),
// //     ],
// //   )
// // ]);

// // class _EventsPageState extends State<EventsPage> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp.router(
// //       title: 'The Networking Game',
// //       theme: ThemeData(
// //         //brightness: Brightness.light,
// //         buttonTheme: Theme.of(context).buttonTheme.copyWith(
// //               highlightColor:
// //                   Colors.deepPurple, // set highlight color to deep purple
// //               colorScheme: const ColorScheme.light(
// //                 primary: Color.fromARGB(
// //                     255, 152, 137, 180), // set primary color to deep purple
// //                 onPrimary: Colors.deepPurple, // set text color to white
// //               ),
// //             ),
// //         textTheme: GoogleFonts.robotoTextTheme(
// //           Theme.of(context).textTheme,
// //         ),
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //         useMaterial3: true,
// //         // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
// //         //     .copyWith(background: const Color.fromARGB(255, 172, 228, 200)),
// //         //scaffoldBackgroundColor: Colors.transparent,
// //         scaffoldBackgroundColor: const Color.fromARGB(255, 172, 228, 200),
// //       ),
// //       routerConfig: _router,
// //     );
// //   }




































//   // final _router = GoRouter(
// //   routes: [
// //     GoRoute(
// //       path: '/',
// //       builder: (context, state) => const HomePage(),
// //       routes: [
// //         GoRoute(
// //           path: 'sign-in',
// //           builder: (context, state) {
// //             return SignInScreen(
// //               actions: [
// //                 ForgotPasswordAction(((context, email) {
// //                   final uri = Uri(
// //                     path: '/sign-in/forgot-password',
// //                     queryParameters: <String, String?>{
// //                       'email': email,
// //                     },
// //                   );
// //                   context.push(uri.toString());
// //                 })),
// //                 AuthStateChangeAction(((context, state) {
// //                   if (state is SignedIn || state is UserCreated) {
// //                     var user = (state is SignedIn)
// //                         ? state.user
// //                         : (state as UserCreated).credential.user;
// //                     if (user == null) {
// //                       return;
// //                     }
// //                     if (state is UserCreated) {
// //                       user.updateDisplayName(user.email!.split('@')[0]);
// //                     }
// //                     if (!user.emailVerified) {
// //                       user.sendEmailVerification();
// //                       const snackBar = SnackBar(
// //                           content: Text(
// //                               'Please check your email to verify your email address'));
// //                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //                     }
// //                     context.pushReplacement('/');
// //                   }
// //                 })),
// //               ],
// //             );
// //           },
// //           routes: [
// //             GoRoute(
// //               path: 'forgot-password',
// //               builder: (context, state) {
// //                 final arguments = state.queryParams;
// //                 return ForgotPasswordScreen(
// //                   email: arguments['email'],
// //                   headerMaxExtent: 200,
// //                 );
// //               },
// //             ),
// //           ],
// //         ),
// //         GoRoute(
// //           path: 'profile',
// //           builder: (context, state) {
// //             return Consumer<ApplicationState>(
// //               builder: (context, appState, _) => ProfileScreen(
// //                 key: ValueKey(appState.emailVerified),
// //                 providers: const [],
// //                 actions: [
// //                   SignedOutAction(
// //                     ((context) {
// //                       context.pushReplacement('/');
// //                     }),
// //                   ),
// //                 ],
// //                 children: [
// //                   Visibility(
// //                       visible: !appState.emailVerified,
// //                       child: OutlinedButton(
// //                         child: const Text('Recheck Verification State'),
// //                         onPressed: () {
// //                           appState.refreshLoggedInUser();
// //                         },
// //                       ))
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //       ],
// //     ),
// //   ],
// // );

// // final _router = GoRouter(routes: [
// //   GoRoute(
// //     path: '/', //Home path must be '/'
// //     builder: (context, state) => const EventsPage(),
// //     //========================================
// //     //          New Set of Routes
// //     //========================================

// //     //=============
// //     //SIGN IN ROUTE
// //     //=============

// //     routes: [
// //       GoRoute(
// //         path: 'sign-in',
// //         builder: (context, state) {
// //           return SignInScreen(
// //             actions: [
// //               ForgotPasswordAction(((context, email) {
// //                 final uri = Uri(
// //                   path: 'sign-in/forgot-password',
// //                   queryParameters: <String, String?>{
// //                     'email': email,
// //                   },
// //                 );
// //                 context.push(uri.toString());
// //               })),
// //               AuthStateChangeAction(((context, state) {
// //                 if (state is SignedIn || state is UserCreated) {
// //                   var user = (state is SignedIn)
// //                       ? state.user
// //                       : (state as UserCreated).credential.user;
// //                   if (user == null) {
// //                     return;
// //                   }
// //                   if (state is UserCreated) {
// //                     user.updateDisplayName(user.email!.split('@')[0]);
// //                   }
// //                   if (!user.emailVerified) {
// //                     user.sendEmailVerification();
// //                     const snackBar = SnackBar(
// //                         content: Text(
// //                             'Please check your email to verify your email address'));
// //                     ScaffoldMessenger.of(context).showSnackBar(snackBar);
// //                   }
// //                   context.pushReplacement('/');
// //                 }
// //               })),
// //             ],
// //           );
// //         },
// //         //=======================
// //         //Sign-in/forgot password
// //         //=======================
// //         routes: [
// //           GoRoute(
// //             path: 'sign-in/forgot-password',
// //             builder: (context, state) {
// //               final arguments = state.queryParams;
// //               return ForgotPasswordScreen(
// //                 email: arguments['email'],
// //                 headerMaxExtent: 200,
// //               );
// //             },
// //           ),
// //         ],
// //       ),
// //       //=======================
// //       //Sign-in/forgot password
// //       //=======================
// //       GoRoute(
// //         path: 'profile',
// //         builder: (context, state) {
// //           return Consumer<ApplicationState>(
// //             builder: (context, appState, _) => ProfileScreen(
// //               key: ValueKey(appState.emailVerified),
// //               providers: const [],
// //               actions: [
// //                 SignedOutAction(
// //                   ((context) {
// //                     context.pushReplacement('/');
// //                   }),
// //                 ),
// //               ],
// //               children: [
// //                 Visibility(
// //                   visible: !appState.emailVerified,
// //                   child: ElevatedButton(
// //                     style: ElevatedButton.styleFrom(
// //                       foregroundColor: Colors.deepPurple,
// //                       backgroundColor: Colors.deepPurple.withOpacity(0.25),
// //                       shape: RoundedRectangleBorder(
// //                         borderRadius: BorderRadius.circular(8),
// //                       ),
// //                     ),
// //                     onPressed: () {
// //                       appState.refreshLoggedInUser();
// //                     },
// //                     child: const Text('Recheck Verification State'),
// //                   ),
// //                 )
// //               ],
// //             ),
// //           );
// //         },
// //       ),
// //       //=======================
// //       // Check weather button
// //       //=======================
// //       GoRoute(
// //         path: 'weather-forecast',
// //         builder: (context, state) {
// //           return const GeoAuth();
// //         },
// //       ),
// //     ],
// //   )
// // ]);

//   // @override
//   // Widget build(BuildContext context) {
//   //   return MaterialApp.router(
//   //     title: 'The Networking Game',
//   //     theme: ThemeData(
//   //       buttonTheme: Theme.of(context).buttonTheme.copyWith(
//   //             highlightColor: Colors.deepPurple,
//   //           ),
//   //       primarySwatch: Colors.deepPurple,
//   //       textTheme: GoogleFonts.robotoTextTheme(
//   //         Theme.of(context).textTheme,
//   //       ),
//   //       visualDensity: VisualDensity.adaptivePlatformDensity,
//   //       useMaterial3: true,
//   //     ),
//   //     routerConfig: _router,
//   //   );
//   // }
// //}

// //==================================
// //  Previous Main App Widget Build
// //==================================
// // class SignInApp extends StatelessWidget {
// //   const SignInApp({super.key});

// //   //const _SignInState();

// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp.router(
// //       title: 'The Networking Game',
// //       theme: ThemeData(
// //         //brightness: Brightness.light,
// //         buttonTheme: Theme.of(context).buttonTheme.copyWith(
// //               highlightColor:
// //                   Colors.deepPurple, // set highlight color to deep purple
// //               colorScheme: const ColorScheme.light(
// //                 primary: Color.fromARGB(
// //                     255, 152, 137, 180), // set primary color to deep purple
// //                 onPrimary: Colors.deepPurple, // set text color to white
// //               ),
// //             ),
// //         textTheme: GoogleFonts.robotoTextTheme(
// //           Theme.of(context).textTheme,
// //         ),
// //         visualDensity: VisualDensity.adaptivePlatformDensity,
// //         useMaterial3: true,
// //         // colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
// //         //     .copyWith(background: const Color.fromARGB(255, 172, 228, 200)),
// //         //scaffoldBackgroundColor: Colors.transparent,
// //         scaffoldBackgroundColor: const Color.fromARGB(255, 172, 228, 200),
// //       ),
// //       routerConfig: _router,
// //       // builder: (context, router) {
// //       //   return Stack(
// //       //     children: [
// //       //       router!,
// //       //       const Positioned(
// //       //         bottom: 0,
// //       //         left: 0,
// //       //         right: 0,
// //       //         child: MyNavigationBar(),
// //       //       ),
// //       //     ],
// //       //   );
// //       // },
// //     );
// //   }
// // }

// // class SignInClass extends StatefulWidget {
// //   // ignore: use_super_parameters
// //   const SignInClass({Key? key}) : super(key: key);

// //   @override
// //   // ignore: library_private_types_in_public_api
// //   _SignInClassState createState() => _SignInClassState();
// // }

// // class _SignInClassState extends State<SignInClass> {
// //   @override
// //   Widget build(BuildContext context) {
// //     // WidgetsFlutterBinding.ensureInitialized();
// //     return ChangeNotifierProvider(
// //       create: (context) => ApplicationState(),
// //       builder: ((context, child) => const SignInApp()),
// //     );
// //   }
// // }

// //
// //
// //
// //
// //
// //











// //========================
// // Things that didn't work
// //========================

//   // @override
//   // void initState() {
//   //   _router = GoRouter(routes: [
//   //     GoRoute(
//   //       path: '/', //Home path must be '/'
//   //       builder: (context, state) => const EventsPage(), //changed!!!!!!!!
//   //       //Maybe should be a separate screen just for the login
//   //       //========================================
//   //       //          New Set of Routes
//   //       //========================================

//   //       //=============
//   //       //SIGN IN ROUTE
//   //       //=============
//   //       routes: [
//   //         GoRoute(
//   //           path: 'sign-in',
//   //           builder: (context, state) {
//   //             return SignInScreen(
//   //               actions: [
//   //                 ForgotPasswordAction(((context, email) {
//   //                   final uri = Uri(
//   //                     path: 'sign-in/forgot-password',
//   //                     queryParameters: <String, String?>{
//   //                       'email': email,
//   //                     },
//   //                   );
//   //                   context.push(uri.toString());
//   //                 })),
//   //                 AuthStateChangeAction(((context, state) {
//   //                   if (state is SignedIn || state is UserCreated) {
//   //                     var user = (state is SignedIn)
//   //                         ? state.user
//   //                         : (state as UserCreated).credential.user;
//   //                     if (user == null) {
//   //                       return;
//   //                     }
//   //                     if (state is UserCreated) {
//   //                       user.updateDisplayName(user.email!.split('@')[0]);
//   //                     }
//   //                     if (!user.emailVerified) {
//   //                       user.sendEmailVerification();
//   //                       const snackBar = SnackBar(
//   //                           content: Text(
//   //                               'Please check your email to verify your email address'));
//   //                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//   //                     }
//   //                     context.pushReplacement('/');
//   //                   }
//   //                 })),
//   //               ],
//   //             );
//   //           },
//   //           //=======================
//   //           //Sign-in/forgot password
//   //           //=======================
//   //           routes: [
//   //             GoRoute(
//   //               path: 'forgot-password',
//   //               builder: (context, state) {
//   //                 final arguments = state.queryParams;
//   //                 return ForgotPasswordScreen(
//   //                   email: arguments['email'],
//   //                   headerMaxExtent: 200,
//   //                 );
//   //               },
//   //             ),
//   //           ],
//   //         ),
//   //         //=======================
//   //         //Sign-in/forgot password
//   //         //=======================
//   //         GoRoute(
//   //           path: 'profile',
//   //           builder: (context, state) {
//   //             return Consumer<ApplicationState>(
//   //               builder: (context, appState, _) => ProfileScreen(
//   //                 key: ValueKey(appState.emailVerified),
//   //                 providers: const [],
//   //                 actions: [
//   //                   SignedOutAction(
//   //                     ((context) {
//   //                       context.pushReplacement('/');
//   //                     }),
//   //                   ),
//   //                 ],
//   //                 children: [
//   //                   Visibility(
//   //                     visible: !appState.emailVerified,
//   //                     child: ElevatedButton(
//   //                       style: ElevatedButton.styleFrom(
//   //                         foregroundColor: Colors.deepPurple,
//   //                         backgroundColor: Colors.deepPurple.withOpacity(0.25),
//   //                         shape: RoundedRectangleBorder(
//   //                           borderRadius: BorderRadius.circular(8),
//   //                         ),
//   //                       ),
//   //                       onPressed: () {
//   //                         appState.refreshLoggedInUser();
//   //                       },
//   //                       child: const Text('Recheck Verification State'),
//   //                     ),
//   //                   )
//   //                 ],
//   //               ),
//   //             );
//   //           },
//   //         ),
//   //         //=======================
//   //         // Check weather button
//   //         //=======================
//   //         GoRoute(
//   //           path: 'weather-forecast',
//   //           builder: (context, state) {
//   //             return const GeoAuth();
//   //           },
//   //         ),
//   //       ],
//   //     )
//   //   ]);
//   // }
