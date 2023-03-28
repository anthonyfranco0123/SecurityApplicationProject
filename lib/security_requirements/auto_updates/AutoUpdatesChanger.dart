import 'package:process_run/shell.dart';

class AutoUpdatesChanger {
  final _shell = Shell();
   void autoUpdatesOn() {
    _shell.run(''' reg add HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU /v NoAutoUpdate  /t REG_DWORD /d 0 /f ''');
  }

   AutoUpdatesOff() {
    _shell.run('''reg add HKLM\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU /v NoAutoUpdate  /t REG_DWORD /d 1 /f''');
  }//'
}