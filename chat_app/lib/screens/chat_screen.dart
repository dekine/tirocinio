import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../widgets/chat/messages.dart';
import '../widgets/chat/new_message.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  void initState() {
    super.initState();
    final fbm = FirebaseMessaging.instance;
    fbm.requestPermission();
    FirebaseMessaging.onMessage.listen((message) {
      print(message);
      return;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print(message);
      return;
    });
    fbm.subscribeToTopic('chat');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChatApp'),
        actions: [
          DropdownButton(
            elevation: 16,
            underline: Container(),
            icon: Icon(
              Icons.more_vert,
              color: Theme.of(context).colorScheme.onSecondary,
            ),
            items: [
              DropdownMenuItem(
                value: 'logout',
                child: SizedBox(
                  child: Row(children: const [
                    Icon(Icons.exit_to_app, color: Colors.black87),
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
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Column(
        children: const <Widget>[
          Expanded(
            child: Messages(),
          ),
          NewMessage(),
        ],
      ),
    );
  }
}
