import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  // Moved here

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        ),
      body: Column(
        children: [
          TextField(
            controller: _email,
            decoration: InputDecoration(hintText: "enter your email"),
          ),
          TextField(
            controller: _password,
            decoration: InputDecoration(hintText: "enter your Password"),
          ),
          TextButton(
            onPressed: () async {
              try {
                final email = _email.text;
                final password = _password.text;
                final userCredentials = await FirebaseAuth.instance
                    .signInWithEmailAndPassword(email: email, password: password);
                print(userCredentials);
              } on FirebaseAuthException catch (e) {
                // print(e.code);
                if (e.code == 'email-already-in-use') {
                  print('Email already in use');
                } else if (e.code == 'invalid-email') {
                  print("Invalid email entered");
                } else if (e.code == 'weak-password') {
                  print('Weak password');
                }
              }
            },
            child: const Text('Login'),
          ),
          TextButton(onPressed: () {
            Navigator.of(context).pushNamedAndRemoveUntil('/register/',(route) => false);
          },
          child:Text ('Not registered yet? Register here!'),)
        ],
      ),
    );
  }
}
