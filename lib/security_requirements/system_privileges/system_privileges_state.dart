
import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class SystemPrivilegesState {
  static int getSystemPrivKey() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\MSIAlwaysInstallWithElevatedPrivileges');
      final state = key1.getValueAsString("value");
      if (state != Null) {
        if (state == '0x0') {
          return 1;
        }
        else if (state == '0x1') {
          setsystemPrivKey();
          return 0;
        }
        else {

          return 3;
        }
      }
      else {
        return -1;
      }
    } catch (e) {
      setsystemPrivKey();
      return 2;
    }
  }


  static void setsystemPrivKey() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Microsoft\\PolicyManager\\default\\ApplicationManagement\\MSIAlwaysInstallWithElevatedPrivileges /v value /d 0x0 /f''');
  }
}
