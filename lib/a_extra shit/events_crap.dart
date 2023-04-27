

//===============
//  Events Crap
//===============


// class _HomePageState extends State<HomePage> {

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('The Networking Game'),
//       ),
//       body: _screens[_currentIndex],
//       bottomNavigationBar: const MyNavigationBar(),
//     );
//   }
// }


// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'The Networking Game',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const HomePage(),
//     );
//   }
// }


// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);

//   @override
//   // ignore: library_private_types_in_public_api
//   _HomePageState createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('The Networking Game'),
//       ),
//       body: ListView(
//         children: <Widget>[
//           Image.asset('assets/work_meet.jpg'),
//           const SizedBox(height: 8),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) =>
//                 IconAndDetail(Icons.calendar_today, appState.eventDate),
//           ),
//           const IconAndDetail(Icons.location_city, 'San Francisco'),
//           //IconAndDetail(Icons.location_city, nextMonday.toString()),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => AuthFunc(
//               loggedIn: appState.loggedIn,
//               signOut: () {
//                 FirebaseAuth.instance.signOut();
//               },
//               enableFreeSwag: appState.enableFreeSwag,
//             ),
//           ),
//           const Divider(
//             height: 8,
//             thickness: 1,
//             indent: 8,
//             endIndent: 8,
//             color: Colors.grey,
//           ),
//           const Header("What we'll be doing"),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Paragraph(
//               appState.callToAction,
//             ),
//           ),
//           Consumer<ApplicationState>(
//             builder: (context, appState, _) => Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 if (appState.attendees >= 2)
//                   Paragraph('${appState.attendees} people going')
//                 else if (appState.attendees == 1)
//                   const Paragraph('1 person going')
//                 else
//                   const Paragraph('No one going :('),
//                 if (appState.loggedIn) ...[
//                   YesNoSelection(
//                     state: appState.attending,
//                     onSelection: (attending) => appState.attending = attending,
//                   ),
//                   const Header('Discussion'),
//                   GuestBook(
//                     addMessage: (message) =>
//                         appState.addMessageToGuestBook(message),
//                     messages: appState.guestBookMessages,
//                   ),
//                 ],
//               ],
//             ),
//           ),
//         ],
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: 0,
//         onTap: (index) {
//           if (index == 1) {
//             Navigator.push(
//               context,
//               MaterialPageRoute(builder: (context) => const EventScreen()),
//             );
//           }
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event),
//             label: 'Events',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Connect',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Job Search',
//           ),
//         ],
//       ),
//     );
//   }
// }



// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();

//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('The Networking Game'),
//         ),
//         body: ListView(
//           children: <Widget>[
//             Image.asset('assets/work_meet.jpg'),
//             const SizedBox(height: 8),
//             Consumer<ApplicationState>(
//               builder: (context, appState, _) =>
//                   IconAndDetail(Icons.calendar_today, appState.eventDate),
//             ),
//             const IconAndDetail(Icons.location_city, 'San Francisco'),
//             //IconAndDetail(Icons.location_city, nextMonday.toString()),
//             Consumer<ApplicationState>(
//               builder: (context, appState, _) => AuthFunc(
//                 loggedIn: appState.loggedIn,
//                 signOut: () {
//                   FirebaseAuth.instance.signOut();
//                 },
//                 enableFreeSwag: appState.enableFreeSwag,
//               ),
//             ),
//             const Divider(
//               height: 8,
//               thickness: 1,
//               indent: 8,
//               endIndent: 8,
//               color: Colors.grey,
//             ),
//             const Header("What we'll be doing"),
//             Consumer<ApplicationState>(
//               builder: (context, appState, _) => Paragraph(
//                 appState.callToAction,
//               ),
//             ),
//             Consumer<ApplicationState>(
//               builder: (context, appState, _) => Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (appState.attendees >= 2)
//                     Paragraph('${appState.attendees} people going')
//                   else if (appState.attendees == 1)
//                     const Paragraph('1 person going')
//                   else
//                     const Paragraph('No one going :('),
//                   if (appState.loggedIn) ...[
//                     YesNoSelection(
//                       state: appState.attending,
//                       onSelection: (attending) =>
//                           appState.attending = attending,
//                     ),
//                     const Header('Discussion'),
//                     GuestBook(
//                       addMessage: (message) =>
//                           appState.addMessageToGuestBook(message),
//                       messages: appState.guestBookMessages,
//                     ),
//                   ],
//                 ],
//               ),
//             ),
//           ],
//         ));
//   }
// }

// class _HomePageState extends State<HomePage> {
//   int _currentIndex = 0;
//   final List<Widget> _screens = [
//     const HomePage(),
//     const EventScreen(),
//     const ConnectScreen(),
//     const JobSearchScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('The Networking Game'),
//       ),
//       body: PageView(
//         children: _screens,
//         onPageChanged: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//       ),
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _currentIndex,
//         onTap: (index) {
//           setState(() {
//             _currentIndex = index;
//           });
//         },
//         items: const [
//           BottomNavigationBarItem(
//             icon: Icon(Icons.home),
//             label: 'Home',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.event),
//             label: 'Events',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.people),
//             label: 'Connect',
//           ),
//           BottomNavigationBarItem(
//             icon: Icon(Icons.work),
//             label: 'Job Search',
//           ),
//         ],
//       ),
//     );
//   }
// }

// // class _HomePageState2 extends State<HomePage> {
// //   int _currentIndex = 0;
// //   final List<Widget> _screens = [
// //     const HomePage(),
// //     const EventScreen(),
// //     const ConnectScreen(),
// //     const JobSearchScreen(),
// //   ];

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: const Text('The Networking Game'),
// //       ),
// //       body: PageView(
// //         children: _screens,
// //         onPageChanged: (index) {
// //           setState(() {
// //             _currentIndex = index;
// //           });
// //         },
// //       ),
// //       bottomNavigationBar: BottomNavigationBar(
// //         currentIndex: _currentIndex,
// //         onTap: (index) {
// //           setState(() {
// //             _currentIndex = index;
// //           });
// //         },
// //         items: const [
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.home),
// //             label: 'Home',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.event),
// //             label: 'Events',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.people),
// //             label: 'Connect',
// //           ),
// //           BottomNavigationBarItem(
// //             icon: Icon(Icons.work),
// //             label: 'Job Search',
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }

// // class HomeScreen extends StatelessWidget {
// //   const HomeScreen({super.key});

// //   @override
// //   Widget build(BuildContext context) {
// //     return const Center(
// //       child: Text('Home Screen'),
// //     );
// //   }
// // }