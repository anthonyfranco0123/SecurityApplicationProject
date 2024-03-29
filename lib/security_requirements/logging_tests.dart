import 'package:flutter/material.dart';

class RequirementFourWidget extends StatefulWidget {

  const RequirementFourWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementFourWidget> createState() => RequirementFourWidgetState();
}

class RequirementFourWidgetState extends State<RequirementFourWidget>{
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.9],
            colors: [
              Color(0xFF0f0530),
              Color(0xFF5e48ab),
              Color(0xFF0f0530),
            ],
          ),
        ),
        child: const Text('Req four',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}