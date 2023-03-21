import 'package:flutter/material.dart';

import 'package:shell/shell.dart';

import '../RegistryAccess.dart';
class RequirementThreeWidget extends StatefulWidget {

  const RequirementThreeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementThreeWidget> createState() => RequirementThreeWidgetState();
}

class RequirementThreeWidgetState extends State<RequirementThreeWidget>{
  var output;
  var temp;
  var display="";
  bool isShown = false;
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Check Password Reset',
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
              child: const Text('Get Password Reset Configuration'),
              onPressed: () async {
                display = '';
                var shell = Shell();

                //print(SysInfo.userName.toString());
                output = await shell.startAndReadAsString('Get-Service', arguments: ['-Name', "eventlog"]);

                // print(output);
                setState(() {

                });


              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Visibility(
              //if (bootStart == 0)
              visible: isShown,
              child: Text(
                //'$output',
                display.length!=0 ? "$display" : "All password policies are now ensured!",
                style: TextStyle(
                  color:display.length!=0 ? Colors.red : Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
