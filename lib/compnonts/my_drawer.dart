import 'package:chat_me/auth/auth_service.dart';
import 'package:chat_me/pages/Settings_page.dart';
import 'package:flutter/material.dart';

class My_drawer extends StatelessWidget {
  const My_drawer({super.key});

  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.background,
        child: Column(
          children: [
            //logo
            DrawerHeader(
                child: Center(
                    child: Icon(
              Icons.message,
              color: Theme.of(context).colorScheme.primary,
              size: 40,
            ))),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    //home list title
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: ListTile(
                        title: const Text("H O M E"),
                        leading: const Icon(
                          Icons.home,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    //settings list tile
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: ListTile(
                        title: const Text("S E T T I N G S"),
                        leading: const Icon(
                          Icons.settings,
                        ),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => Settingspage()));
                        },
                      ),
                    ),
                  ],
                ),
                //logout list tile
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 25.0),
                      child: ListTile(
                        title: const Text("L O G O U T"),
                        leading: const Icon(
                          Icons.logout,
                        ),
                        onTap: () {
                          logout();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ));
  }
}
