import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirment_variables.dart';
import 'package:flutter_security_application/security_requirements/auto_updates/AutoUpdates.dart';

class RequirementSixWidget extends StatefulWidget {
  const RequirementSixWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementSixWidget> createState() => RequirementSixWidgetState();
}

class RequirementSixWidgetState extends State<RequirementSixWidget> {
  int privateSUpdates = -2;

  @override
  void initState() {
    super.initState();
  }

  String _currentAutoUpdatesStateText() {
    String firewallStatesText = '';
    switch (privateSUpdates) {
      case -1:
        firewallStatesText =
            'Auto Update Policy is Not Configured because of Path';
        break;
      case 1:
        firewallStatesText = 'Auto Update Policy is Not Configured';
        break;
      case 0:
        firewallStatesText = 'Auto Update Policy is Good';
        break;
      case 3:
        firewallStatesText = 'Path exists, wrong type';
        break;
      default:
        firewallStatesText =
            'Error: Unable to determine the auto-updates state!';
    }
    return firewallStatesText;
  }

  Text _textToDisplayForAutoUpdatesState() {
    Color c = Colors.yellow;
    if (privateSUpdates != 0) {
      c = Colors.red;
    } else {
      c = Colors.white;
      RequirementVariables.autoUpdates = true;
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
              'Check Your Auto Updates',
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
              child: const Text('AutoUpdates'),
              onPressed: () async {
                privateSUpdates = await AutoUpdates.getAutoUpdatesKey();
                setState(() {});
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            _textToDisplayForAutoUpdatesState(),
            // if (privateSUpdates == -1)
            //   const Text(
            //     'Auto Update Policy is Not Configured because of Path',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // if (privateSUpdates == 1)
            //   const Text(
            //     'Auto Update Policy is Not Configured',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // if (privateSUpdates == 0)
            //   const Text(
            //     'Auto Update Policy is Good',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
            // if (privateSUpdates == 3)
            //   const Text(
            //     'Path exists, wrong type',
            //     style: TextStyle(
            //       color: Colors.white,
            //     ),
            //     textAlign: TextAlign.center,
            //   ),
          ],
        ),
      ),
    );
  }
}
