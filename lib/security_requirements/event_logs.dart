import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirment_variables.dart';
import 'package:shell/shell.dart';

class RequirementThreeWidget extends StatefulWidget {
  const RequirementThreeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementThreeWidget> createState() => RequirementThreeWidgetState();
}

class RequirementThreeWidgetState extends State<RequirementThreeWidget> {
  String output = '';

  @override
  void initState() {
    runShellCommand();
    super.initState();
  }

  Future<String> runShellCommand() async {
    var shell = Shell();
    return await shell.startAndReadAsString('sc',
        arguments: ['query', "eventlog"]);
  }

  Future<void> futureStringToString(Future<String> fs) async {
    output = await fs;
  }

  Text _textToDisplayForCurrentEventLogsState() {
    Color c = Colors.yellow;
    String text = '';
    futureStringToString(runShellCommand());
    if (output.contains("STOPPED")) {
      c = Colors.red;
      text = 'Event Log Is Stopped';
      RequirementVariables.eventLogs = false;
    } else {
      c = Colors.white;
      text = 'Event Log Is Running';
      RequirementVariables.eventLogs = true;
    }
    return Text(
      text,
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
              'Check Event Log',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            const Padding(padding: EdgeInsets.all(8.0)),
            _textToDisplayForCurrentEventLogsState(),
          ],
        ),
      ),
    );
  }
}
