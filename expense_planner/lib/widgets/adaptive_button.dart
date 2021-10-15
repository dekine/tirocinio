import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AdaptiveButton extends StatelessWidget {
  const AdaptiveButton({Key? key, required this.text, required this.handler})
      : super(key: key);

  final String text;
  final Function handler;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? TextButton(
            child: Text(text, style: const TextStyle(fontSize: 16)),
            style: TextButton.styleFrom(
              padding: const EdgeInsets.all(15.0),
              primary: Theme.of(context).colorScheme.primary,
              textStyle: const TextStyle(fontSize: 16),
            ),
            onPressed: () => handler(),
          )
        : CupertinoButton(
            child: Text(text, style: const TextStyle(fontSize: 16)),
            onPressed: () => handler(),
          );
  }
}
