import 'package:flutter/material.dart';
import 'package:shell/shell.dart';

import '../requirement_variables.dart';
import 'password/RegistryAccess.dart';

class RequirementOneWidget extends StatefulWidget {
  const RequirementOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementOneWidget> createState() => RequirementOneWidgetState();
}

class RequirementOneWidgetState extends State<RequirementOneWidget> {
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
                // var MAC = RegistryAccess.initPlatformState();

                display = '';
                var shell = Shell();

                output = await shell.startAndReadAsString('net', arguments: ['accounts']);
                //var forceLogOff =  output.substring(output.indexOf("Force user logoff how long after time expires?:") + 54, output.indexOf("Minimum password age (days):") - 2 );
                //var minpwage = output.substring(output.indexOf("Minimum password age (days):") + 54, output.indexOf("Maximum password age (days):")-2 );
                var maxpwage = RequirementVariables.maxPasswordAge = output.substring(output.indexOf("Maximum password age (days):") + 54, output.indexOf("Minimum password length:")-2 );
                //var minpwlen = output.substring(output.indexOf("Minimum password length:") + 54, output.indexOf("Length of password history maintained:")-2 );
                var pwhist = RequirementVariables.passwordHistory = output.substring(output.indexOf("Length of password history maintained:") + 54, output.indexOf("Lockout threshold:")-2 );
                //var lockoutThreshold = output.substring(output.indexOf("Lockout threshold:") + 54, output.indexOf("Lockout duration (minutes):")-2 );
                //var lockoutDur = output.substring(output.indexOf("Lockout duration (minutes):") + 54, output.indexOf("Lockout observation window (minutes):")-2 );
                //var lockoutObservation = output.substring(output.indexOf("Lockout observation window (minutes):") + 54, output.indexOf("Computer role:")-2 );
                // print(output);
                setState(() {
                  // print(MAC);
                  isShown = true;
                  //print(output);
                  if (int.parse(maxpwage)!=90){
                    display +="Password's max age is not ensured. Changed max age to 3 months.\n";
                    RegistryAccess.changeMaxPwAge();
                  }

                  if(pwhist!="None"){
                    if (int.parse(pwhist)!=10){
                      display +="Password's history is not ensured. Changed number of stored password to 10.\n";
                      RegistryAccess.changePwHist();
                    }
                  }
                  else{
                    display +="Password's history is not configured. Changed number of stored password to 10.\n";
                    RegistryAccess.changePwHist();
                  }
                  //print(display.length);
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
