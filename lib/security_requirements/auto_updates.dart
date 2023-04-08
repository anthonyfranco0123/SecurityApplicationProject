import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import 'package:flutter_security_application/security_requirements/auto_updates/auto_updates_changer.dart';

import '../admin/admin_state.dart';

class RequirementSixWidget extends StatefulWidget {
  const RequirementSixWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementSixWidget> createState() => RequirementSixWidgetState();
}

class RequirementSixWidgetState extends State<RequirementSixWidget> with AutomaticKeepAliveClientMixin {
  int initialSystemState = -1;
  int currentSystemState = -1;
  late Timer timer;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    initialSystemState = AutoUpdates().getAutoUpdatesKey();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _initialAutoUpdatesStateText() {
    String autoUpdatesStateText = '';
    switch (initialSystemState) {
      case 0:
        autoUpdatesStateText = 'Auto Update Policy is Good';
        break;
      case 1:
        autoUpdatesStateText = 'Auto Update Policy is Not Configured';
        break;
      case 2:
        autoUpdatesStateText =
        'Auto Update Policy is Not Configured because of Path';
        break;
      case 3:
        autoUpdatesStateText = 'Path exists, wrong type';
        break;
      default:
        autoUpdatesStateText =
        'Error: Unable to determine the auto-updates state!';
    }
    return autoUpdatesStateText;
  }

  String _currentAutoUpdatesStateText() {
    String autoUpdatesStateText = '';
    switch (currentSystemState) {
      case 0:
        autoUpdatesStateText = 'Auto Update Policy is Good';
        break;
      case 1:
        autoUpdatesStateText = 'Auto Update Policy is Not Configured';
        break;
      case 2:
        autoUpdatesStateText =
        'Auto Update Policy is Not Configured because of Path';
        break;
      case 3:
        autoUpdatesStateText = 'Path exists, wrong type';
        break;
      default:
        autoUpdatesStateText =
        'Error: Unable to determine the auto-updates state!';
    }
    return autoUpdatesStateText;
  }

  Text _textToDisplayForInitialAutoUpdatesState() {
    Color c = Colors.yellow;
    String textToDisplayForInitialAutoUpdatesState = '';
    if (initialSystemState != 0) {
      c = Colors.red;
      textToDisplayForInitialAutoUpdatesState = _initialAutoUpdatesStateText();

    } else {
      c = Colors.white;
      currentSystemState = initialSystemState;
      textToDisplayForInitialAutoUpdatesState = _initialAutoUpdatesStateText();
    }
    RequirementVariables.systemPrivileges = currentSystemState;
    return Text(
      textToDisplayForInitialAutoUpdatesState,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _textToDisplayForCurrentAutoUpdatesState() {
    Color c = Colors.yellow;
    _periodicallyUpdateAutoUpdatesStatus();
    if (currentSystemState != 0) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    return Text(
      _currentAutoUpdatesStateText(),
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  void _periodicallyUpdateAutoUpdatesStatus() {
    currentSystemState = AutoUpdates().getAutoUpdatesKey();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (currentSystemState != 1) {
          AutoUpdates().getAutoUpdatesKey();
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
                  'Check Your Auto Updates',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialAutoUpdatesState(),
                _textToDisplayForCurrentAutoUpdatesState(),
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
                        child: const Text('Turn On Auto-Updates'),
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
                        child: const Text('Turn Off Auto-Updates'),
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

