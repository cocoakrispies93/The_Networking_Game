//Original author: Shane D. May
//Inspiration: Flutter CodeLabs

// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
//import 'firebase_states/app_state.dart';

import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

//import 'app_styles/nav_bar_v2.dart';
import 'a_check_weather/geo_auth_router.dart';
import 'events_screen/home_events.dart';
import 'firebase/guest_state_firebase.dart';
import 'firebase_options.dart';
import 'screens/connect_github.dart';
import 'screens/connect_github2.dart';
//import 'a_linkedin_api/connect_page.dart';
import 'screens/events_page.dart';
import 'screens/home_page.dart';
import 'screens/profile_page.dart';
import 'screens/task_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ChangeNotifierProvider(
    create: (context) => ApplicationState(),
    builder: ((context, child) => const MainScreen()),
  ));
}

final _router = GoRouter(routes: [
  GoRoute(
    path: '/', //Home path must be '/'
    builder: (context, state) => const EventsHome(), //changed!!!!!!!!
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

//==================================
//  Previous Main App Widget Build
//==================================
class SignInApp2 extends StatelessWidget {
  const SignInApp2({super.key});

  //const _SignInState();

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
    );
  }
}

//==========================
//   Main App Widget Build
//==========================
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home', //start screen
      home: const HomePage(),
      //=======================
      // Navigation Bar Routing
      //=======================
      routes: {
        //'/': (context) => const HomePage(),
        //'/login': (context) => const SignInClass(),
        //previous main go router
        '/home': (context) => const HomePage(),
        //first page
        '/events': (context) => const EventsPage(),
        '/job': (context) => const ConnectGitHub2(),
        '/profile': (context) => const ProfilePage(),
        '/connect': (context) => const ConnectGitHub(),
        '/tasks': (context) => const TaskListPage(),
        '/weather-forecast': (context) => const GeoAuth(),
      },
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/home':
            return MaterialPageRoute(builder: (_) => const HomePage());
          case '/events':
            return MaterialPageRoute(builder: (_) => const SignInApp2());
          case '/job':
            return MaterialPageRoute(builder: (_) => const ConnectGitHub2());
          case '/profile':
            return MaterialPageRoute(builder: (_) => const ProfilePage());
          case '/connect':
            return MaterialPageRoute(builder: (_) => const ConnectGitHub());
          case '/tasks':
            return MaterialPageRoute(builder: (_) => const TaskListPage());
          case '/weather-forecast':
            return MaterialPageRoute(builder: (_) => const GeoAuth());
          // case '/login':
          //   return MaterialPageRoute(builder: (_) => const SignInClass());
          default:
            print('Error: Invalid route ${settings.name}');
            return null;
        }
      },
    );
  }
}


      //================
      // General Router
      //================
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/') {
      //     return MaterialPageRoute(builder: (context) => const HomePage());
      //   } else if (settings.name == '/home') {
      //     return MaterialPageRoute(builder: (context) => const HomePage());
      //   } else if (settings.name == '/events') {
      //     return MaterialPageRoute(
      //         builder: (context) => const EventsMainState());
      //   } else if (settings.name == '/job') {
      //     return MaterialPageRoute(
      //         builder: (context) => const ConnectGitHub2());
      //   } else if (settings.name == '/profile') {
      //     return MaterialPageRoute(builder: (context) => const ProfilePage());
      //   } else if (settings.name == '/connect') {
      //     return MaterialPageRoute(builder: (context) => const ConnectGitHub());
      //   } else if (settings.name == '/tasks') {
      //     return MaterialPageRoute(builder: (context) => const TaskListPage());
      //   } else if (settings.name == '/weather-forecast') {
      //     return MaterialPageRoute(builder: (context) => const GeoAuth());
      //   } else if (settings.name == '/login') {
      //     return MaterialPageRoute(builder: (context) => const SignInClass());
      //   }
      //   print('>>>>>>Main navigation problem!!!');
      //   return null;
      // },


// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(ChangeNotifierProvider(
//     create: (context) => ApplicationState(),
//     builder: ((context, child) => const MainScreen()),
//   ));
// }

// //==========================
// //   Main App Widget Build
// //==========================
// class MainScreen extends StatelessWidget {
//   const MainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       initialRoute: '/home', //starting screen
//       routes: {
//         '/': (context) => const HomePage(), //previous main go router
//         '/home': (context) => const HomePage(), //first page
//         //'/events': (context) => const EventsPage(),
//         '/events': (context) => const EventsMainState(),
//         '/job': (context) => const ConnectGitHub2(),
//         '/profile': (context) => const ProfilePage(),
//         '/connect': (context) => const ConnectGitHub(),
//         '/tasks': (context) => const TaskListPage(),
//       },
//       // onGenerateRoute: (settings) {
//       //   switch (settings.name) {
//       //     case '/':
//       //       return MaterialPageRoute(builder: (_) => const HomePage());
//       //     case '/home':
//       //       return MaterialPageRoute(builder: (_) => const HomePage());
//       //     case '/events':
//       //       return MaterialPageRoute(builder: (_) => const EventsMainState());
//       //     case '/job':
//       //       return MaterialPageRoute(builder: (_) => const ConnectGitHub2());
//       //     case '/profile':
//       //       return MaterialPageRoute(builder: (_) => const ProfilePage());
//       //     case '/connect':
//       //       return MaterialPageRoute(builder: (_) => const ConnectGitHub());
//       //     case '/tasks':
//       //       return MaterialPageRoute(builder: (_) => const TaskListPage());
//       //     default:
//       //       // If there is no such named route in the app, it returns null.
//       //       return null;
//       //   }
//       // },
//       onGenerateRoute: (settings) {
//         if (settings.name == '/') {
//           //if error, default
//           print('onGenerate for Router Settings set to DEFAULT');
//           return MaterialPageRoute(builder: (context) => const HomePage());
//         } else if (settings.name == '/home') {
//           print('setting.name == /home');
//           return MaterialPageRoute(builder: (context) => const HomePage());
//         } else if (settings.name == '/events') {
//           print('setting.name == /events');
//           return MaterialPageRoute(
//               builder: (context) => const EventsMainState());
//           // } else if (settings.name == '/login') {
//           //   return MaterialPageRoute(builder: (context) => const EventsMain());
//           // }
//         } else if (settings.name == '/job') {
//           print('setting.name == /job');
//           return MaterialPageRoute(
//               builder: (context) => const ConnectGitHub2());
//         } else if (settings.name == '/profile') {
//           print('setting.name == /profile');
//           return MaterialPageRoute(builder: (context) => const ProfilePage());
//         } else if (settings.name == '/connect') {
//           print('setting.name == /connect');
//           return MaterialPageRoute(builder: (context) => const ConnectGitHub());
//         } else if (settings.name == '/tasks') {
//           print('setting.name == /tasks');
//           return MaterialPageRoute(builder: (context) => const TaskListPage());
//         }
//         print('Main File Routing Error!!');
//         return null;
//       },
//     );
//   }
// }
