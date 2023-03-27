import 'package:win32_registry/win32_registry.dart';
//import 'dart:async';
//import 'package:system_info2/system_info2.dart';
//import 'package:process_run/shell.dart';
class AutoUpdates{
        getSystemUpdates() {
        int AUStates = 0;
        final key1 = Registry.openPath(RegistryHive.localMachine,
            path: r'SOFTWARE\Policies\Microsoft\Windows\WindowsUpdate\AU');
        final privateSUpdates = key1.getValueAsString('NoAutoUpdate');
        //print(privateSUpdates);
          if (privateSUpdates == "0x00000001") {
            //print('Auto Updates : off');
            AUStates = 0;
            //return 0;
            //AUStates = 0;
          }
          else if (privateSUpdates == "0x00000000") {
            //print(' Auto Updates : on');
            AUStates = 1;
          }
          else {
            //print('Auto Updates registry value does not exist');
            AUStates = 2;
          }
          return AUStates;
        }
}

