import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_security_application/admin/admin_state.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_access.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_initial_state.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_state_changer.dart';

import '../requirement_variables.dart';

class FirewallStatesRequirementWidget extends StatefulWidget {
  const FirewallStatesRequirementWidget({super.key});

  @override
  State<FirewallStatesRequirementWidget> createState() =>
      _FirewallStatesRequirementWidgetState();
}

class _FirewallStatesRequirementWidgetState
    extends State<FirewallStatesRequirementWidget>
    with AutomaticKeepAliveClientMixin {
  int initialFirewallStates = -1;
  int currentFirewallStates = -1;
  late Timer timer;
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    initialFirewallStates = FirewallInitialState.initialFirewallStates;
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

  String _initialFirewallStateText() {
    String firewallStatesText = '';
    switch (initialFirewallStates) {
      case 0:
        firewallStatesText =
            'Initial Status: Private, Public, and Domain firewalls are off!';
        break;
      case 1:
        firewallStatesText =
            'Initial Status: Public and Domain firewalls are off!';
        break;
      case 3:
        firewallStatesText =
            'Initial Status: Private and Domain firewalls are off!';
        break;
      case 4:
        firewallStatesText = 'Initial Status: Domain firewall is off!';
        break;
      case 5:
        firewallStatesText =
            'Initial Status: Private and Public firewalls are off!';
        break;
      case 6:
        firewallStatesText = 'Initial Status: Public firewall is off!';
        break;
      case 8:
        firewallStatesText = 'Initial Status: Private firewall is off!';
        break;
      case 9:
        firewallStatesText =
            'Initial Status: Private, Public, and Domain firewalls are all on!';
        break;
      default:
        firewallStatesText = 'Error: Unable to determine the firewall states!';
    }
    return firewallStatesText;
  }

  String _currentFirewallStateText() {
    String firewallStatesText = '';
    switch (currentFirewallStates) {
      case 0:
        firewallStatesText =
            'Current Status: Private, Public, and Domain firewalls are off!';
        break;
      case 1:
        firewallStatesText =
            'Current Status: Public and Domain firewalls are off!';
        break;
      case 3:
        firewallStatesText =
            'Current Status: Private and Domain firewalls are off!';
        break;
      case 4:
        firewallStatesText = 'Current Status: Domain firewall is off!';
        break;
      case 5:
        firewallStatesText =
            'Current Status: Private and Public firewalls are off!';
        break;
      case 6:
        firewallStatesText = 'Current Status: Public firewall is off!';
        break;
      case 8:
        firewallStatesText = 'Current Status: Private firewall is off!';
        break;
      case 9:
        firewallStatesText =
            'Current Status: Private, Public, and Domain firewalls are all on!';
        break;
      default:
        firewallStatesText = 'Error: Unable to determine the firewall states!';
    }
    return firewallStatesText;
  }

  Text _textToDisplayForInitialFirewallStates() {
    String textToDisplayForInitialFirewallStates = '';
    Color c = Colors.yellow;
    if (initialFirewallStates != 9) {
      c = Colors.red;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    } else {
      c = Colors.white;
      currentFirewallStates = initialFirewallStates;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText();
    }
    return Text(
      textToDisplayForInitialFirewallStates,
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  Text _textToDisplayForCurrentFirewallStates() {
    Color c = Colors.yellow;
    _periodicallyUpdateCurrentFirewallStatus();
    if (currentFirewallStates != 9) {
      c = Colors.red;
      FirewallStateChanger().allFirewallStatesOn();
    } else {
      c = Colors.white;
    }
    return Text(
      _currentFirewallStateText(),
      style: TextStyle(
        color: c,
        fontSize: 16,
      ),
      textAlign: TextAlign.center,
    );
  }

  void _periodicallyUpdateCurrentFirewallStatus() {
    currentFirewallStates = RequirementVariables.firewallStates = FirewallAccess().getFirewallStates();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (currentFirewallStates != 9) {
          FirewallStateChanger().allFirewallStatesOn();
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
                  'Your Firewall State:',
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                _textToDisplayForInitialFirewallStates(),
                _textToDisplayForCurrentFirewallStates(),
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
                            // firewallStates = RegistryAccess.getFirewallStates();
                          });
                        },
                        child: const Text('Turn On Firewall'),
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
                        child: const Text('Turn Off Firewall'),
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
