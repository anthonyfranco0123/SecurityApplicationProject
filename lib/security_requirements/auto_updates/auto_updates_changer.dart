import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class AutoUpdates {
  Future<int> getAutoUpdatesKey() async {
    int? privateSUpdates = -1;
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU');
      privateSUpdates = key1.getValueAsInt("NoAutoUpdate");
    } catch (e){
      var shell = PRS.Shell();
      await shell.run('''
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU /v NoAutoUpdate  /t REG_DWORD /d 0 /f
         ''');
      return 2;
    }
    if (privateSUpdates != null) {
      //print(bootStart);
      if (privateSUpdates == 1) {
        //print('Auto Updates : off');
        var shell = PRS.Shell();
        await shell.run('''
           reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows\\WindowsUpdate\\AU /v NoAutoUpdate /t REG_DWORD /d 0 /f 
         ''');
        privateSUpdates == 1;
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
        //print('Auto Updates registry value does not exist');
        privateSUpdates == 3;
        return 3;
      }
    }
    else {
      return -1;
    }
  }
}