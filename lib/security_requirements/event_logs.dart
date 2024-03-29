import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import 'package:flutter_security_application/security_requirements/event_logs/event_logs_access.dart';
import 'package:flutter_security_application/security_requirements/event_logs/event_logs_initial_state.dart';


import '../admin/admin_state.dart';

class RequirementThreeWidget extends StatefulWidget {
  const RequirementThreeWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementThreeWidget> createState() => RequirementThreeWidgetState();
}

class RequirementThreeWidgetState extends State<RequirementThreeWidget> with AutomaticKeepAliveClientMixin {
  int initialEventLogsState = -1;
  // stringCurrentState = '';
  int currentEventLogsState = -1;
  late Timer timer;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    currentEventLogsState = initialEventLogsState = EventLogsAccess.getSecurityLog();
    //eventLogsStringOutput();
    super.initState();
  }

  /*eventLogsStringOutput() async {
    EventLogsAccess().futureStringToString().then((value){ setState(() {
      stringCurrentState=value;
      eventLogsState();
    });});
  }

  eventLogsState() {
    if (stringCurrentState.contains("STOPPED")) {
      currentEventLogsState = false;
    } else if (stringCurrentState.contains("RUNNING")) {
      currentEventLogsState =true;
    }
    // else {
    //   currentEventLogsState = -1;
    // }
  }
*/
  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _initialEventLog(){
    String eventLogText = '';
    if(initialEventLogsState == 1){
      eventLogText = 'Initial Status: Windows Log Disabled';
    }

    else {
      eventLogText = 'Initial Status: Windows Log Enabled';
    }

    return eventLogText;
  }

  String _currentEventLog(){
    String eventLogText = '';
    if(currentEventLogsState == 1){
      eventLogText = 'Current Status: Windows Log Disabled';
    }

    else {
      eventLogText = 'Current Status: Windows Log Enabled';
    }

    return eventLogText;
  }

  Text _textToDisplayForInitialEventLogsState() {
    Color c = Colors.yellow;
    String text = '';
    // _periodicallyUpdateCurrentEventLogsStatus();
    if (initialEventLogsState!=0) {
      c = Colors.red;
      text = _initialEventLog();
      // RequirementVariables.eventLogs = false;
    } else {
      c = Colors.white;
      text = _initialEventLog();
      // RequirementVariables.eventLogs = true;
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

  Text _textToDisplayForCurrentEventLogsState() {
    Color c = Colors.yellow;
    String text = '';
     _periodicallyUpdateCurrentEventLogsStatus();
    if (currentEventLogsState!=0) {
      c = Colors.red;
      text = _currentEventLog();
      RequirementVariables.eventLogs = false;
    } else {
      c = Colors.white;
      text = _currentEventLog();
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

   void _periodicallyUpdateCurrentEventLogsStatus() {
     //currentEventLogsState = EventLogsAccess.getSecurityLog();
     RequirementVariables.eventLogs = true;
     Timer.periodic(const Duration(seconds: 4), (timer) {
       setState(() {
         if(currentEventLogsState != 0) {
           EventLogsAccess.delSecurityLog();
           currentEventLogsState = 0;

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
                  'Check Event Log',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialEventLogsState(),
                _textToDisplayForCurrentEventLogsState(),
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
                        child: const Text('Turn On Event Logs'),
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
                        child: const Text('Turn Off Event Logs'),
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
