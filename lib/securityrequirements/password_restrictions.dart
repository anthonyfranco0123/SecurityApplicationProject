import 'package:flutter/material.dart';
import 'package:flutter_security_application/RegistryAccess.dart';
// import 'package:shell/shell.dart';

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

                int minLength = await RegistryAccess.getMinPwLen();
                int maxLength = await RegistryAccess.getMaxPwLen();
                int upperCase = await RegistryAccess.getUpperCaseSetting();
                int lowerCase = await RegistryAccess.getLowerCaseSetting();
                int special = await RegistryAccess.getSpecialCharSetting();
                setState(() {
                  isShown = true;
                  //print(output);

                  if (minLength!=8){
                    display +="Password's min length is not ensured. Changed min length to at least 8 characters.\n";
                    RegistryAccess.setMinPwLen();
                  }
                  if (maxLength!=32){
                    display +="Password's max length is not ensured. Changed max length to at most 32 characters.\n";
                    RegistryAccess.setMaxPwLen();
                  }

                  if(upperCase != 1){
                      if (upperCase == 0){
                        RegistryAccess.setUpperCaseSetting();
                        display+="Password does not require Uppercase letters. Changed to required!\n";
                      }
                      else if (upperCase > 1){
                        RegistryAccess.setUpperCaseSetting();
                        display+="Uppercase setting corrupted. Changed to required!\n";
                      }
                      else{
                        display+="Uppercase setting not configured. Changed to required!\n";
                      }
                  }

                  if(lowerCase != 1){
                    if (lowerCase == 0){
                      RegistryAccess.setLowerCaseSetting();
                      display+="Password does not require lowercase letters. Changed to required!\n";
                    }
                    else if (lowerCase > 1){
                      RegistryAccess.setLowerCaseSetting();
                      display+="Lowercase setting corrupted. Changed to required!\n";
                    }
                    else{
                      display+="Lowercase setting not configured. Changed to required!\n";
                    }
                  }
                  if(special != 1){
                    if (special == 0){
                      RegistryAccess.setSpecialCharSetting();
                      display+="Password does not require special characters. Changed to required!\n";
                    }
                    else if (upperCase > 1){
                      RegistryAccess.setSpecialCharSetting();
                      display+="Special characters setting corrupted. Changed to required!\n";
                    }
                    else{
                      display+="Special characters setting not configured. Changed to required!\n";
                    }
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
