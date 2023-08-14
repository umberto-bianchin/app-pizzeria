import 'package:flutter/material.dart';

class UserScreen extends StatelessWidget {
  const UserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    return ListView(physics: const ClampingScrollPhysics(), children: [
      const SizedBox(height: 30),

      // logo
      const Icon(
        Icons.lock,
        size: 80,
      ),

      const SizedBox(height: 30),

      // welcome back, you've been missed!
      Text(
        'Bentornato, ci sei mancato!',
        style: TextStyle(
          color: Colors.grey[700],
          fontSize: 16,
        ),
        textAlign: TextAlign.center,
      ),

      const SizedBox(height: 25),

      // username textfield
      textField(
        usernameController,
        'Username',
        false,
      ),

      const SizedBox(height: 10),

      // password textfield
      textField(
        passwordController,
        'Password',
        true,
      ),

      const SizedBox(height: 10),

      // forgot password?
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            TextButton(
              style: const ButtonStyle(
                  foregroundColor:
                      MaterialStatePropertyAll<Color>(Colors.grey)),
              onPressed: () {
                //TODO
              },
              child: const Text('Password dimenticata?'),
            ),
          ],
        ),
      ),

      const SizedBox(height: 15),

      // sign in button
      GestureDetector(
        onTap: () {
          //TODO
        },
        child: Container(
          padding: const EdgeInsets.all(25),
          margin: const EdgeInsets.symmetric(horizontal: 25),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Center(
            heightFactor: 0.5,
            child: TextButton(
              child: const Text(
                "Sign In",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              onPressed: () {
                //TODO
              },
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

      // or continue with
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Row(
          children: [
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                'Oppure continua con',
                style: TextStyle(color: Colors.grey[700]),
              ),
            ),
            Expanded(
              child: Divider(
                thickness: 0.5,
                color: Colors.grey[400],
              ),
            ),
          ],
        ),
      ),

      const SizedBox(height: 20),

      // google + apple sign in buttons
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // google button
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/google.png',
              width: 60,
              height: 60,
            ),
          ),

          const SizedBox(width: 25),

          // apple button
          IconButton(
            onPressed: () {},
            icon: Image.asset(
              'assets/images/apple.png',
              width: 60,
              height: 60,
            ),
          ),
        ],
      ),

      const SizedBox(height: 20),

      // not a member? register now
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(
          'Non sei ancora registrato?',
          style: TextStyle(color: Colors.grey[700]),
        ),
        TextButton(
          onPressed: () {},
          child: const Text(
            'Registrati ora',
            style: TextStyle(
              color: Colors.blue,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ]),
    ]);
  }
}

Widget squareTile(final String imagePath) {
  return Container(
    padding: const EdgeInsets.all(20),
    decoration: BoxDecoration(
      border: Border.all(color: Colors.white),
      borderRadius: BorderRadius.circular(16),
      color: Colors.grey[200],
    ),
    child: Image.asset(
      imagePath,
      height: 40,
    ),
  );
}

Widget textField(controller, final String hintText, final bool obscureText) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 25.0),
    child: TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
          fillColor: Colors.grey.shade200,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])),
    ),
  );
}
