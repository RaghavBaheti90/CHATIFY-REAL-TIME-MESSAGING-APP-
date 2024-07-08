import 'package:chat_me/auth/auth_service.dart';
import 'package:chat_me/compnonts/button.dart';
import 'package:chat_me/compnonts/my_textfild.dart';
import 'package:flutter/material.dart';

class Register_page extends StatefulWidget {
  final Function()? onTap;
  const Register_page({super.key, required this.onTap});

  @override
  State<Register_page> createState() => _Register_pageState();
}

class _Register_pageState extends State<Register_page> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  TextEditingController _canformpassController = TextEditingController();

  void register(BuildContext context) {
    final _auth = AuthService();

    if (_passController.text == _canformpassController.text) {
      try {
        _auth.sighUpWithEmailPassword(
            _emailController.text, _passController.text);
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text(e.toString()),
                ));
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => const AlertDialog(
                title: Text("Password Dont't Match!!"),
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
              "Let's Create An Account For You",
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
              height: 10,
            ),
            // canform password
            MYTextFidls(
              hintText: "Confirm Password",
              obscure: true,
              controller: _canformpassController,
            ),
            const SizedBox(
              height: 25,
            ),
            //register button
            CustomButton(
              text: "Register",
              onTap: () => register(context),
            ),
            const SizedBox(
              height: 25,
            ),
            //registen now
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already Have An Account? ",
                  style:
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                ),
                GestureDetector(
                  onTap: widget.onTap,
                  child: const Text(
                    "LogIn Now",
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
