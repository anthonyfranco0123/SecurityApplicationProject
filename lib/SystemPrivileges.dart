import 'package:win32_registry/win32_registry.dart';
  class SystemPrivileges {
    systemPrivilegesState() {
      int state = 0;
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\MSIAlwaysInstallWithElevatedPrivileges');
      final alwaysInstallElevated = key1.getValueAsString('value');
      //print(alwaysInstallElevated);
      if (alwaysInstallElevated == "0x0") {
        //print('AlwaysInstallElevated state: off');
        state = 1;
      }
      else if (alwaysInstallElevated == "0x1") {
        //print('AlwaysInstallElevated state: on');
        state = 2;
      }
      else {
        //print('AlwaysInstallElevated registry value does not exist');
        state = 3;
      }
      return state;
    }
  }