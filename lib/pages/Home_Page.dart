import 'package:chat_me/auth/auth_service.dart';
import 'package:chat_me/compnonts/my_drawer.dart';
import 'package:chat_me/compnonts/user_tile.dart';
import 'package:chat_me/pages/chat_page.dart';
import 'package:chat_me/services/auth/chat_service.dart';
import 'package:flutter/material.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //chat & auth service
  final Chatservice _chatService = Chatservice();
  final AuthService _authService = AuthService();
  //logout function
  void logout() {
    final auth = AuthService();
    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Colors.grey,
        title: const Text("Home"),
        centerTitle: true,
      ),
      drawer: My_drawer(),
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        //loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }
        //return list view
        return ListView(
          children: snapshot.data!
              .map<Widget>((userdata) => _buildUserListItem(userdata, context))
              .toList(),
        );
      },
      stream: _chatService.getUsersStream(),
    );
  }

  // build individual list tile for user
  Widget _buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    // display all user except current user
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => ChatPage(
                        receiverEmail: userData["email"],
                        receiverID: userData["uid"],
                      )));
        },
      );
    } else {
      return Container();
    }
  }
}
