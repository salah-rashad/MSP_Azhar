import 'package:flutter/material.dart';
import 'package:msp/models/session.dart';

class FullSessionScreen extends StatelessWidget {
  final Session session;

  const FullSessionScreen(this.session);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text(session.name),
      ),
    );
  }
}
