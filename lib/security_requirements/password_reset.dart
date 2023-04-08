import 'dart:async';
import 'package:flutter/material.dart';
import '../admin/admin_state.dart';
import '../requirement_variables.dart';
import 'password/registry_access.dart';
import 'package:flutter_security_application/security_requirements/password/password_policies.dart';

class RequirementOneWidget extends StatefulWidget {
  const RequirementOneWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementOneWidget> createState() => RequirementOneWidgetState();
}

class RequirementOneWidgetState extends State<RequirementOneWidget> with AutomaticKeepAliveClientMixin {
  //String output = '';
  //var temp;
  //var display="";

  late Timer timer;
  @override
  bool get wantKeepAlive => true;
  int initialMaxAge = -1;
  int currentMaxAge = -1;
  int initialPwHist = -1;
  int currentPwHist = -1;
  //bool isShown = false;
  @override
  void initState() {
    //PasswordPolicies.getPwHist();
    //PasswordPolicies.getMaxPwAge();
    //initialMaxAge = PasswordPolicies.maxPwAge;
    //initialPwHist = PasswordPolicies.pwHist;
    initialMaxAge = currentMaxAge = RegistryAccess.getPwAge();
    initialPwHist = currentPwHist = RegistryAccess.getPwHist();
    //print(initialMaxAge);
    //print(initialPwHist);
    //initialPwHist = currentPwHist = PasswordPolicies.pwHist;
    super.initState();

  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _initialPasswordPolicyText(int age, int history){
    String passwordStatesText = '';
    //initialMaxAge = currentMaxAge = PasswordPolicies.maxPwAge;
    //initialPwHist = currentPwHist = PasswordPolicies.pwHist;
    if(initialMaxAge!=age && initialPwHist!=history){
      passwordStatesText = 'Initial Status: Both password max age and password history list not ensured!';
    }
    else if(initialMaxAge==age && initialPwHist!=history){
      passwordStatesText = 'Initial Status: Password history list not ensured!';
    }
    else if(initialMaxAge!=age && initialPwHist==history){
      passwordStatesText = 'Initial Status: Password max age not ensured!';
    }
    else if(initialMaxAge==age && initialPwHist==history){
      passwordStatesText = 'Initial Status: Both password max age and password history list are ensured!';
    }
    else {
      passwordStatesText = 'Error: Unable to determine the password reset policies';
    }

    return passwordStatesText;
  }

  String _currentPasswordPolicyText(int age, int history){
    String passwordStatesText = '';
    if(currentMaxAge != age && currentPwHist != history){
      passwordStatesText = 'Current Status: both password max age and password history list not ensured!';
    }
    else if(currentMaxAge == age && currentPwHist != history){
      passwordStatesText = 'Current Status: password history list not ensured!';
    }
    else if(currentMaxAge != age && currentPwHist == history){
      passwordStatesText = 'Current Status: password max age not ensured!';
    }
    else if(currentMaxAge == age && currentPwHist == history){
      passwordStatesText = 'Current Status: both password max age and password history list are ensured!';
    }
    else {
      passwordStatesText = 'Error: Unable to determine the password reset policies';
    }

    return passwordStatesText;
  }


  Text _textToDisplayForInitialPasswordPolicies(int age, int history) {
    String textToDisplayForInitialPasswordPolicies = '';
    Color c = Colors.yellow;

    if(initialMaxAge!=age || initialPwHist!=history){
      c = Colors.red;
      textToDisplayForInitialPasswordPolicies = _initialPasswordPolicyText(age, history);
    } else{
      c = Colors.white;
      currentPwHist = initialPwHist;
      currentMaxAge = initialMaxAge;
      textToDisplayForInitialPasswordPolicies = _initialPasswordPolicyText(age, history);
    }
    /*if (initialFirewallStates != 9) {
      c = Colors.red;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    } else {
      c = Colors.white;
      currentFirewallStates = initialFirewallStates;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    }*/
    //RequirementVariables.maxPasswordAge = PasswordPolicies.maxPwAge;
    //RequirementVariables.passwordHistory = PasswordPolicies.pwHist;

    return Text(
      textToDisplayForInitialPasswordPolicies,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _textToDisplayForCurrentPasswordPolicy(int age, int history) {

    Color c = Colors.yellow;
    _periodicallyUpdatePasswordPolicy(age, history);
    if(currentMaxAge!=age ) {
      c = Colors.red;
      RegistryAccess.setPwAge(age);
    }
    else if (currentPwHist!=history){
      c = Colors.red;
      RegistryAccess.setPwHist(history);
    } else{
      c = Colors.white;
      //currentPwHist = initialPwHist;
      //currentMaxAge = initialMaxAge;
      //textToDisplayForInitialPasswordPolicies = _initialPasswordPolicyText();
    }


    return Text(
      _currentPasswordPolicyText(age, history),
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Future<void> _periodicallyUpdatePasswordPolicy(int age, int history) async {
    //RequirementVariables.maxPasswordAge = currentMaxAge = RegistryAccess.getMaxPwLen() as int;
    //RequirementVariables.passwordHistory = currentPwHist = RegistryAccess.getPwHist() as int;
    RequirementVariables.maxPasswordAge = currentMaxAge;
    RequirementVariables.passwordHistory = currentPwHist;
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if(currentMaxAge!= age){
          RegistryAccess.setPwAge(age);
          RequirementVariables.maxPasswordAge = PasswordPolicies.maxPwAge = currentMaxAge = age;
        }
        if(PasswordPolicies.pwHist!=history){
          RegistryAccess.setPwHist(history);
          RequirementVariables.passwordHistory = PasswordPolicies.pwHist = currentPwHist = history;
        }
      });
    });
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
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Password Reset',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialPasswordPolicies(90, 10),
                _textToDisplayForCurrentPasswordPolicy(90, 10),
                const Padding(padding: EdgeInsets.all(8.0)),
                Visibility(
                  maintainSize: true,
                  maintainAnimation: true,
                  maintainState: true,
                  visible: AdminState.adminState,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // firewallStates = RegistryAccess.getFirewallStates();
                          });
                        },
                        child: const Text(''),
                      ),
                      const Padding(padding: EdgeInsets.all(8.0)),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            // firewallStates = RegistryAccess.getFirewallStates();
                          });
                        },
                        child: const Text(''),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
