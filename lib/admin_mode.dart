import 'package:flutter/material.dart';

class AdminMode extends StatefulWidget {
  const AdminMode({super.key});

  @override
  State<AdminMode> createState() => _AdminModeState();
}

class _AdminModeState extends State<AdminMode> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Text(
        'Your Firewall State:',
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),);
  }
}