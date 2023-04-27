// ignore_for_file: avoid_print, library_private_types_in_public_api

import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

import '../a_linkedin_api/connect_page copy.dart';
import '../a_linkedin_api/connect_page.dart';
import '../screens/events_page.dart';
import '../screens/home_page.dart';
import '../screens/job_page.dart';
import '../screens/profile_page.dart';
import '../screens/task_page.dart';
//import '../login_screen.dart';
import 'widget_styles.dart';
import '../screens/connect_github2.dart';
import '../screens/connect_github.dart';
//import '../events_screen/events_router.dart';
import '../events_screen/home_events.dart';
import '../screens/main_OGcopy.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({super.key});

  @override
  State<MyNavigationBar> createState() => MyNavigationBarState();
}

class MyNavigationBarState extends State<MyNavigationBar> {
  int pageIndex = 0;
  int _selectedIndex = 0;

  final pages = [
    // const LogInClass(),
    '/home',
    '/events',
    '/job',
    '/profile',
    '/connect',
    '/tasks',
  ];

  // final pages = [
  //     //const LogInClass(),
  //     const HomePage(),
  //     const EventsMainState(),
  //     //const JobsList(),
  //     const ConnectGitHub2(),
  //     const ProfilePage(),
  //     const ConnectGitHub(),
  //     const TaskListPage(),
  // ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      pageIndex = index; // add this line to update pageIndex
      setPageState(index);
      Navigator.pushReplacementNamed(context, pages[index]);
      //Navigator.pushNamed(context, pages[index].toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    // ignore: no_leading_underscores_for_local_identifiers
    final List<BottomNavigationBarItem> _bottomNavBarItems = [
      BottomNavigationBarItem(
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        icon: pageIndex == 0
            ? const Icon(Icons.home_filled, size: 35)
            : const Icon(Icons.home_outlined, size: 35),
        label: 'Home', //0
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        icon: pageIndex == 1
            ? const Icon(Icons.event_available, size: 35)
            : const Icon(Icons.event_available_outlined, size: 35),
        label: 'Events', //1
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        icon: pageIndex == 2
            ? const Icon(Icons.work, size: 35)
            : const Icon(Icons.work_outline, size: 35),
        label: 'Job Search', //2
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        icon: pageIndex == 3
            ? const Icon(Icons.person, size: 35)
            : const Icon(Icons.person_outline, size: 35),
        label: 'Profile', //3
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        icon: pageIndex == 4
            ? const Icon(Icons.web, size: 35)
            : const Icon(Icons.web_outlined, size: 35),
        label: 'Connect', //4
      ),
      BottomNavigationBarItem(
        backgroundColor: Colors.deepPurple.withOpacity(0.20),
        icon: pageIndex == 5
            ? const Icon(Icons.task, size: 35)
            : const Icon(Icons.task_outlined, size: 35),
        label: 'Tasks', //5
      ),
    ];

    return Container(
      height: 69,
      decoration: BoxDecoration(
        color: Colors.deepPurple.withOpacity(0.2),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        border: Border.all(
          color: Colors.deepPurple,
          width: 2,
        ),
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        child: BottomNavigationBar(
          items: _bottomNavBarItems,
          currentIndex: pageIndex,
          selectedItemColor:
              //Colors.deepPurple,
              const Color.fromARGB(
                  255, 161, 91, 247), // set the color for the selected item
          unselectedItemColor: Colors.white,
          // any additional properties you want to set for the BottomNavigationBar
          onTap: (index) {
            //_onItemTapped(index);
            _onItemTapped(index);

            // setState(() {
            //   _selectedIndex = index;
            //   pageIndex = index; // add this line to update pageIndex
            //   setPageState(index);
            // });

            // setState(() {
            //   // _selectedIndex = index;
            //   // pageIndex = index; // add this line to update pageIndex
            //   //setSelectedIndex(index);
            //   setPageState(index);
            // });
          },
          selectedIconTheme: const IconThemeData(
            color: IconAndDetail.primaryColor,
            size: 35,
          ),
          unselectedIconTheme: const IconThemeData(
            color: IconAndDetail.inactiveIconColor,
            size: 35,
          ),
        ),
      ),
    );
  }

  // void setPageState(int index) {
  //   Navigator.pushNamed(context, pages[index]);
  // }
//}

  void setPageState(int index) {
    setState(() {
      _selectedIndex = index;
      pageIndex = index; // add this line to update pageIndex
      // setPageState(index); <- this function is not defined and seems unnecessary
    });
    switch (index) {
      // case 0:
      //   Navigator.of(context).pushNamed('/login'); //0
      //   break;
      case 0:
        Navigator.of(context).pushNamed('/home'); //0
        print('Navigating => Home and index is $index');
        break;
      case 1:
        Navigator.of(context).pushNamed('/events'); //1
        print('Navigating => events\nindex is $index');
        break;
      case 2:
        Navigator.of(context).pushNamed('/job'); //2
        print('Navigating => job\nindex is $index');
        break;
      case 3:
        Navigator.of(context).pushNamed('/profile'); //3
        print('Navigating => profile\nindex is $index');
        break;
      case 4:
        Navigator.of(context).pushNamed('/connect'); //4
        print('Navigating => connect\nindex is $index');
        break;
      case 5:
        Navigator.of(context).pushNamed('/tasks'); //5
        print('Navigating => tasks\nindex is $index');
        break;
    }
  }
}

// class MyNavigationBar extends StatefulWidget {
//   const MyNavigationBar({Key? key}) : super(key: key);

//   @override
//   _MyNavigationBarState createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   int pageIndex = 0;

//   final pages = [
//     const SignInClass(),
//     const HomePage(),
//     const EventsPage(),
//     const JobsList(),
//     const ProfilePage(),
//     const ConnectGitHub(),
//     const TaskListPage(),
//   ];

//   void _onItemTapped(int index) {
//     setState(() {
//       pageIndex = index;
//     });

//     switch (pageIndex) {
//       case 0:
//         Navigator.of(context).pushNamed('/home');
//         break;
//       case 1:
//         Navigator.of(context).pushNamed('/events');
//         break;
//       case 2:
//         Navigator.of(context).pushNamed('/job');
//         break;
//       case 3:
//         Navigator.of(context).pushNamed('/profile');
//         break;
//       case 4:
//         Navigator.of(context).pushNamed('/connect');
//         break;
//       case 5:
//         Navigator.of(context).pushNamed('/tasks');
//         break;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       items: [
//         BottomNavigationBarItem(
//           backgroundColor: Colors.deepPurple.withOpacity(0.20),
//           icon: pageIndex == 0
//               ? Column(
//                   children: const [
//                     Icon(Icons.home_filled, size: 35),
//                     Text('Home', style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               : const Icon(Icons.home_outlined, size: 35),
//           label: 'Home',
//         ),
//         BottomNavigationBarItem(
//           backgroundColor: Colors.deepPurple.withOpacity(0.20),
//           icon: pageIndex == 1
//               ? Column(
//                   children: const [
//                     Icon(Icons.event_available, size: 35),
//                     Text('Events', style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               : const Icon(Icons.event_available_outlined, size: 35),
//           label: 'Events',
//         ),
//         BottomNavigationBarItem(
//           backgroundColor: Colors.deepPurple.withOpacity(0.20),
//           icon: pageIndex == 2
//               ? Column(
//                   children: const [
//                     Icon(Icons.work, size: 35),
//                     Text('Job Search', style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               : const Icon(Icons.work_outline, size: 35),
//           label: 'Job Search',
//         ),
//         BottomNavigationBarItem(
//           backgroundColor: Colors.deepPurple.withOpacity(0.20),
//           icon: pageIndex == 3
//               ? Column(
//                   children: const [
//                     Icon(Icons.person, size: 35),
//                     Text('Profile', style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               : const Icon(Icons.person_outline, size: 35),
//           label: 'Profile',
//         ),
//         BottomNavigationBarItem(
//           backgroundColor: Colors.deepPurple.withOpacity(0.20),
//           icon: pageIndex == 4
//               ? Column(
//                   children: const [
//                     Icon(Icons.web, size: 35),
//                     Text('Connect', style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               : const Icon(Icons.web_outlined, size: 35),
//           label: 'Connect',
//         ),
//         BottomNavigationBarItem(
//           backgroundColor: Colors.deepPurple.withOpacity(0.20),
//           icon: pageIndex == 5
//               ? Column(
//                   children: const [
//                     Icon(Icons.assignment_turned_in, size: 35),
//                     Text('Tasks', style: TextStyle(fontSize: 12)),
//                   ],
//                 )
//               : const Icon(Icons.assignment_outlined, size: 35),
//           label: 'Tasks',
//         ),
//       ],
//       // currentIndex: pageIndex,
//       // selectedItemColor: Colors.deepPurple,
//       // unselectedItemColor: Colors.grey[700],
//       // onTap: _onItemTapped,
//       // type: BottomNavigationBarType.fixed,
//       currentIndex: pageIndex,
//       selectedItemColor: Colors.deepPurple,
//       unselectedItemColor: Colors.white,
//       onTap: _onItemTapped,
//       type: BottomNavigationBarType.fixed,
//       selectedIconTheme: const IconThemeData(color: Colors.deepPurple),
//     );
//   }
// }

//============================================================================

//   return Container(
//     height: 67,
//     decoration: BoxDecoration(
//       color: Colors.deepPurple.withOpacity(0.2),
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(50),
//         topRight: Radius.circular(50),
//       ),
//       border: Border.all(
//         color: Colors.deepPurple,
//         width: 1,
//       ),
//     ),

//     //
//     //==============================
//     //New Routing for Navigation Bar
//     //==============================
//     //
//     onTap: (index) {
//       setState(() {
//         //pageIndex = index;
//         //_selectedIndex = index;

//         print('pageIndex is $pageIndex,'
//             '_selectedIndex is $_selectedIndex');
//         setSelectedIndex(index);
//         setPageState(index);
//         print('pageIndex is $pageIndex,'
//             '_selectedIndex is $_selectedIndex');
//       });
//     },
//     selectedIconTheme: const IconThemeData(
//       color: IconAndDetail.primaryColor,
//       size: 35,
//     ),
//     unselectedIconTheme: const IconThemeData(
//       //color: IconAndDetail.inactiveIconColor,
//       color: IconAndDetail.inactiveIconColor,
//       size: 35,
//     ),
//     child: ClipRRect(
//       borderRadius: const BorderRadius.only(
//         topLeft: Radius.circular(20),
//         topRight: Radius.circular(20),
//       ),
//       child: BottomNavigationBar(
//         items: _bottomNavBarItems,
//         currentIndex: pageIndex,
//         // any additional properties you want to set for the BottomNavigationBar
//       ),
//     ),
//   );
// }

//==================================================================

//    return Container(
//       height: 67,
//       decoration: BoxDecoration(
//         color: Colors.deepPurple.withOpacity(0.2),
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(50),
//           topRight: Radius.circular(50),
//         ),
//         border: Border.all(
//           color: Colors.deepPurple,
//           width: 1,
//         ),
//       ),
//       //   gradient: LinearGradient(
//       //     begin: Alignment.topCenter,
//       //     end: Alignment.bottomCenter,
//       //     colors: [
//       //       Colors.deepPurple.withOpacity(0.4),
//       //       Colors.deepPurple.withOpacity(0.5),
//       //     ],
//       //   ),
//       // ),
//       child: Overlay(initialEntries: [
//         OverlayEntry(
//           builder: (context) => ClipRRect(
//   //borderRadius: BorderRadius.circular(20.0),
//   borderRadius: const BorderRadius.only(
//                   topLeft: Radius.circular(20),
//                   topRight: Radius.circular(20),
//                 ),
//   child: SizedBox(
//     width: MediaQuery.of(context).size.width,
//     child: DecoratedBox(
//       // your child widget here
//     ),
//   //),
// //),
//           // builder: (context) => SizedBox(
//           //   width: MediaQuery.of(context).size.width,
//           //   child: DecoratedBox(
//               //child: decoration: BoxDecoration(
//                 // borderRadius: const BorderRadius.only(
//                 //   topLeft: Radius.circular(20),
//                 //   topRight: Radius.circular(20),
//                 // ),
//                 border: Border.all(
//                   color: Colors.deepPurple,
//                   width: 1,
//                 ),
//               ),
//               child: BottomNavigationBar(
//                 items: _bottomNavBarItems,
//                 currentIndex: pageIndex,

//===========================================================

// child: Container(
//   decoration: BoxDecoration(
//     borderRadius: const BorderRadius.only(
//       topLeft: Radius.circular(20),
//       topRight: Radius.circular(20),
//     ),
//     color: Colors.deepPurple.withOpacity(0.20),
//   ),

// switch (index) {
//   case 0:
//     Navigator.pushNamed(context, '/home'); //0
//     break;
//   case 1:
//     Navigator.pushNamed(context, '/events'); //1
//     break;
//   case 2:
//     Navigator.pushNamed(context, '/job-search'); //2
//     break;
//   case 3:
//     Navigator.pushNamed(context, '/profile'); //3
//     break;
//   case 4:
//     Navigator.pushNamed(context, '/connect'); //4
//     break;
//   case 5:
//     Navigator.pushNamed(context, '/tasks'); //5
//     break;
// }

// routes: {
//       '/login': (context) => const SignInClass(), //previous main.dart file
//       '/home': (context) => const HomePage(),
//       '/events': (context) => const EventsPage(),
//       '/job': (context) => const JobSearchPage(),
//       '/profile': (context) => const ProfilePage(),
//       '/connect': (context) => const ConnectPage(),
//       '/tasks': (context) => const TaskListPage(),
//     },
