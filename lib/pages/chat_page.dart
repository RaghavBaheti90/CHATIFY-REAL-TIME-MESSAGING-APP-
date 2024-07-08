import 'package:chat_me/auth/auth_service.dart';
import 'package:chat_me/compnonts/chat_bubble.dart';
import 'package:chat_me/compnonts/my_textfild.dart';
import 'package:chat_me/services/auth/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  final String receiverEmail;
  final String receiverID;
  ChatPage({super.key, required this.receiverEmail, required this.receiverID});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  // text controller
  final TextEditingController _messageController = TextEditingController();

  // chat and ath service
  final Chatservice _chatService = Chatservice();

  final AuthService _authService = AuthService();

  //for textfiels focus
  FocusNode myFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    // add listener to the focus node\

    myFocusNode.addListener(() {
      if (myFocusNode.hasFocus) {
        Future.delayed(
          const Duration(milliseconds: 500),
          () => scroollDown(),
        );
      }
    });
    // wait a bit for listview to be built , then scroll down
    Future.delayed(
      const Duration(milliseconds: 500),
      () => scroollDown(),
    );
  }

  @override
  void dispose() {
    myFocusNode.dispose();
    _messageController.dispose();
    super.dispose();
  }

  //scroll controller
  final ScrollController _scrollController = ScrollController();
  void scroollDown() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(seconds: 1),
      curve: Curves.fastOutSlowIn,
    );
  }

  // send message
  void sendMessage() async {
    // if ther is something inside the textfield
    if (_messageController.text.isNotEmpty) {
      //send message
      await _chatService.sendMessage(
          widget.receiverID, _messageController.text);

      // clear the textfield
      _messageController.clear();
    }

    scroollDown();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        elevation: 0,
        foregroundColor: Colors.grey,
        title: Text(widget.receiverEmail),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // display messages
          Expanded(child: _buildMessagesList()),
          // user input
          _buildUserInput(),
        ],
      ),
    );
  }

  Widget _buildMessagesList() {
    String senderID = _authService.getCurrentUser()!.uid;
    return StreamBuilder(
        stream: _chatService.getMessages(widget.receiverID, senderID),
        builder: (context, snapshot) {
          // error
          if (snapshot.hasError) {
            return Text("Error");
          }
          //loading
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Text("Loading..");
          }
          // return list view
          return ListView(
            controller: _scrollController,
            children: snapshot.data!.docs
                .map((doc) => __buildMessagesItem(doc))
                .toList(),
          );
        });
  }

  // build message item
  Widget __buildMessagesItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

    // is current user
    bool inCurrentUser = data["senderID"] == _authService.getCurrentUser()!.uid;

    //align message to the right if the sender is the current user , otherwise left

    var alignment =
        inCurrentUser ? Alignment.centerRight : Alignment.centerLeft;

    return Container(
      alignment: alignment,
      child: Column(
          crossAxisAlignment:
              inCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            ChatBubble(isCureentUser: inCurrentUser, message: data["message"])
          ]),
    );
  }

  //buils user input
  Widget _buildUserInput() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
        children: [
          //text field should take up most of the space
          Expanded(
              child: MYTextFidls(
                  hintText: "Type a message..",
                  focusNode: myFocusNode,
                  obscure: false,
                  controller: _messageController)),

          //send button
          Container(
              decoration: const BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle,
              ),
              margin: const EdgeInsets.only(right: 20),
              child: IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )))
        ],
      ),
    );
  }
}
