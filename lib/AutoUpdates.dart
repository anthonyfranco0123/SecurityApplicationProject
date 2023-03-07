import 'package:win32_registry/win32_registry.dart';
import 'dart:async';
//import 'package:system_info2/system_info2.dart';
import 'package:process_run/shell.dart';
class AutoUpdates{
        static getSystemUpdates() {
        int AUStates = 0;
        final key1 = Registry.openPath(RegistryHive.localMachine,
            path: r'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU');
        final privateSUpdates = key1.getValueAsInt('NoAutoUpdate');
        print(privateSUpdates);
        if (privateSUpdates != null) {
          if (privateSUpdates == 0) {
            print('Auto Updates : on');
            //AUStates = 0;
          }
          else {
            print('Auto Updates : off');
          }
        }
      }
}

