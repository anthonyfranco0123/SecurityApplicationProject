import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security_application/security_requirements/password/password_policies.dart';
import 'package:flutter_security_application/security_requirements/password/registry_access.dart';

import '../admin/admin_state.dart';
import '../requirement_variables.dart';
// import 'package:shell/shell.dart';

class RequirementTwoWidget extends StatefulWidget {


  const RequirementTwoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTwoWidget> createState() => RequirementTwoWidgetState();
}

class RequirementTwoWidgetState extends State<RequirementTwoWidget> with AutomaticKeepAliveClientMixin {
  late Timer timer;
  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  void initState() {
    super.initState();
  }

  String _initialPasswordPolicyText(int minLen, int maxLen){
    String passwordStatesText = '';
    if(PasswordPolicies.minLength==minLen && PasswordPolicies.maxLength==maxLen && PasswordPolicies.upperCase==1 && PasswordPolicies.lowerCase==1 && PasswordPolicies.special==1){
      passwordStatesText = 'Status: All Password Policies Are Ensured';
    }

    else {
      passwordStatesText = 'Status: All Password Policies Are Not Ensured';
    }

    return passwordStatesText;
  }

  Text _textToDisplayForInitialPasswordPolicies(int minLen, int maxLen) {
    String textToDisplayForInitialPasswordPolicies = '';
    Color c = Colors.yellow;
    _periodicallyUpdatePasswordPolicy(minLen, maxLen);
    if(PasswordPolicies.minLength!=minLen || PasswordPolicies.maxLength!=maxLen || PasswordPolicies.upperCase!=1 || PasswordPolicies.lowerCase!=1 || PasswordPolicies.special !=1){
      c = Colors.red;
      textToDisplayForInitialPasswordPolicies = _initialPasswordPolicyText(minLen, maxLen);
    } else{
      c = Colors.white;
      //currentPwHist = initialPwHist;
      //currentMaxAge = initialMaxAge;
      textToDisplayForInitialPasswordPolicies = _initialPasswordPolicyText(minLen, maxLen);
    }
    /*if (initialFirewallStates != 9) {
      c = Colors.red;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    } else {
      c = Colors.white;
      currentFirewallStates = initialFirewallStates;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    }*/
    RequirementVariables.minPasswordLength = PasswordPolicies.minLength;
    RequirementVariables.maxPasswordLength = PasswordPolicies.maxLength;
    RequirementVariables.uppercaseChars = PasswordPolicies.upperCase == 1 ? true : false;
    RequirementVariables.lowercaseChars = PasswordPolicies.lowerCase == 1 ? true : false;
    RequirementVariables.specialChars = PasswordPolicies.special==1 ? true:false;
    return Text(
      textToDisplayForInitialPasswordPolicies,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }


  Future<void> _periodicallyUpdatePasswordPolicy(int minLen, int maxLen) async {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if(PasswordPolicies.minLength!= minLen){
          RegistryAccess.setMinPwLen(minLen);
          PasswordPolicies.minLength = minLen;
        }
        if(PasswordPolicies.maxLength!=maxLen){
          RegistryAccess.setMaxPwLen(maxLen);
          PasswordPolicies.maxLength = maxLen;
        }
        if(PasswordPolicies.upperCase!=1){
          RegistryAccess.setUpperCaseSetting();
          PasswordPolicies.upperCase = 1;
        }
        if(PasswordPolicies.lowerCase!=1){
          RegistryAccess.setLowerCaseSetting();
          PasswordPolicies.lowerCase = 1;
        }
        if(PasswordPolicies.special!=1){
          RegistryAccess.setSpecialCharSetting();
          PasswordPolicies.special = 1;
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
                  'Check Your Boot-Start Driver Initialization',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialPasswordPolicies(8, 32),
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

                          });
                        },
                        child: const Text('Turn On Initialization Policies'),
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

                          });
                        },
                        child: const Text('Turn Off Initialization Policies'),
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
