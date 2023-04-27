import 'package:flutter/material.dart';
import '../app_styles/nav_bar_v2.dart';
import '../firebase/guest_state_firebase.dart';
// import '../app_styles/nav_bar_v2_ooooooold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfilePageState createState() => ProfilePageState();
}

class ProfilePageState extends State<ProfilePage> {

  // final MyNavigationBarState _navigationBarKey =
  //     MyNavigationBarState(); //MyNavigationBarState
  // final int profileIndex = 3;

  // @override
  // void initState() {
  //   super.initState();
  //   _navigationBarKey.setSelectedIndex(profileIndex);
  //   // ignore: avoid_print
  //   print('profile_page: _navigationBarKey.setSelectedIndex($profileIndex);');
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile Screen'),
      ),
      body: ListView(
        children: <Widget>[
          Image.asset('assets/login.png'),
          const SizedBox(height: 8),
          const Divider(
            height: 8,
            thickness: 1,
            indent: 8,
            endIndent: 8,
            color: Colors.pink,
          ),
        ],
      ),
      bottomNavigationBar: const MyNavigationBar(),
      extendBody: true,
    );
  }
}
