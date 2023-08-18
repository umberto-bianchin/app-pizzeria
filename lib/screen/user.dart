import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:app_pizzeria/widget/user_widget/top_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widget/user_widget/profile_menu.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const TopBanner(
          title: 'Account',
          icon: Icons.account_box_outlined,
        ),
        Expanded(
          child: ListView(
            physics: const ClampingScrollPhysics(),
            padding: const EdgeInsets.symmetric(vertical: 20),
            children: [
              const Align(
                alignment: Alignment.center,
                child: CircleAvatar(
                  backgroundImage: AssetImage(
                      "assets/images/user_default.png"), //TODO ternary expression with user photo if possible
                  maxRadius: 50,
                ),
              ),
              const SizedBox(height: 20),
              ProfileMenu(
                text: "Il mio Account",
                icon: "assets/images/user_icon.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Notifiche",
                icon: "assets/images/bell.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Impostazioni",
                icon: "assets/images/settings.svg",
                press: () {},
              ),
              ProfileMenu(
                text: "Log Out",
                icon: "assets/images/logout.svg",
                press: () async {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);

                  if (await provider.googleSignIn.isSignedIn()) {
                    provider.googleLogout();
                  } else {
                    FirebaseAuth.instance.signOut();
                  }
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
