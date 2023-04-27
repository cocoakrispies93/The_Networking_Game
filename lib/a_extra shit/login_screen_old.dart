// import 'package:firebase_ui_auth/firebase_ui_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// //import 'package:google_fonts/google_fonts.dart';
// import 'package:provider/provider.dart';

// import '../app_styles/nav_bar_v2.dart';
// import '../check_weather/geo_auth_router.dart';
// import '../firebase/guest_state_firebase.dart';
// import '../screens/home_page.dart';
// import '../screens/task_page.dart';

// final _router = GoRouter(
//   routes: [
//     GoRoute(
//       path: '/',
//       builder: (context, state) => const HomePage(),
//       routes: [
//         GoRoute(
//           path: 'sign-in',
//           builder: (context, state) {
//             return SignInScreen(
//               actions: [
//                 ForgotPasswordAction(((context, email) {
//                   final uri = Uri(
//                     path: 'sign-in/forgot-password',
//                     queryParameters: <String, String?>{
//                       'email': email,
//                     },
//                   );
//                   context.push(uri.toString());
//                 })),
//                 AuthStateChangeAction(((context, state) {
//                   if (state is SignedIn || state is UserCreated) {
//                     var user = (state is SignedIn)
//                         ? state.user
//                         : (state as UserCreated).credential.user;
//                     if (user == null) {
//                       return;
//                     }
//                     if (state is UserCreated) {
//                       user.updateDisplayName(user.email!.split('@')[0]);
//                     }
//                     if (!user.emailVerified) {
//                       user.sendEmailVerification();
//                       const snackBar = SnackBar(
//                           content: Text(
//                               'Please check your email to verify your email address'));
//                       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//                     }
//                     context.pushReplacement('/');
//                   }
//                 })),
//               ],
//             );
//           },
//           routes: [
//             GoRoute(
//               path: 'sign-in/forgot-password',
//               builder: (context, state) {
//                 final arguments = state.queryParams;
//                 return ForgotPasswordScreen(
//                   email: arguments['email'],
//                   headerMaxExtent: 200,
//                 );
//               },
//             ),
//           ],
//         ),
//         GoRoute(
//           path: 'profile',
//           builder: (context, state) {
//             return Consumer<ApplicationState>(
//               builder: (context, appState, _) => ProfileScreen(
//                 key: ValueKey(appState.emailVerified),
//                 providers: const [],
//                 actions: [
//                   SignedOutAction(
//                     ((context) {
//                       context.pushReplacement('/');
//                     }),
//                   ),
//                 ],
//                 children: [
//                   Visibility(
//                     visible: !appState.emailVerified,
//                     child: ElevatedButton(
//                       style: ElevatedButton.styleFrom(
//                         foregroundColor: Colors.deepPurple,
//                         backgroundColor: Colors.deepPurple.withOpacity(0.25),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(8),
//                         ),
//                       ),
//                       onPressed: () {
//                         appState.refreshLoggedInUser();
//                       },
//                       child: const Text('Recheck Verification State'),
//                     ),
//                   )
//                 ],
//               ),
//             );
//           },
//         ),
//         GoRoute(
//           path: 'weather-forecast',
//           builder: (context, state) {
//             return const GeoAuth();
//           },
//         ),
//         GoRoute(
//           path: 'task-list',
//           builder: (context, state) {
//             return const TaskListPage();
//           },
//         ),
//       ],
//     ),
//   ],
// );




// // List<GoRoute> getRoutes(BuildContext context) {
// //   return [
// //     GoRoute(
// //       path: '/', //Home path must be '/'
// //       builder: (context, state) => const HomePage(),
// //       //========================================
// //       //          New Set of Routes
// //       //========================================

// //       routes: [
// //         //=============
// //         //SIGN IN ROUTE
// //         //=============
// //         GoRoute(
// //           path: 'sign-in',
// //           builder: (context, state) {
// //             return SignInScreen(
// //               actions: [
// //                 ForgotPasswordAction(((context, email) {
// //                   final uri = Uri(
// //                     path: 'sign-in/forgot-password',
// //                     queryParameters: <String, String?>{
// //                       'email': email,
// //                     },
// //                   );
// //                   context.push(uri.toString());
// //                 })),
// //                 //===============================
// //                 //SIGN IN > FORGOT PASSWORD ROUTE
// //                 //===============================
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
// //           //========================================
// //           //          New Set of Routes
// //           //========================================
// //           routes: [
// //             GoRoute(
// //               //========================================
// //               // GET FORGOTTEN PASSWORD WITH EMAIL ROUTE
// //               //========================================
// //               path: 'sign-in/forgot-password',
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
// //           //==============
// //           // PROFILE ROUTE
// //           //==============
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
// //                     //================================
// //                     // CHECKING VERIFIED ACCOUNT ROUTE
// //                     //================================
// //                     visible: !appState.emailVerified,
// //                     child: ElevatedButton(
// //                       style: ElevatedButton.styleFrom(
// //                         foregroundColor: Colors.deepPurple, //text color
// //                         backgroundColor: Colors.deepPurple.withOpacity(0.25),
// //                         shape: RoundedRectangleBorder(
// //                           borderRadius: BorderRadius.circular(8),
// //                         ),
// //                       ),
// //                       onPressed: () {
// //                         appState.refreshLoggedInUser();
// //                       },
// //                       child: const Text('Recheck Verification State'),
// //                     ),
// //                   )
// //                 ],
// //               ),
// //             );
// //           },
// //         ),
// //         GoRoute(
// //           //=======================
// //           // WEATHER FORECAST ROUTE
// //           //=======================
// //           path: 'weather-forecast',
// //           builder: (context, state) {
// //             return const GeoAuth();
// //           },
// //         ),
// //         //=================
// //         GoRoute(
// //           //========================
// //           //    Task List Route
// //           //========================
// //           path: 'task-list',
// //           builder: (context, state) {
// //             return const TaskListPage();
// //           },
// //         ),
// //         //=================
// //       ],
// //     ),
// //   ];
// // }
