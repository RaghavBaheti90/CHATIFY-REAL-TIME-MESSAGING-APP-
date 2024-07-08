import 'package:chat_me/themes/theam_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Settingspage extends StatefulWidget {
  const Settingspage({super.key});

  @override
  State<Settingspage> createState() => _SettingspageState();
}

class _SettingspageState extends State<Settingspage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Colors.grey,
        title: const Text("Settings"),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.all(25),
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // dark mode
            const Text("Dark Mode"),
            //switch toggal
            CupertinoSwitch(
              value: Provider.of<TheameProvider>(context, listen: false)
                  .isDarkMode,
              onChanged: (value) =>
                  Provider.of<TheameProvider>(context, listen: false)
                      .toggleTheme(),
            )
          ],
        ),
      ),
    );
  }
}
