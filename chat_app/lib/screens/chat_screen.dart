import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chats/jbbtEh9wrrJCwvi73zzR/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.hasError) {
            return const Text('Something went wrong');
          }
          if (streamSnapshot.connectionState == ConnectionState.waiting ||
              streamSnapshot.data == null) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          // return ListView(
          //   children:
          //       streamSnapshot.data!.docs.map((DocumentSnapshot document) {
          //     Map<String, dynamic> data =
          //         document.data()! as Map<String, dynamic>;
          //     return ListTile(
          //       title: Text(data['full_name']),
          //       subtitle: Text(data['company']),
          //     );
          //   }).toList(),
          // );
          final documents = streamSnapshot.data?.docs;
          if (documents == null) return const Text('Something went wrong');

          return ListView.builder(
            itemCount: documents.length,
            itemBuilder: (ctx, index) => Container(
              padding: const EdgeInsets.all(8),
              child: Text(documents[index]['test'].toString()),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('chats/jbbtEh9wrrJCwvi73zzR/messages')
              .add({'test': 'Ehi!'});
        },
      ),
    );
  }
}
