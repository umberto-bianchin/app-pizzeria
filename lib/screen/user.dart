import 'package:app_pizzeria/providers/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Column(
      children: [
        Text("sign in with email: ${user.email!}"),
        OutlinedButton(
            onPressed: () async {
              final provider =
                  Provider.of<GoogleSignInProvider>(context, listen: false);
              bool isGoogle = await provider.googleSignIn.isSignedIn();

              if (isGoogle) {
                provider.googleLogout();
              } else {
                FirebaseAuth.instance.signOut();
              }
            },
            child: const Text("Disconnettiti"))
      ],
    );
  }
}
