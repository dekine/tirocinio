import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  Widget _buildError() {
    return Center(
      child: Column(
        children: const <Widget>[
          CircularProgressIndicator(),
          Text('Something went wrong'),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ChatApp'),
        actions: [
          DropdownButton(
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: SizedBox(
                  child: Row(children: const [
                    Icon(Icons.exit_to_app),
                    SizedBox(width: 10, height: 10),
                    Text('Logout'),
                  ]),
                ),
              ),
            ],
            onChanged: (itemId) {
              if (itemId == 'logout') {
                FirebaseAuth.instance.signOut();
              }
            },
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('chats/jbbtEh9wrrJCwvi73zzR/messages')
            .snapshots(),
        builder: (ctx, streamSnapshot) {
          if (streamSnapshot.hasError) {
            return _buildError();
          }
          if (streamSnapshot.connectionState == ConnectionState.waiting ||
              streamSnapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final documents = streamSnapshot.data?.docs;

          if (documents == null) return _buildError();
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
