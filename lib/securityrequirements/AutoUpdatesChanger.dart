import 'package:process_run/shell.dart';

class AutoUpdatesChanger {
  final _shell = Shell();
   void autoUpdatesOn() {
    _shell.run(''' reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate  /d 0x00000000 /f ''');
  }

   AutoUpdatesOff() {
    _shell.run('''reg add HKLM\SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU /v NoAutoUpdate  /d 0x00000001 /f''');
  }//'
}