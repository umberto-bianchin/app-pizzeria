import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Column(
      children: [
        Text("sign in with email: ${user.email!}"),
        OutlinedButton(
            onPressed: () => FirebaseAuth.instance.signOut(),
            child: const Text("Disconnettiti"))
      ],
    );
  }
}
