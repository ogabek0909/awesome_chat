import 'package:awesome_chat/widgets/chat/single_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});
  static const routeName = 'chat-screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('chat').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error.toString()),
            );
          } else {
            final chatDocs = snapshot.data!.docs;
            return ListView.builder(
              reverse: true,
              itemCount: chatDocs.length,
              itemBuilder: (context, index) => SingleMessage(
                message: chatDocs[index]['text'],
                isMe: index.isEven,
              ),
            );
          }
        },
      ),
    );
  }
}
