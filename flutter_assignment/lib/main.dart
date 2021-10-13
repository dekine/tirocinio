import 'package:flutter/material.dart';

import './text_control.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: const Text('App'),
          ),
          body: const TextControl(),
        ));
  }
}
