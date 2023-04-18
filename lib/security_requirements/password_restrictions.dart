import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_security_application/security_requirements/password/registry_access.dart';

import '../admin/admin_state.dart';
import '../requirement_variables.dart';

class RequirementTwoWidget extends StatefulWidget {


  const RequirementTwoWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTwoWidget> createState() => RequirementTwoWidgetState();
}

class RequirementTwoWidgetState extends State<RequirementTwoWidget> with AutomaticKeepAliveClientMixin {
  late Timer timer;
  int initialMinPwLen = -1;
  int currentMinPwLen = -1;

  int initialMaxPwLen = -1;
  int currentMaxPwLen = -1;

  int initialUpper = -1;
  int currentUpper = -1;

  int initialLower = -1;
  int currentLower = -1;

  int initialSpecial = -1;
  int currentSpecial = -1;

  @override
  bool get wantKeepAlive => true;


  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }


  @override
  void initState() {
    initialMinPwLen = currentMinPwLen = RegistryAccess.getMinPwLen();
    initialMaxPwLen = currentMaxPwLen = RegistryAccess.getMaxPwLen();
    initialUpper = currentUpper = RegistryAccess.getUpperCaseSetting();
    initialLower = currentLower = RegistryAccess.getLowerCaseSetting();
    initialSpecial = currentSpecial = RegistryAccess.getSpecialCharSetting();
    super.initState();
  }

  String _initialPasswordPolicyText(int minLen, int maxLen){
    String passwordStatesText = '';
    if(initialMinPwLen==minLen && initialMaxPwLen==maxLen && initialUpper==1 && initialLower==1 && initialSpecial==1){
      passwordStatesText = 'Initial Status: All Password Policies Are Ensured';
    }

    else {
      passwordStatesText = 'Initial Status: All Password Policies Are Not Ensured';
    }

    return passwordStatesText;
  }

  String _currentPasswordPolicyText(int minLen, int maxLen){
    String passwordStatesText = '';
    if(currentMinPwLen==minLen && currentMaxPwLen==maxLen && currentUpper==1 && currentLower==1 && currentSpecial==1){
      if(currentMinPwLen != initialMinPwLen || currentMaxPwLen != initialMaxPwLen || currentUpper!= initialUpper || currentLower != initialLower || currentSpecial != initialSpecial ){
        passwordStatesText = 'Current Status: All Password Policies Are Ensured. \nPLEASE RESTART YOUR COMPUTER FOR THE CHANGES TO TAKE EFFECT!!';
      }
      else {
        passwordStatesText =
        'Current Status: All Password Policies Are Ensured';
      }
    }

    else {
      passwordStatesText = 'Current Status: All Password Policies Are Not Ensured';
    }

    return passwordStatesText;
  }

  Text _textToDisplayForInitialPasswordPolicies(int minLen, int maxLen) {
    String textToDisplayForInitialPasswordPolicies = '';
    Color c = Colors.yellow;
    _periodicallyUpdatePasswordPolicy(minLen, maxLen);
    if(initialMinPwLen!=minLen || initialMaxPwLen!=maxLen || initialUpper!=1 || initialLower!=1 || initialSpecial!=1){
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

    return Text(
      textToDisplayForInitialPasswordPolicies,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _textToDisplayForCurrentPasswordPolicies(int minLen, int maxLen) {
    String textToDisplayForInitialPasswordPolicies = '';
    Color c = Colors.yellow;
    _periodicallyUpdatePasswordPolicy(minLen, maxLen);
    if(currentMinPwLen!=minLen || currentMaxPwLen!=maxLen || currentUpper!=1 || currentLower!=1 || currentSpecial!=1){
      c = Colors.red;
      textToDisplayForInitialPasswordPolicies = _currentPasswordPolicyText(minLen, maxLen);
    } else{
      c = Colors.white;
      //currentPwHist = initialPwHist;
      //currentMaxAge = initialMaxAge;
      textToDisplayForInitialPasswordPolicies = _currentPasswordPolicyText(minLen, maxLen);
    }
    /*if (initialFirewallStates != 9) {
      c = Colors.red;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    } else {
      c = Colors.white;
      currentFirewallStates = initialFirewallStates;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    }*/

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
    RequirementVariables.minPasswordLength = currentMinPwLen;
    RequirementVariables.maxPasswordLength = currentMaxPwLen;
    RequirementVariables.uppercaseChars = currentUpper == 1 ? true : false;
    RequirementVariables.lowercaseChars = currentLower == 1 ? true : false;
    RequirementVariables.specialChars = currentSpecial ==1 ? true : false;
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if(currentMinPwLen!= minLen){
          RegistryAccess.setMinPwLen(minLen);
          currentMinPwLen = minLen;
          //RequirementVariables.minPasswordLength = minLen;
        }
        if(currentMaxPwLen!=maxLen){
          RegistryAccess.setMaxPwLen(maxLen);
          currentMaxPwLen = maxLen;

          //RequirementVariables.maxPasswordLength = maxLen;
        }
        if(currentUpper!=1){
          RegistryAccess.setUpperCaseSetting();
          currentUpper = 1;
          //RequirementVariables.uppercaseChars = true;
        }
        if(currentLower!=1){
          RegistryAccess.setLowerCaseSetting();
          currentLower = 1;
          //PasswordPolicies.lowerCase = 1;
        }
        if(currentSpecial!=1){
          RegistryAccess.setSpecialCharSetting();
          currentSpecial = 1;
          //PasswordPolicies.special = 1;
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
                  'Password Restriction',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialPasswordPolicies(8, 32),
                _textToDisplayForCurrentPasswordPolicies(8, 32),
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
