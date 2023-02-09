import 'package:flutter/material.dart';
import 'package:flutter_security_application/RegistryAccess.dart';
import 'dart:async';
import 'package:flutter_console/flutter_console.dart';
import 'package:flutter/foundation.dart';
import 'package:win32_registry/win32_registry.dart';
import 'dart:async';
import 'package:system_info2/system_info2.dart';
import 'package:process_run/shell.dart';

class RequirementTwoWidget extends StatefulWidget {


  const RequirementTwoWidget({

    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTwoWidget> createState() => RequirementTwoWidgetState();
}



class RequirementTwoWidgetState extends State<RequirementTwoWidget>{





  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var c = RegistryAccess.firewallState();

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
        child: const Text('Reg two', //Text(c),
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),

      ),

      floatingActionButton: FloatingActionButton(
        child: Text('Start'),
        backgroundColor: Colors.blue[600],
        onPressed: () =>
        {
          RegistryAccess.firewallState()


        },


      ),

    );

  }
}





