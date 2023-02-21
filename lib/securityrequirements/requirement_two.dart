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
                display = '';
                var shell = Shell();

                //print(SysInfo.userName.toString());
                output = await shell.startAndReadAsString('net', arguments: ['accounts']);
                var forceLogOff =  output.substring(output.indexOf("Force user logoff how long after time expires?:") + 54, output.indexOf("Minimum password age (days):") - 2 );
                var minpwage = output.substring(output.indexOf("Minimum password age (days):") + 54, output.indexOf("Maximum password age (days):")-2 );
                var maxpwage = output.substring(output.indexOf("Maximum password age (days):") + 54, output.indexOf("Minimum password length:")-2 );
                var minpwlen = output.substring(output.indexOf("Minimum password length:") + 54, output.indexOf("Length of password history maintained:")-2 );
                var pwhist = output.substring(output.indexOf("Length of password history maintained:") + 54, output.indexOf("Lockout threshold:")-2 );
                var lockoutThreshold = output.substring(output.indexOf("Lockout threshold:") + 54, output.indexOf("Lockout duration (minutes):")-2 );
                var lockoutDur = output.substring(output.indexOf("Lockout duration (minutes):") + 54, output.indexOf("Lockout observation window (minutes):")-2 );
                var lockoutObservation = output.substring(output.indexOf("Lockout observation window (minutes):") + 54, output.indexOf("Computer role:")-2 );
               // print(output);
                setState(() {
                  isShown = true;
                  //print(output);
                  if (int.parse(maxpwage)!=90){
                    display +="Password's max age is not ensured. Changed max age to 3 months.\n";
                    RegistryAccess.changeMaxPwAge();
                  }

                  if (int.parse(minpwlen)!=8){
                    display +="Password's min length is not ensured. Changed min length to at least 8 characters.\n";
                    RegistryAccess.changeMinPwLen();
                  }

                  if(pwhist!="None"){
                    if (int.parse(pwhist)!=10){
                      display +="Password's history is not ensured. Changed number of stored password to 10.\n";
                      RegistryAccess.changePwHist();
                    }
                  }
                  else{
                    display +="Password's history is not ensured. Changed number of stored password to 10.\n";
                    RegistryAccess.changePwHist();
                  }
                  print(display.length);
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