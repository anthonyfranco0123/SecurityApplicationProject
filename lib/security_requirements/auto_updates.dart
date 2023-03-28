import 'package:flutter/material.dart';
import 'package:flutter_security_application/security_requirements/password/RegistryAccess.dart';

class RequirementSixWidget extends StatefulWidget {

  const RequirementSixWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementSixWidget> createState() => RequirementSixWidgetState();
}

class RequirementSixWidgetState extends State<RequirementSixWidget>{
  @override
  void initState() {
    super.initState();
  }
  int privateSUpdates  = -2;
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
                privateSUpdates  = await RegistryAccess.getAutoUpdatesKey();
                setState(()  {

                });
              },
            ),
            const Padding(padding: EdgeInsets.all(8.0)),
            if (privateSUpdates  == -1)
              const Text(
                'Auto Update Policy is Not Configured because of Path',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (privateSUpdates  == 1)
              const Text(
                'Auto Update Policy is Not Configured',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (privateSUpdates  == 0)
              const Text(
                'Auto Update Policy is Good',
                style: TextStyle(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            if (privateSUpdates  == 3)
              const Text(
                'Path exists, wrong type',
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


