import 'package:flutter/material.dart';

import 'package:shell/shell.dart';

import 'password/RegistryAccess.dart';
class RequirementThreeWidget extends StatefulWidget {

  const RequirementThreeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementThreeWidget> createState() => RequirementThreeWidgetState();
}

class RequirementThreeWidgetState extends State<RequirementThreeWidget>{
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Check Event Log',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
              ),
              child: const Text('Check Event Log'),
              onPressed: () async {



                //print(SysInfo.userName.toString());
                output = await shell.startAndReadAsString('sc', arguments: ['query', "eventlog"]);

                 print(output);

                setState(() {
                });


              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
          if (output.contains("RUNNING"))
            const Text(
              'Event Log Is Running',
              style: TextStyle(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
          ),
          if (output.contains("STOPPED"))
            const Text(
            'Event Log Is Stopped',
            style: TextStyle(
            color: Colors.white,
            ),
            textAlign: TextAlign.center,
            ),

  ],
  ),
  ),
  );
}
}
