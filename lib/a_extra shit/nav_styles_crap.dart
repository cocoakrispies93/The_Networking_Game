

//====================
//    Nav Bar Crap
//====================

//import 'package:go_router/go_router.dart';
// import '../screens/home_pg.dart';
// import '../screens/events_pg.dart';
// import '../screens/job_pg.dart';
// import '../screens/profile_pg.dart';
// import '../screens/connect_pg.dart';
// import '../screens/task_pg.dart';

//late final GoRouter _router;


// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class MyNavigationBar extends StatelessWidget {
//   const MyNavigationBar({super.key,});

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: const [
//         BottomNavigationBarItem(
//           icon: Icon(Icons.home),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.event),
//           label: 'Events',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.search),
//           label: 'Job Search',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.person),
//           label: 'My Profile',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.connect_without_contact),
//           label: 'Connect',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.list),
//           label: 'Task List',
//         ),
//       ],
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             context.go('/screens/home_pg.dart');
//             break;
//           case 1:
//             context.go('/screens/events_pg.dart');
//             break;
//           case 2:
//             context.go('/screens/job-pg.dart');
//             break;
//           case 3:
//             context.go('/screens/profile_pg.dart');
//             break;
//           case 4:
//             context.go('/screens/connect_pg.dart');
//             break;
//           case 5:
//             context.go('/screens/task_pg.dart');
//             break;
//         }
//       },
//     );
//   }
// }




//====================
//    Nav Bar Crap
//====================

//import 'package:flutter/material.dart';
// //import 'package:webview_flutter/webview_flutter.dart';
// import 'package:go_router/go_router.dart';
// import '../screens/events_pg.dart';
// import '../screens/job_pg.dart';
// import '../screens/profile_pg.dart';
// import '../screens/connect_pg.dart';
// import '../screens/home_pg.dart';

// class MyNavigationBar extends StatefulWidget {
//   const MyNavigationBar({super.key});

//   @override
//   State<MyNavigationBar> createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   late final GoRouter _router;

//   @override
//   void initState() {
//     super.initState();
//     _router = GoRouter(
//       routes: [
//         GoRoute(
//           path: '/home',
//           builder: (context, state) => const HomePage(),
//         ),
//         GoRoute(
//           path: '/event',
//           builder: (context, state) => const EventsPage(),
//         ),
//         GoRoute(
//           path: '/profile',
//           builder: (context, state) => const ProfilePage(),
//         ),
//         GoRoute(
//           path: '/job_search',
//           builder: (context, state) => const JobSearchPage(),
//         ),
//         GoRoute(
//           path: '/connect',
//           builder: (context, state) => const ConnectPage(),
//         ),
//       ],
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//           // nav bar theme stuff
//           ),
//       routerDelegate: _router.routerDelegate,
//       routeInformationParser: _router.routeInformationParser,
//       builder: (context, router) {
//         return Scaffold(
//           body: router!,
//           drawer: Drawer(
//             child: ListView(
//               padding: EdgeInsets.zero,
//               children: <Widget>[
//                 const DrawerHeader(
//                   decoration: BoxDecoration(
//                     color: Colors.deepPurple,
//                   ),
//                   child: Text(
//                     'Navigation Menu',
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 24,
//                     ),
//                   ),
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.home),
//                   title: const Text('Home'),
//                   onTap: () {
//                     _router.go('/home');
//                     Navigator.pop(context);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.event),
//                   title: const Text('Events'),
//                   onTap: () {
//                     _router.go('/events');
//                     Navigator.pop(context);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.work),
//                   title: const Text('Job Search'),
//                   onTap: () {
//                     _router.go('/job_search');
//                     Navigator.pop(context);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.people),
//                   title: const Text('Profile'),
//                   onTap: () {
//                     _router.go('/profile');
//                     Navigator.pop(context);
//                   },
//                 ),
//                 ListTile(
//                   leading: const Icon(Icons.bluetooth_audio_rounded),
//                   title: const Text('Connect'),
//                   onTap: () {
//                     _router.go('/connect');
//                     Navigator.pop(context);
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }


//=====================================================

//======================
//  Major Nav Bar Crap
//======================


// import 'package:flutter/material.dart';
// //import 'package:webview_flutter/webview_flutter.dart';
// import 'package:go_router/go_router.dart';
// //import 'package:overlay/overlay.dart';
// import '../screens/events_pg.dart';
// import '../screens/job_pg.dart';
// import '../screens/profile_pg.dart';
// import '../screens/connect_pg.dart';
// import '../screens/home_pg.dart';

// class MyNavigationBar extends StatefulWidget {
//   const MyNavigationBar({super.key});

//   @override
//   State<MyNavigationBar> createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   int _currentIndex = 0;
//   int loadingPercentage = 0;
//   final String indeedURL =
//       'https://www.indeed.com/?from=gnav-employer--post-press--jobseeker';

  //late final GoRouter _router;
  // static const List<Widget> _screens = <Widget>[
  //   HomePage(), //good because import
  //   EventPage(),
  //   MyProfile(),
  //   JobSearchScreen(),
  //   ConnectScreen(),
  // ];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  //   if (index == 0) {
  //     _router.go('/'); //nav to home
  //   } else if (index == 1) {
  //     _router.go('/event'); //event page
  //   } else if (index == 2) {
  //     _router.go('/profile'); //profile
  //   } else if (index == 3) {
  //     _router.go('/job_search'); //job search
  //   } else if (index == 3) {
  //     _router.go('/connect'); //connect
  //   } else {
  //     _router.go('/'); //nav to home if it doesn't work
  //   }
  // }

  // @override
  // void initState() {
  //   super.initState();
  //   _currentIndex = 0;
  // }

  // final _router = GoRouter(
  //   routes: [
  //     GoRoute(
  //       path: '/home',
  //       builder: (context, state) => const HomePage(),
  //     ),
  //     GoRoute(
  //       path: '/event',
  //       builder: (context, state) => const EventsPage(),
  //     ),
  //     GoRoute(
  //       path: '/profile',
  //       builder: (context, state) => const ProfilePage(),
  //     ),
  //     GoRoute(
  //       path: '/job_search',
  //       builder: (context, state) => const JobSearchPage(),
  //     ),
  //     GoRoute(
  //       path: '/connect',
  //       builder: (context, state) => const ConnectPage(),
  //     ),
  //   ],
  // );

  // does this need Material.router
  // with routerConfig: _router,
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: _screens,
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         items: const <BottomNavigationBarItem>[
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event),
//             label: 'Events',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Job Search',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Profile',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.bluetooth_audio_rounded),
//             label: 'Connect',
//           ),
//         ],
//         currentIndex: _currentIndex,
//         selectedItemColor: Colors.deepPurple,
//         onTap: _onItemTapped,
//       ),
//     );
//   }
// }

// //NEW ONE 3
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//           // nav bar theme stuff
//           ),
//       routerConfig: _router,
//       builder: (context, child) {
//         return Material(
//           child: Scaffold(
//             body: IndexedStack(
//               index: _currentIndex,
//               children: [
//                 child ?? const SizedBox.shrink(),
//               ],
//             ),
//             bottomNavigationBar: Overlay(
//               initialEntries: [
//                 OverlayEntry(
//                   builder: (_) => BottomNavigationBar(
//                     items: const <BottomNavigationBarItem>[
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.home),
//                         label: 'Home',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.event),
//                         label: 'Events',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.work),
//                         label: 'Job Search',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.people),
//                         label: 'Profile',
//                       ),
//                       BottomNavigationBarItem(
//                         icon: Icon(Icons.bluetooth_audio_rounded),
//                         label: 'Connect',
//                       ),
//                     ],
//                     currentIndex: _currentIndex,
//                     selectedItemColor: Colors.deepPurple,
//                     onTap: (index) {
//                       setState(() {
//                         _currentIndex = index;
//                       });
//                     },
//                   ),
//                 ),
//               ],
//               // builder: (BuildContext context, OverlayEntry entry) {
//               // //: (BuildContext context, OverlayEntry entry) {
//               //   return Positioned(
//               //     bottom: 0,
//               //     left: 0,
//               //     right: 0,
//               //     child: entry as Widget,
//               //   );
//               // },
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

// // NEW ONE 2
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//           // nav bar theme stuff
//           ),
//       routerDelegate: _router.routerDelegate,
//       routeInformationParser: _router.routeInformationParser,
//       //routerConfig: _router,
//       builder: (context, child) {
//         return Scaffold(
//           body: IndexedStack(
//             index: _currentIndex,
//             children: [
//               child ?? const SizedBox.shrink(),
//             ],
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.event),
//                 label: 'Events',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.work),
//                 label: 'Job Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.people),
//                 label: 'Profile',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.bluetooth_audio_rounded),
//                 label: 'Connect',
//               ),
//             ],
//             currentIndex: _currentIndex,
//             selectedItemColor: Colors.deepPurple,
//             onTap: (index) {
//               setState(() {
//                 _currentIndex = index;
//               });
//             },
//           ),
//         );
//       },
//     );
//   }
// }












// // NEW ONE 1
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: IndexedStack(
//         index: _currentIndex,
//         children: [
//           Router.withConfig(
//             config: _router, 
//           ),
//         ],
//       ),
//       bottomNavigationBar: Overlay(
//         initialEntries: [
//           OverlayEntry(
//             builder: (_) => BottomNavigationBar(
//               items: const <BottomNavigationBarItem>[
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.home),
//                   label: 'Home',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.event),
//                   label: 'Events',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.work),
//                   label: 'Job Search',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.people),
//                   label: 'Profile',
//                 ),
//                 BottomNavigationBarItem(
//                   icon: Icon(Icons.bluetooth_audio_rounded),
//                   label: 'Connect',
//                 ),
//               ],
//               currentIndex: _currentIndex,
//               selectedItemColor: Colors.deepPurple,
//               onTap: (index) {
//                 setState(() {
//                   _currentIndex = index;
//                 });
//               },
//             ),
//           ),
//         ],
//         builder: (BuildContext context, OverlayEntry entry) {
//           return Positioned(
//             bottom: 0,
//             left: 0,
//             right: 0,
//             child: entry as Widget,
//           );
//         },
//       ),
//     );
//   }
// }








// //OLD ONE THAT KINDA WORKED
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp.router(
//       theme: ThemeData(
//           // nav bar theme stuff
//           ),
//       routerConfig: _router,
//       builder: (context, router) {
//         return Scaffold(
//           body: IndexedStack(
//             index: _currentIndex,
//             //children: _screens,
//           ),
//           bottomNavigationBar: BottomNavigationBar(
//             items: const <BottomNavigationBarItem>[
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.home),
//                 label: 'Home',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.event),
//                 label: 'Events',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.work),
//                 label: 'Job Search',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.people),
//                 label: 'Profile',
//               ),
//               BottomNavigationBarItem(
//                 icon: Icon(Icons.bluetooth_audio_rounded),
//                 label: 'Connect',
//               ),
//             ],
//             currentIndex: _currentIndex,
//             selectedItemColor: Colors.deepPurple,
//             //onTap: _onItemTapped,
//           ),
//         );
//       },
//     );
//   }
// }



//====================
//  Widget Styles Crap
//====================

/*
class StyledButton extends StatelessWidget {
  const StyledButton({required this.child, required this.onPressed, super.key});
  final Widget child;
  final void Function() onPressed;
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.deepPurple),
          color: Colors.deepPurple.withOpacity(0.25),
          borderRadius: BorderRadius.circular(8),
        ),
        child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
            side: const BorderSide(color: Colors.deepPurple),
          ),
          child: child,
        ),
      );
}
*/
