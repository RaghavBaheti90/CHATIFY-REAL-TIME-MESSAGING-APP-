import 'package:chat_me/auth/login_or_register.dart';
import 'package:chat_me/pages/Home_Page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Homepage();
            } else {
              return const Login_or_Register();
            }
          }),
    );
  }
}
