import 'package:flutter/material.dart';
import 'package:flutter_security_application/securityrequirements/firewall/firewall_access.dart';
import 'package:flutter_security_application/securityrequirements/firewall/firewall_state_changer.dart';

class RequirementTenWidget extends StatefulWidget {
  const RequirementTenWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTenWidget> createState() => _RequirementTenWidgetState();
}

class _RequirementTenWidgetState extends State<RequirementTenWidget> {
  static int initialFirewallStates = FirewallAccess().getFirewallStates();
  int currentFirewallStates = -1;

  @override
  void initState() {
    super.initState();
  }

  String _initialFirewallStateText(int firewallStates) {
    String firewallStatesText = '';
    switch (firewallStates) {
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
        firewallStatesText =
        'Initial Status: Domain firewall is off!';
        break;
      case 5:
        firewallStatesText =
        'Initial Status: Private and Public firewalls are off!';
        break;
      case 6:
        firewallStatesText =
        'Initial Status: Public firewall is off!';
        break;
      case 8:
        firewallStatesText =
        'Initial Status: Private firewall is off!';
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

  String _currentFirewallStateText(int firewallStates) {
    String firewallStatesText = '';
    switch (firewallStates) {
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
        firewallStatesText =
            'Current Status: Domain firewall is off!';
        break;
      case 5:
        firewallStatesText =
            'Current Status: Private and Public firewalls are off!';
        break;
      case 6:
        firewallStatesText =
            'Current Status: Public firewall is off!';
        break;
      case 8:
        firewallStatesText =
            'Current Status: Private firewall is off!';
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

  Future<void> turningOnAllFirewallStates() async {
    await FirewallStateChanger().allFirewallStatesOn();
  }

  Future<void> settingCurrentFirewallStates() async {
    await FirewallStateChanger().allFirewallStatesOn();
  }

  void setCurrentFirewallStates() {
    setState(() {
      // FirewallStateChanger().allFirewallStatesOn();
      print(currentFirewallStates);
      FirewallStateChanger().allFirewallStatesOn();
      settingCurrentFirewallStates();
      // currentFirewallStates = FirewallAccess().getFirewallStates();
      print(currentFirewallStates);
    });
  }

  Text _textToDisplayForInitialFirewallStates(int initialFirewallStates) {
    String textToDisplayForInitialFirewallStates = '';
    Color c = Colors.yellow;
    if(initialFirewallStates != 9) {
      c = Colors.red;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText(initialFirewallStates);
    } else {
      c = Colors.white;
      currentFirewallStates = initialFirewallStates;
      textToDisplayForInitialFirewallStates = _initialFirewallStateText(initialFirewallStates);
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
    turningOnAllFirewallStates();
    setCurrentFirewallStates();
    if(currentFirewallStates != 9) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    print('-');
    print(currentFirewallStates);
    return Text(
      _currentFirewallStateText(currentFirewallStates),
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
              'Your Firewall State:',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            _textToDisplayForInitialFirewallStates(initialFirewallStates),
            _textToDisplayForCurrentFirewallStates(),
            const Padding(padding: EdgeInsets.all(8.0)),
            Visibility(
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: false,
              child: Row(
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
    );
  }
}
