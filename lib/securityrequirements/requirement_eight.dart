import 'package:flutter/material.dart';
import 'package:shell/shell.dart';
class RequirementEightWidget extends StatefulWidget {

  const RequirementEightWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementEightWidget> createState() => RequirementEightWidgetState();
}

class RequirementEightWidgetState extends State<RequirementEightWidget>{
  //var output;
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
              'Check System Privilege Policy',
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
              child: const Text('Get System Privilege Policy'),
              onPressed: () async {
                display = '';
                var shell = Shell();

                //print(SysInfo.userName.toString());
                var output = await shell.startAndReadAsString('Get-LocalUser', arguments: ['']);
                setState(() {
                  isShown = true;
                  display = output;

                });


              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Visibility(
              visible: isShown,
              child: Text(
                //'$output',
                display.length!=0 ? "$display" : "System Privilege Policy is Set!",
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