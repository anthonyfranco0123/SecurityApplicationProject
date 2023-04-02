import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';

import 'initialization_policies/intialization_policies_state.dart';

class RequirementFiveWidget extends StatefulWidget {

  const RequirementFiveWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementFiveWidget> createState() => RequirementFiveWidgetState();
}

class RequirementFiveWidgetState extends State<RequirementFiveWidget> with AutomaticKeepAliveClientMixin {
  late Timer timer;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _initializationPoliciesStateText() {
    String initializationPoliciesStatesText = '';
    switch (InitializationPoliciesState.bootStart) {
      case 0:
        initializationPoliciesStatesText =
        'Boot-Start Driver Initialization Policy is Not Configured';
        break;
      case 1:
        initializationPoliciesStatesText =
        'Boot-Start Driver Initialization Policy is Good and Unknown';
        break;
      case 3:
        initializationPoliciesStatesText =
        'Boot-Start Driver Initialization Policy is Good, Unknown, and Bad But Critical';
        break;
      case 7:
        initializationPoliciesStatesText =
        'Boot-Start Driver Initialization Policy is Configured to All';
        break;
      case 8:
        initializationPoliciesStatesText = 'Boot-Start Driver Initialization Policy is Good';
        break;
      default:
        initializationPoliciesStatesText = 'Error: Unable to determine the initialization policies states!';
    }
    return initializationPoliciesStatesText;
  }

  Text _textToDisplayForInitializationPoliciesStates() {
    Color c = Colors.yellow;
    _periodicallyUpdateInitializationPoliciesStatus();
    if (InitializationPoliciesState.bootStart != 8) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    RequirementVariables.initializationPolicies = InitializationPoliciesState.bootStart;
    return Text(
      _initializationPoliciesStateText(),
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
        if (InitializationPoliciesState.bootStart != 8) {
          InitializationPoliciesState().futureIntToInt();
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
              'Check Your Boot-Start Driver Initialization',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            const Padding(padding: EdgeInsets.all(8.0)),
            _textToDisplayForInitializationPoliciesStates(),
          ],
        ),
      ),
    );
  }
}
