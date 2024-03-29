import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import 'package:flutter_security_application/admin/admin_state.dart';
import 'package:flutter_security_application/security_requirements/system_privileges/system_privileges_state.dart';

class RequirementEightWidget extends StatefulWidget {
  const RequirementEightWidget({super.key});

  @override
  State<RequirementEightWidget> createState() => RequirementEightWidgetState();
}

class RequirementEightWidgetState extends State<RequirementEightWidget>
    with AutomaticKeepAliveClientMixin{
  //var output;
  //var display="";
  //bool isShown = false;
  //int a = SystemPrivileges.systemPrivilegesState();
  int initialSystemState = -1;
  int currentSystemState = -1;
  late Timer timer;
  @override
  bool get wantKeepAlive => true;
  @override
  void initState() {
    initialSystemState = SystemPrivilegesState().getSystemPrivilegeKey();
    super.initState();
  }

  @override
  void dispose(){
    timer.cancel();
    super.dispose();
  }

  String _initialSystemStateText(){
    String systemStateText = '';
    switch (initialSystemState){
      case 0:
        systemStateText =
            'Non-Compliant';
        break;
      case 1:
        systemStateText =
            'Initial Status: Always Elevated is Off';
        break;
      case 2:
        systemStateText =
        'Initial Status: Always Elevated is On';
        break;
      case 3:
        systemStateText =
        'Could Not Find Key or Could not Change Key';
        break;
      default:
        systemStateText =
            'Error: Unable to find Always Elevated Status';
    }
    return systemStateText;
  }

  String _currentSystemStateText(){
    String  systemStateText = '';
    switch (currentSystemState){

      case 0:
        systemStateText =
        'Non-Compliant';
        break;
      case 1:
        systemStateText =
        'Current Status: Always Elevated is Off';
        break;
      case 2:
        systemStateText =
        'Current Status: Always Elevated is Off';
        break;
      case 3:
        systemStateText =
        'Could Not Find Key or Could not Change Key';
        break;
      default:
        systemStateText =
        'Error: Unable to find Always Elevated Status';
    }
    return systemStateText;
  }

  Text _textToDisplayForInitialSystemState() {
    String textToDisplayForInitialSystemState = '';
    Color c = Colors.yellow;
    if (initialSystemState != 1) {
      c = Colors.red;
      textToDisplayForInitialSystemState = _initialSystemStateText();
    } else {
      c = Colors.white;
      currentSystemState = initialSystemState;
      textToDisplayForInitialSystemState = _initialSystemStateText();
    }
    return Text(
      textToDisplayForInitialSystemState,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _textToDisplayForCurrentSystemState() {
    Color c = Colors.yellow;
    _periodicallyUpdateCurrentSystemStatus();
    if (currentSystemState != 1) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    return Text(
      _currentSystemStateText(),
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  void _periodicallyUpdateCurrentSystemStatus() {
    currentSystemState = RequirementVariables.systemPrivileges = SystemPrivilegesState().getSystemPrivilegeKey();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (currentSystemState != 1) {
          SystemPrivilegesState().getSystemPrivilegeKey();
        }
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    super.build(context);
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
                  'Your System Privileges State:',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialSystemState(),
                _textToDisplayForCurrentSystemState(),
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
                        child: const Text('Turn On Always Elevated'),
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
                            //
                          });
                        },
                        child: const Text('Turn Off Always Elevated'),
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
