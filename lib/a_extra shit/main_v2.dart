// // Copyright 2022 The Flutter Authors. All rights reserved.
// // Use of this source code is governed by a BSD-style license that can be
// // found in the LICENSE file.

// // Modified by Shane D. May

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
// import 'login_screen_old.dart';

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();

//   runApp(ChangeNotifierProvider(
//     create: (context) => ApplicationState(),
//     builder: ((context, child) => const App()),
//   ));
// }



// //==========================
// //   Main App Widget Build
// //==========================
// class App extends StatelessWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       title: 'The Networking Game',
//       theme: ThemeData(
//         brightness: Brightness.light,
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
//         colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.deepPurple)
//             .copyWith(background: const Color.fromARGB(255, 172, 228, 200)),
//       ),
//       //routerConfig: _router,
//       //routerDelegate: _router.routerDelegate,
//       //routeInformationParser: _router.routeInformationParser,
//       builder: (context, router) {
//         return Stack(
//           children: [
//             router!,
//             const Positioned(
//               bottom: 0,
//               left: 0,
//               right: 0,
//               child: MyNavigationBar(),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }