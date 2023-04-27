// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: avoid_print

// Modified by Shane, a duplicate of event_page for now

//import 'package:firebase_auth/firebase_auth.dart'
//hide EmailAuthProvider, PhoneAuthProvider;
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import '../app_styles/authentication.dart';
// import '../app_styles/widget_styles.dart';
// import '../firebase_states/app_state.dart';
// import '../firebase_states/guest_book.dart';
// import '../firebase_states/yes_no_selection.dart';
//import '../app_styles/nav_bar_v2.dart';
import '../app_styles/nav_bar_v2.dart';
import '../firebase/guest_state_firebase.dart';
// import '../app_styles/nav_bar_v2_ooooooold.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final MyNavigationBarState _navigationBarKey =
  //     MyNavigationBarState(); //MyNavigationBarState
  // final int homeIndex = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   _navigationBarKey.setSelectedIndex(homeIndex);
  //   print('home_page: _navigationBarKey.setSelectedIndex($homeIndex);');
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'The Networking Game',
        darkTheme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.deepPurple,
        ),
        //themeMode: ThemeMode.system,
        // builder: (context, child) {
        //   return Scaffold(
        builder: (context, child) => Scaffold(
              body: ListView(
                children: [
                  Image.asset('assets/wallpaper.jpg'),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {}, icon: const Icon(Icons.person)),
                      const SizedBox(width: 8),
                      const Text('User Profile'),
                    ],
                  ),
                  const SizedBox(height: 8),
                  const ExpansionTile(
                    leading: Icon(Icons.event),
                    title: Text('Upcoming Events'),
                    children: [
                      ListTile(
                        title: Text('Event 1'),
                        subtitle: Text(
                            'Date: 1/1/2024, Time: 10:00 AM, Location: New York'),
                      ),
                      ListTile(
                        title: Text('Event 2'),
                        subtitle: Text(
                            'Date: 1/2/2024, Time: 2:00 PM, Location: San Francisco'),
                      ),
                      ListTile(
                        title: Text('Event 3'),
                        subtitle: Text(
                            'Date: 1/3/2024, Time: 7:00 PM, Location: Chicago'),
                      ),
                    ],
                  ),
                  const ExpansionTile(
                    leading: Icon(Icons.work),
                    title: Text('Work history'),
                    children: [
                      ListTile(
                        title: Text('Job 1'),
                        subtitle: Text('IT Intern'),
                      ),
                      ListTile(
                        title: Text('Job 2'),
                        subtitle: Text('Help Desk Tier 1'),
                      ),
                      ListTile(
                        title: Text('Job 3'),
                        subtitle: Text('Junior Programmer'),
                      ),
                    ],
                  ),
                  const ExpansionTile(
                    leading: Icon(Icons.people),
                    title: Text('My achievements'),
                    children: [
                      ListTile(
                        title: Text('Trophy 1'),
                        subtitle: Text('Best resume'),
                      ),
                      ListTile(
                        title: Text('Trophy 2'),
                        subtitle: Text('Job seeker'),
                      ),
                      ListTile(
                        title: Text('Trophy 3'),
                        subtitle: Text('Performance streak'),
                      ),
                    ],
                  ),
                ],
              ),
              bottomNavigationBar: const MyNavigationBar(),
              extendBody: true,
            ));
  }
}























//       home: Scaffold(
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
//       //bottomNavigationBar: const MyNavigationBar(key: Key('navKey')),
//       bottomNavigationBar: const MyNavigationBar(),
//       ),
//     );
//   }
// }
