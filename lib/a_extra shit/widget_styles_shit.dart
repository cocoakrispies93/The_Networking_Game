// class MyElevatedButtonTheme {
//   static ButtonStyle _buttonStyle(BuildContext context) {
//     return ElevatedButton.styleFrom(
//       foregroundColor: Colors.deepPurple,
//       backgroundColor: const Color.fromARGB(255, 152, 137, 180),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//       ),
//     );
//   }

//   static ButtonThemeData buttonThemeData(BuildContext context) {
//     return Theme.of(context).buttonTheme.copyWith(
//           highlightColor: Colors.deepPurple,
//           colorScheme: const ColorScheme.light(
//             primary: Color.fromARGB(255, 152, 137, 180),
//             onPrimary: Colors.deepPurple,
//           ),
//           buttonColor: Colors.deepPurple.withOpacity(0.25),
//           disabledColor: Colors.grey,
//           padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(8),
//           ),
//         );
//   }
// }







// class MyElevatedButtonTheme extends ElevatedButtonThemeData {
//   static final ButtonStyle _buttonStyle = ElevatedButton.styleFrom(
//     foregroundColor: Colors.white,
//     backgroundColor: Colors.deepPurple.withOpacity(0.2),
//     shape: const RoundedRectangleBorder(
//       borderRadius: BorderRadius.all(Radius.circular(8)),
//     ),
//     side: const BorderSide(color: Colors.deepPurple),
//   );

//   MyElevatedButtonTheme() : super(style: _buttonStyle);

//   factory MyElevatedButtonTheme.fromButtonThemeData(ButtonThemeData data) {
//     return MyElevatedButtonTheme();
//   }
// }

// class MyElevatedButtonTheme extends ElevatedButtonThemeData {
//   static ButtonStyle _buttonStyle(BuildContext context) {
//     return ElevatedButton.styleFrom(
//       foregroundColor: Colors.white,
//       backgroundColor: Colors.deepPurple.withOpacity(0.2),
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(Radius.circular(8)),
//       ),
//       side: const BorderSide(color: Colors.deepPurple),
//     );
//   }

//   const MyElevatedButtonTheme() : super(style: _buttonStyle);

//   factory MyElevatedButtonTheme.fromButtonThemeData(ButtonThemeData data) {
//     return MyElevatedButtonTheme();
//   }
// }