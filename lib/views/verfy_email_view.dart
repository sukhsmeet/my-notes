import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';

class VerifyEmail extends StatefulWidget {
  const VerifyEmail({super.key});

  @override
  State<VerifyEmail> createState() => _VerifyEmailState();
}

class _VerifyEmailState extends State<VerifyEmail> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Verify Email')),
      body: Column(
        children: [
          Text("An email verification has ben sent to your email"),
          Text('If you have not received a verification email yet, press the button below'),
          TextButton(
            onPressed: () {
              final user = FirebaseAuth.instance.currentUser;
              user?.sendEmailVerification();
            },
            child: Text('Send email verification'),
          ),
          TextButton(onPressed: (){
            FirebaseAuth.instance.signOut();
            Navigator.of( context).pushNamedAndRemoveUntil(
              loginRoute,
              (route) => false,
            );
          }, child: const Text('Restart')),
        ],
      ),
    );
  }
}
