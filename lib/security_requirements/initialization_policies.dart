import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import '../admin/admin_state.dart';
import 'initialization_policies/intialization_policies_state.dart';
import 'initialization_policies/initialization_policies_changer.dart';

class RequirementFiveWidget extends StatefulWidget {

  const RequirementFiveWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementFiveWidget> createState() => RequirementFiveWidgetState();
}

class RequirementFiveWidgetState extends State<RequirementFiveWidget> with AutomaticKeepAliveClientMixin {
  int initialSystemState = -1;
  int currentSystemState = -1;
  late Timer timer;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    initialSystemState = InitializationPoliciesChanger.getBootStartDriverPolicy();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _initialinitializationPoliciesStateText() {
    String systemStateText = '';
    switch (initialSystemState) {
      case 0:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Not Configured';
        break;
      case 1:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Good and Unknown';
        break;
      case 3:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Good, Unknown, and Bad But Critical';
        break;
      case 7:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Configured to All';
        break;
      case 8:
        systemStateText = 'Boot-Start Driver Initialization Policy is Good';
        break;
      default:
        systemStateText = 'Error: Unable to determine the initialization policies states!';
    }
    return systemStateText;
  }

  String _currentinitializationPoliciesStateText() {
    String systemStateText = '';
    switch (currentSystemState) {
      case 0:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Not Configured';
        break;
      case 1:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Good and Unknown';
        break;
      case 3:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Good, Unknown, and Bad But Critical';
        break;
      case 7:
        systemStateText =
        'Boot-Start Driver Initialization Policy is Configured to All';
        break;
      case 8:
        systemStateText = 'Boot-Start Driver Initialization Policy is Good';
        break;
      default:
        systemStateText = 'Error: Unable to determine the initialization policies states!';
    }
    return systemStateText;
  }

  Text _textToDisplayForInitialInitializationPoliciesStates() {
    Color c = Colors.yellow;
    String textToDisplayForInitialInitializationPoliciesStates;
    if (initialSystemState != 8) {
      c = Colors.red;
      textToDisplayForInitialInitializationPoliciesStates = _initialinitializationPoliciesStateText();
    } else {
      c = Colors.white;
      currentSystemState = initialSystemState;
      textToDisplayForInitialInitializationPoliciesStates = _initialinitializationPoliciesStateText();
    }
    RequirementVariables.systemPrivileges = currentSystemState;
    return Text(
      textToDisplayForInitialInitializationPoliciesStates,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _textToDisplayForCurrentInitializationPoliciesStates() {
    Color c = Colors.yellow;
    _periodicallyUpdateInitializationPoliciesStatus();
    if (currentSystemState != 8) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    return Text(
      _currentinitializationPoliciesStateText(),
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  void _periodicallyUpdateInitializationPoliciesStatus() {
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (currentSystemState != 8) {
          InitializationPoliciesChanger.getBootStartDriverPolicy();
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
                  'Check Your Boot-Start Driver Initialization',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialInitializationPoliciesStates(),
                _textToDisplayForCurrentInitializationPoliciesStates(),
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