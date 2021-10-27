import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import './message_bubble.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('chat')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (ctx, AsyncSnapshot chatSnapshot) {
          if (chatSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (chatSnapshot.hasError) {
            return Center(
                child: Text(
                    'There was an error: ${chatSnapshot.error.toString()}'));
          }
          if (!chatSnapshot.hasData) {
            return const Center(
                child: Text(
              'No chats :(',
              style: TextStyle(color: Colors.black),
            ));
          }
          final chatDocs = chatSnapshot.data.docs as List<dynamic>;
          return ListView.builder(
            reverse: true,
            itemCount: chatDocs.length,
            itemBuilder: (ctx, index) => MessageBubble(
              message: chatDocs[index]['text'],
              username: chatDocs[index]['username'],
              isMe: chatDocs[index]['userId'] == null,
              // key: ValueKey(chatDocs[index].documentId),
            ),
          );
        });
  }
}
