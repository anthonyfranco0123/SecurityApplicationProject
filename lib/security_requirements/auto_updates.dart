import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import 'package:flutter_security_application/security_requirements/auto_updates/auto_updates_state.dart';

class RequirementSixWidget extends StatefulWidget {
  const RequirementSixWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementSixWidget> createState() => RequirementSixWidgetState();
}

class RequirementSixWidgetState extends State<RequirementSixWidget> with AutomaticKeepAliveClientMixin {
  late Timer timer;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    AutoUpdatesState().futureIntToInt();
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _currentAutoUpdatesStateText() {
    String autoUpdatesStateText = '';
    switch (AutoUpdatesState.privateSUpdates) {
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

  Text _textToDisplayForAutoUpdatesState() {
    Color c = Colors.yellow;
    _periodicallyUpdateAutoUpdatesStatus();
    if (AutoUpdatesState.privateSUpdates != 0) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    RequirementVariables.autoUpdates = AutoUpdatesState.privateSUpdates;
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
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (AutoUpdatesState.privateSUpdates != 1) {
          AutoUpdatesState().futureIntToInt();
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
            _textToDisplayForAutoUpdatesState(),
          ],
        ),
      ),
    );
  }
}
