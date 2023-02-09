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

  int firewallStates = -1;
  // String result = '';
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
              child: const Text('Firewall State'),
              onPressed: () {
                setState(() {
                  firewallStates = RegistryAccess.getFirewallStates();
                });
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            if (firewallStates == 0)
              const Text(
                'Private, Public, and Domain firewalls are off! Please go to your settings to turn them on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 1)
              const Text(
                'Public and Domain firewalls are off! Please go to your settings to turn them on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 3)
              const Text(
                'Private and Domain firewalls are off! Please go to your settings to turn them on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 4)
              const Text(
                'Domain firewall is off! Please go to your settings to turn it on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 5)
              const Text(
                'Private and Public firewalls are off! Please go to your settings to turn them on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 6)
              const Text(
                'Public firewall is off! Please go to your settings to turn it on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 8)
              const Text(
                'Private firewall is off! Please go to your settings to turn it on!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (firewallStates == 9)
              const Text(
                'Private, Public, and Domain firewalls are all on! Good job on keeping your computer protected!',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
          ],
        ),
      ),
      //   floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      //
      //   floatingActionButton: SizedBox(
      //     height: 100.0,
      //     width: 100.0,
      //     child: FloatingActionButton(
      //       child: Text(result),
      //       onPressed: () => {
      //         setState((){
      //          result = RegistryAccess.firewallState();
      //       })
      //
      //   },
      //     ),
      //   ),
      // backgroundColor: Colors.blue[600],
    );
  }
}
