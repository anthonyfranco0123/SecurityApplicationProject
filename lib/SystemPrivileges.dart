import 'package:win32_registry/win32_registry.dart';
  class SystemPrivileges {
    static systemPrivilegesState(){
      int state;
      final key1 = Registry.openPath(RegistryHive.localMachine,

      path: r'SOFTWARE\Microsoft\PolicyManager\default\ApplicationManagement\MSIAlwaysInstallWithElevatedPrivileges');
          final alwaysInstallElevated = key1.getValueAsInt('value');
      print(alwaysInstallElevated);
        if (alwaysInstallElevated == 1) {
            print('AlwaysInstallElevated state: on');
            state = 1;
          }
          else {
            print('AlwaysInstallElevated state: off');
            state = 0;
          }

    }
  }