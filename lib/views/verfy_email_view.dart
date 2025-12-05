import 'package:flutter/material.dart';
import 'package:mynotes/constants/routes.dart';
import 'package:mynotes/services/auth/auth_service.dart';

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
             // final user = AuthService.firebase().currentUser;
              AuthService.firebase().sendEmailVerification();
            },
            child: Text('Send email verification'),
          ),
          TextButton(onPressed: () async {
           await AuthService.firebase().logOut();
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
