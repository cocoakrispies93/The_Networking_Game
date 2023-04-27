

//==============================
// Main shit from key parameters
//==============================




//from what I understand, these are named and non-ordered
        //the login route will be referenced anytime there's a question
        //on whether or not the user has signed in or needs to sign up
        //

        //login gets called for events, and probably other stuff later
        //

//title: 'The Networking Game',
      //navigatorKey: navKey,
      //navigatorKey: navigatorKey,
      // key: navKey,
      // navigatorKey: navigatorKey,






// final GlobalKey<MyNavigationBarState> navKey =
    //     GlobalKey<MyNavigationBarState>();
    // final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

    // ignore: avoid_print








//       darkTheme: ThemeData(
//         brightness: Brightness.dark,
//         primaryColor: Colors.deepPurple,
//       ),
//       //themeMode: ThemeMode.system,
//       builder: (context, child) {
//         return Scaffold(
//             body: Scaffold(
//           body: ListView(
//             children: [
//               Image.asset('assets/wallpaper.jpg'),
//               Row(
//                 children: [
//                   IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
//                   const SizedBox(width: 8),
//                   const Text('User Profile'),
//                 ],
//               ),
//               const SizedBox(height: 8),
//               // ListTile(
//               //   leading: const Icon(Icons.event),
//               //   title: const Text('Upcoming Events'),
//               //   onTap: () {},
//               // ),
//               const ExpansionTile(
//                 leading: Icon(Icons.event),
//                 title: Text('Upcoming Events'),
//                 children: [
//                   ListTile(
//                     title: Text('Event 1'),
//                     subtitle: Text(
//                         'Date: 1/1/2024, Time: 10:00 AM, Location: New York'),
//                   ),
//                   ListTile(
//                     title: Text('Event 2'),
//                     subtitle: Text(
//                         'Date: 1/2/2024, Time: 2:00 PM, Location: San Francisco'),
//                   ),
//                   ListTile(
//                     title: Text('Event 3'),
//                     subtitle: Text(
//                         'Date: 1/3/2024, Time: 7:00 PM, Location: Chicago'),
//                   ),
//                 ],
//               ),
//               // ListTile(
//               //   leading: const Icon(Icons.work),
//               //   title: const Text('Job Search'),
//               //   onTap: () {},
//               // ),
//               const ExpansionTile(
//                 leading: Icon(Icons.work),
//                 title: Text('Work history'),
//                 children: [
//                   ListTile(
//                     title: Text('Job 1'),
//                     subtitle: Text('IT Intern'),
//                   ),
//                   ListTile(
//                     title: Text('Job 2'),
//                     subtitle: Text('Help Desk Tier 1'),
//                   ),
//                   ListTile(
//                     title: Text('Job 3'),
//                     subtitle: Text('Junior Programmer'),
//                   ),
//                 ],
//               ),
//               // ListTile(
//               //   leading: const Icon(Icons.people),
//               //   title: const Text('Connect with People'),
//               //   onTap: () {},
//               // ),
//               const ExpansionTile(
//                 leading: Icon(Icons.people),
//                 title: Text('My achievements'),
//                 children: [
//                   ListTile(
//                     title: Text('Trophy 1'),
//                     subtitle: Text('Best resume'),
//                   ),
//                   ListTile(
//                     title: Text('Trophy 2'),
//                     subtitle: Text('Job seeker'),
//                   ),
//                   ListTile(
//                     title: Text('Trophy 3'),
//                     subtitle: Text('Performance streak'),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//           bottomNavigationBar: const MyNavigationBar(),
//           // bottomNavigationBar: MyNavigationBar(
//           //   key: navKey,
//           //   navigatorKey: navigatorKey,
//           //   onIndexChanged: (index) {
//           //     // Update the current page when the navigation bar is tapped
//           //     navigatorKey.currentState!.pushReplacementNamed([
//           //       '/home',
//           //       '/events',
//           //       '/job',
//           //       '/profile',
//           //       '/connect',
//           //       '/tasks',
//           //     ][index as int]);
//         ));
//       },
//     );
//   }
// }



//
//
//
//
//
//
//
//

//      home: Scaffold(
//         body: ListView(
//           children: [
//             Image.asset('assets/wallpaper.jpg'),
//             Row(
//               children: [
//                 IconButton(onPressed: () {}, icon: const Icon(Icons.person)),
//                 const SizedBox(width: 8),
//                 const Text('User Profile'),
//               ],
//             ),
//             const SizedBox(height: 8),
//             ListTile(
//               leading: const Icon(Icons.event),
//               title: const Text('Upcoming Events'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.work),
//               title: const Text('Job Search'),
//               onTap: () {},
//             ),
//             ListTile(
//               leading: const Icon(Icons.people),
//               title: const Text('Connect with People'),
//               onTap: () {},
//             ),
//           ],
//         ),
//         //bottomNavigationBar: const MyNavigationBar(),
//         bottomNavigationBar: const MyNavigationBar(key: Key('navKey')),
//       ),
//     );
//   }
// }

//
//
//
//
//
//
//
//
//
//
//
//
//
//
//
//

//final _router = GoRouter(routes: [
//   GoRoute(
//     path: '/', //Home path must be '/'
//     builder: (context, state) => const HomePage(),
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
//             path: 'sign-in/forgot-password',
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







//===============
// Main: Go Route
//===============


        //   GoRoute(
        //   path: '/',
        //   pageBuilder: (context, state) => HomePage(),
        // ),
        // GoRoute(
        //   path: '/job_search',
        //   pageBuilder: (context, state) => JobSearchScreen(),
        // ),
        // GoRoute(
        //   path: '/event',
        //   pageBuilder: (context, state) => EventScreen(),
        // ),
        // GoRoute(
        //   path: '/connect',
        //   pageBuilder: (context, state) => ConnectScreen(),
        // ),


        /*
        child: OutlinedButton(
          child: const Text('Recheck Verification State'),
          onPressed: () {
            appState.refreshLoggedInUser();
          },
        ) */