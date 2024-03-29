import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class InitializationPoliciesChanger {
   static int getBootStartDriverPolicy()  {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SYSTEM\CurrentControlSet\Policies\EarlyLaunch');

      final bootStart = key1.getValueAsInt("DriverLoadPolicy");
      if (bootStart != null) {
        return bootStart;
      }
      setBootStartDriverPolicy();
      return 0;
    } catch (e){
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setBootStartDriverPolicy();
      return -1;
    }
  }

  static void setBootStartDriverPolicy() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Policies\\EarlyLaunch /v DriverLoadPolicy /t Reg_Dword /d 8 /f
       
         ''');

  }
}