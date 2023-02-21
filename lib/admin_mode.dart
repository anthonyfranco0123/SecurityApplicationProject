import 'package:flutter/material.dart';

class AdminMode extends StatefulWidget {
  const AdminMode({super.key});

  @override
  State<AdminMode> createState() => _AdminModeState();
}

class _AdminModeState extends State<AdminMode> {
  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    return Container(
      width: sw * 0.1,
      height: sh * 0.1,
      child: const Text(
        'Your Firewall State:',
        style: TextStyle(
          fontSize: 35,
          color: Colors.white,
        ),
        textAlign: TextAlign.center,
      ),);
  }
}