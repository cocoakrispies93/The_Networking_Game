// // ignore_for_file: avoid_print

// import 'package:flutter/material.dart';
// import '../linkedin_api/connect_page.dart';
// import '../screens/events_page.dart';
// import '../screens/home_page.dart';
// import '../screens/job_page.dart';
// import '../screens/profile_page.dart';
// import '../screens/task_page.dart';

// class MyNavigationBar extends StatefulWidget {
//   const MyNavigationBar({super.key});

//   @override
//   State<MyNavigationBar> createState() => _MyNavigationBarState();
// }

// class _MyNavigationBarState extends State<MyNavigationBar> {
//   int pageIndex = 0;

//   final pages = [
//     const HomePage(),
//     const EventsPage(),
//     const JobsList(),
//     const ProfilePage(),
//     ConnectPage(),
//     const TaskListPage(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 60,
//       decoration: BoxDecoration(
//         color: Theme.of(context).primaryColor,
//         borderRadius: const BorderRadius.only(
//           topLeft: Radius.circular(20),
//           topRight: Radius.circular(20),
//         ),
//       ),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           IconButton(
//             enableFeedback: true,
//             onPressed: () {
//               setState(() {
//                 print('setState Index 0');
//                 pageIndex = 0;
//                 Navigator.pushNamed(context, '/home');
//               });
//             },
//             icon: pageIndex == 0
//                 ? const Icon(
//                     Icons.home_filled,
//                     color: Color.fromARGB(255, 84, 38, 83),
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.home_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: true,
//             onPressed: () {
//               setState(() {
//                 print('setState Index 1');
//                 pageIndex = 1;
//                 Navigator.pushNamed(context, '/events');
//               });
//             },
//             icon: pageIndex == 1
//                 ? const Icon(
//                     Icons.event_available,
//                     color: Color.fromARGB(255, 84, 38, 83),
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.event_available_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 print('setState Index 2');
//                 pageIndex = 2;
//                 Navigator.pushNamed(context, '/job');
//               });
//             },
//             icon: pageIndex == 2
//                 ? const Icon(
//                     Icons.work,
//                     color: Color.fromARGB(255, 84, 38, 83),
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.work_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 print('setState Index 3');
//                 pageIndex = 3;
//                 Navigator.pushNamed(context, '/profile');
//               });
//             },
//             icon: pageIndex == 3
//                 ? const Icon(
//                     Icons.person,
//                     color: Color.fromARGB(255, 84, 38, 83),
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.person_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: false,
//             onPressed: () {
//               setState(() {
//                 print('setState Index 4');
//                 pageIndex = 4;
//                 Navigator.pushNamed(context, '/connect');
//               });
//             },
//             icon: pageIndex == 4
//                 ? const Icon(
//                     Icons.web,
//                     color: Color.fromARGB(255, 84, 38, 83),
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.web_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//           IconButton(
//             enableFeedback: true,
//             onPressed: () {
//               setState(() {
//                 print('setState Index 5');
//                 pageIndex = 5;
//                 Navigator.pushNamed(context, '/task');
//               });
//             },
//             icon: pageIndex == 5
//                 ? const Icon(
//                     Icons.add_task_rounded,
//                     color: Color.fromARGB(255, 84, 38, 83),
//                     size: 35,
//                   )
//                 : const Icon(
//                     Icons.add_task_outlined,
//                     color: Colors.white,
//                     size: 35,
//                   ),
//           ),
//         ],
//       ),
//     );
//   }
// }
