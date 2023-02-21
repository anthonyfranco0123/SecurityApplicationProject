import 'package:process_run/shell.dart';

class FirewallStateChanger {
  final _shell = Shell();

  allFirewallStatesOn() {
    _shell.run('''netsh advfirewall set allprofiles state on''');
  }

  allFirewallStatesOff() {
    _shell.run('''netsh advfirewall set allprofiles state off''');
  }
}