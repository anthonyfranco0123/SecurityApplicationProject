import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class AutoUpdates {
 /* static int getAutoUpdatesKey()  {
    int? privateSUpdates;
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU');
      privateSUpdates = key1.getValueAsInt("NoAutoUpdate");
    } catch (e){
      setautoPrivKey();
      return 2;
    }
    if (privateSUpdates != null) {
      if (privateSUpdates == 1) {
        setautoPrivKey();
        //return privateSUpdates;
        //return 0;
        //AUStates = 0;
        return 1;
      }
      else if (privateSUpdates == 0) {
        privateSUpdates == 0;
        return 0;
      }
      else {
        privateSUpdates == 3;
        return 3;
      }
    }
    else {
      return -1;
    }
  }

  */

  static int getAutoUpdatesKey() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU');
      final privateUpdates = key1.getValueAsInt("NoAutoUpdate");
      //final minLen = key1.getValueAsInt("MinimumPINLength");
      if (privateUpdates != null) {
        return privateUpdates;
      }
      setAutoPrivKey();
      return 2;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setAutoPrivKey();
      return 3;
    }
  }


  static void setAutoPrivKey() async {
    var shell = PRS.Shell();
    await shell.run('''
          reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU /v NoAutoUpdate /t REG_DWORD /d 0 /f
        ''');
  }
}

