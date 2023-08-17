import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/user_widget/profile_menu.dart';
import '../widget/user_widget/profile_pic.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Column(
        children: [
          const ProfilePic(),
          const SizedBox(height: 20),
          ProfileMenu(
            text: "My Account",
            icon: "assets/images/user_icon.svg",
            press: () => {},
          ),
          ProfileMenu(
            text: "Notifications",
            icon: "assets/images/bell.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Settings",
            icon: "assets/images/settings.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Help Center",
            icon: "assets/images/question_mark.svg",
            press: () {},
          ),
          ProfileMenu(
            text: "Log Out",
            icon: "assets/images/logout.svg",
            press: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              bool isGoogle = await provider.googleSignIn.isSignedIn();

              if (isGoogle) {
                provider.googleLogout();
              } else {
                FirebaseAuth.instance.signOut();
              }
            },
          ),
        ],
      ),
    );
  }
}
