import 'package:chat_me/pages/login.dart';
import 'package:chat_me/pages/register_page.dart';
import 'package:flutter/material.dart';

class Login_or_Register extends StatefulWidget {
  const Login_or_Register({super.key});

  @override
  State<Login_or_Register> createState() => _Login_or_RegisterState();
}

class _Login_or_RegisterState extends State<Login_or_Register> {
  bool showLoginPage = true;

  void togglePages() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return Login(
        onTap: togglePages,
      );
    } else {
      return Register_page(
        onTap: togglePages,
      );
    }
  }
}
