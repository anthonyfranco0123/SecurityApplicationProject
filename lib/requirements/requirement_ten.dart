import 'package:flutter/material.dart';
import 'package:flutter_security_application/RegistryAccess.dart';

class RequirementTenWidget extends StatefulWidget {
  const RequirementTenWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTenWidget> createState() => RequirementTenWidgetState();
}

class RequirementTenWidgetState extends State<RequirementTenWidget> {
  @override
  void initState() {
    super.initState();
  }

  Text firewallStateText(int firewallStates){
    String firewallStatesText = '';
    Color c = Colors.red;
    switch(firewallStates){
      case 0:
        firewallStatesText = 'Private, Public, and Domain firewalls are off! Press the button above to turn them on!';
        break;
      case 1:
        firewallStatesText = 'Public and Domain firewalls are off! Please go to your settings to turn them on!';
        break;
      case 3:
        firewallStatesText = 'Private and Domain firewalls are off! Please go to your settings to turn them on!';
        break;
      case 4:
        firewallStatesText = 'Domain firewall is off! Please go to your settings to turn it on!';
        break;
      case 5:
        firewallStatesText = 'Private and Public firewalls are off! Please go to your settings to turn them on!';
        break;
      case 6:
        firewallStatesText = 'Public firewall is off! Please go to your settings to turn it on!';
        break;
      case 8:
        firewallStatesText = 'Private firewall is off! Please go to your settings to turn it on!';
        break;
      case 9:
        firewallStatesText = 'Private, Public, and Domain firewalls are all on! Good job on keeping your computer protected!';
        c = Colors.white;
        break;
      case 10:
        firewallStatesText = 'Turned firewall on!';
        c = Colors.white;
        break;
      default:
        firewallStatesText = 'Error: Unable to determine the firewall states!';
    }
    return Text(
      firewallStatesText,
      style: TextStyle(
        color: c,
      ),
      textAlign: TextAlign.center,
    );
  }

  int buttonState = 0;
  int firewallStates = -1;
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
              'Check Your Firewall State',
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
              onPressed: (buttonState==0) ?  () {
                setState(() {
                  firewallStates = RegistryAccess.getFirewallStates();
                }
                );
                if (firewallStates!=9 && firewallStates!=10){
                  buttonState=-1;
                }
                else{
                  buttonState = 0;
                }
              } : (){
                setState(() {
                  RegistryAccess.turnOnFirewall();
                  firewallStates = 10;
                  buttonState = 0;
                });
              },
              child: (buttonState==0)? const Text('Firewall State') : const Text('Turn on firewall'),
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            if (firewallStates == 0)
              firewallStateText(firewallStates),
            if (firewallStates == 1)
              firewallStateText(firewallStates),
            if (firewallStates == 3)
              firewallStateText(firewallStates),
            if (firewallStates == 4)
              firewallStateText(firewallStates),
            if (firewallStates == 5)
              firewallStateText(firewallStates),
            if (firewallStates == 6)
              firewallStateText(firewallStates),
            if (firewallStates == 8)
              firewallStateText(firewallStates),
            if (firewallStates == 9)
              firewallStateText(firewallStates),
            if (firewallStates == 10)
              firewallStateText(firewallStates),
          ],
        ),
      ),
    );
  }
}
