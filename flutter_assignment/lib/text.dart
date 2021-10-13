import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final String message;

  const MyText({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Text(
          message,
          style: Theme.of(context).textTheme.headline4,
        ));
  }
}
