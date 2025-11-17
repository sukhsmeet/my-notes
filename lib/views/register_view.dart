import 'dart:developer' as devtools show log;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/firebase_options.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  initState() {
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
        title: const Text('Register'),
        
      ),
      body:Column(
                children: [
                  TextField(
                    controller: _email,
                    decoration: InputDecoration(hintText: "enter your email"),
                  ),
                  TextField(
                    controller: _password,
                    decoration: InputDecoration(
                      hintText: "enter your Password",
                    ),
                  ),
                  TextButton(
                    onPressed: () async {
                      try {
                        final email = _email.text;
                        final password = _password.text;
                        final userCredentials = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                        print(userCredentials);
                      } on FirebaseAuthException catch (e) {
                        // print(e.code);
                        if (e.code == 'email-already-in-use') {
                          devtools.log('Email already in use');
                        } else if (e.code == 'invalid-email') {
                          devtools.log("Invalid email entered");
                        } else if (e.code == 'weak-password') {
                          devtools.log('Weak password');
                        }
                      }
                    },
                    child: const Text('Register'),

                  ),
                  TextButton(onPressed: (){
                    Navigator.of(context).pushNamedAndRemoveUntil(loginRoute,(route) => false); 
                  }, child: const Text('Already registered? Login here!'),)
                ],
              ), 
    );
  }
}
