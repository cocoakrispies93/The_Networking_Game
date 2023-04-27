// Copyright 2022 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Modified by Shane D. May

import 'package:flutter/material.dart';

class Header extends StatelessWidget {
  const Header(this.heading, {super.key});
  final String heading;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          heading,
          style: const TextStyle(fontSize: 24),
        ),
      );
}

class Paragraph extends StatelessWidget {
  const Paragraph(this.content, {super.key});
  final String content;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Text(
          content,
          style: const TextStyle(fontSize: 18),
        ),
      );
}

class IconAndDetail extends StatelessWidget {
  const IconAndDetail(this.icon, this.detail, {super.key});
  final IconData icon;
  final String detail;
  static const Color inactiveIconColor = Colors.white;
  static const Color primaryColor = Colors.deepPurple;
  static const Color backgroundColor = Color.fromRGBO(102, 59, 173, 0.25);
  static const double activeIconOpacity = 1.0;
  static const double inactiveIconOpacity = 0.25;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            Icon(icon),
            const SizedBox(width: 8),
            Text(
              detail,
              style: const TextStyle(fontSize: 18),
            )
          ],
        ),
      );
}

class MyElevatedButtonStyle {
  static ButtonStyle style(BuildContext context) {
    return ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.deepPurple.withOpacity(0.2),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: Colors.deepPurple),
      ),
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
    );
  }
}

// class MyElevatedButtonStyle {
//   static ButtonStyle style(BuildContext context) {
//     return ElevatedButton.styleFrom(
//       foregroundColor: Colors.white,
//       backgroundColor: Colors.deepPurple.withOpacity(0.2),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadius.circular(8),
//         side: BorderSide(color: Colors.deepPurple),
//       ),
//       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
//     );
//   }
// }

class StyledButton extends StatelessWidget {
  const StyledButton({
    required this.child,
    required this.onPressed,
    super.key,
  });

  final Widget child;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Container(
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
        ),
      );
}
