import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
              message: chatDocs[index].data()['text'],
              username: chatDocs[index].data()['username'],
              image: chatDocs[index].data()['userImage'],
              isMe: chatDocs[index].data()['userId'] ==
                  FirebaseAuth.instance.currentUser!.uid,
              key: ValueKey(chatDocs[index].id),
            ),
          );
        });
  }
}
