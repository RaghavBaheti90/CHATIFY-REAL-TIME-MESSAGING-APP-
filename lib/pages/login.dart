import 'package:chat_me/auth/auth_service.dart';
import 'package:chat_me/compnonts/button.dart';
import 'package:chat_me/compnonts/my_textfild.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

class Login extends StatefulWidget {
  void Function()? onTap;
  Login({super.key, required this.onTap});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.sighInWithEmailPassword(
          _emailController.text, _passController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            //logo
            Icon(
              Icons.message,
              size: 60,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(
              height: 50,
            ),
            //welcome
            Text(
              "Welcome back , you've been missed!",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.primary, fontSize: 16),
            ),
            const SizedBox(
              height: 25,
            ),
            //email textfild
            MYTextFidls(
              hintText: "Email",
              obscure: false,
              controller: _emailController,
            ),
            const SizedBox(
              height: 10,
            ),
            //password textfild
            MYTextFidls(
              hintText: "Password",
              obscure: true,
              controller: _passController,
            ),
            const SizedBox(
              height: 25,
            ),
            //login button
            CustomButton(text: "LogIn", onTap: () => login(context)),
            const SizedBox(
              height: 25,
            ),
            //registen now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a Member? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text(
                    "Register Now",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
