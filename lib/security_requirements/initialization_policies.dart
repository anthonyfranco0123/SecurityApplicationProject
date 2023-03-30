import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirment_variables.dart';
import 'package:flutter_security_application/security_requirements/password/RegistryAccess.dart';

class RequirementFiveWidget extends StatefulWidget {

  const RequirementFiveWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementFiveWidget> createState() => RequirementFiveWidgetState();
}

class RequirementFiveWidgetState extends State<RequirementFiveWidget>{
  @override
  void initState() {
    super.initState();
  }
int bootStart = -2;
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
              'Check Your Boot-Start Driver Initialization',
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
              child: const Text('Boot-start Driver Initialization'),
              onPressed: () async {
                bootStart = await RegistryAccess.getBootStartDriverPolicy();
                RequirementVariables.initializationPolicies = bootStart;
                setState(()  {

                });
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            if (bootStart == -1)
              const Text(
                'Boot-Start Driver Initialization Policy is Not Configured, But now set to All',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (bootStart == 0)
              const Text(
                'Boot-Start Driver Initialization Policy is Not Configured, but now set to All',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (bootStart == 1)
              const Text(
                'Boot-Start Driver Initialization Policy is Good and Unknown',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (bootStart == 3)
              const Text(
                'Boot-Start Driver Initialization Policy is Good, Unknown, and Bad But Critical',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (bootStart == 7)
              const Text(
                'Boot-Start Driver Initialization Policy is Configured to All',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (bootStart == 8)
              const Text(
                'Boot-Start Driver Initialization Policy is Good',
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
