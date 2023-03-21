//import 'package:flutter_security_application/AutoUpdates.dart';
import 'package:process_run/shell.dart';

class AutoUpdatesChanger {
  final _shell = Shell();
  //if (AutoUpdates.getSystemUpdates() == "0x0")
   autoUpdatesOn() {
    _shell.run(
        ''' reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate  /d 0x00000000 /f ''');
  }

   autoUpdatesOff() {
    _shell.run(
        '''reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate  /d 0x00000001 /f''');
  }
}