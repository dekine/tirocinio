import 'package:flutter/material.dart';

import './text.dart';

class TextControl extends StatefulWidget {
  const TextControl({Key? key}) : super(key: key);

  @override
  State<TextControl> createState() => _TextControlState();
}

class _TextControlState extends State<TextControl> {
  String _message = 'Initial message';

  void _textHandler() {
    setState(() {
      _message = 'Second message';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          MyText(message: _message),
          ElevatedButton(onPressed: _textHandler, child: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
