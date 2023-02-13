import 'package:flutter/material.dart';
import 'package:flutter_security_application/RegistryAccess.dart';
import 'package:shell/shell.dart';

class RequirementTwoWidget extends StatefulWidget {


  const RequirementTwoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTwoWidget> createState() => RequirementTwoWidgetState();
}

class RequirementTwoWidgetState extends State<RequirementTwoWidget>{
  var output;
  var temp;
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
              'Check Password Policy',
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
              child: const Text('Get Password Policy'),
              onPressed: () async {
                var shell = Shell();

                //print(SysInfo.userName.toString());
                output = await shell.startAndReadAsString('net', arguments: ['accounts']);
                setState(() {
                  isShown = true;
                  //print(output);
                });
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            Visibility(
              //if (bootStart == 0)
              visible: isShown,
              child: Text(
                '$output',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.left,
              ),
            ),
          ],
        ),
      ),

    );
  }
}
