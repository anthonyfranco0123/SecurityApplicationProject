import 'package:process_run/shell.dart';

class SystemPrivChanger {
  final _shell = Shell();

  alwaysElevatedOff() {
    _shell.run(
        'reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\PolicyManager\\default\\ApplicationManagement\\MSIAlwaysInstallWithElevatedPrivileges /v value /d 0x0 /f');
  }
  alwaysElevatedOn() {
    _shell.run(
      '''reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\PolicyManager\\default\\ApplicationManagement\\MSIAlwaysInstallWithElevatedPrivileges /v value /d 0x1 /f''');
  }
}
