import 'package:flutter/material.dart';

import 'package:shell/shell.dart';

import 'password/RegistryAccess.dart';

class RequirementSevenWidget extends StatefulWidget {

  const RequirementSevenWidget({rr
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementSevenWidget> createState() => RequirementSevenWidgetState();
}

class RequirementSevenWidgetState extends State<RequirementSevenWidget>{
  @override
  void initState() {
    super.initState();
  }
  var output="";
  var display;
  var shell = Shell();
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

        child: const Text('Req seven',
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