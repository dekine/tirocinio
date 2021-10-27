import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Center(
        child: Column(
          children: <Widget>[
            const CircularProgressIndicator(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Loading...',
              style: const TextStyle().copyWith(fontSize: 32),
            )
          ],
        ),
      ),
    );
  }
}
