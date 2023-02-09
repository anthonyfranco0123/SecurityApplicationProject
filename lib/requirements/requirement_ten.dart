import 'package:flutter/material.dart';
import 'package:flutter_security_application/RegistryAccess.dart';


class RequirementTenWidget extends StatefulWidget {

  const RequirementTenWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementTenWidget> createState() => RequirementTenWidgetState();
}

class RequirementTenWidgetState extends State<RequirementTenWidget>{
  @override
  void initState() {
    super.initState();
  }
  String result = '';
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
        child: const Text('Req ten',
          style: TextStyle(
            fontSize: 35,
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      floatingActionButton: SizedBox(
        height: 100.0,
        width: 100.0,
        child: FloatingActionButton(
          child: Text(result),
          onPressed: () => {
            setState((){
             result = RegistryAccess.firewallState();
          })

      },
        ),
      ),
    backgroundColor: Colors.blue[600],
    );

  }
}