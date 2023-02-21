import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class RegistryAccess {
   static Future<int> getBootStartDriverPolicy() async {
     try {
       final key1 = Registry.openPath(RegistryHive.localMachine,
           path: r'SYSTEM\CurrentControlSet\Policies\EarlyLaunch');

       final bootStart = key1.getValueAsInt("DriverLoadPolicy");
       if (bootStart != null) {
         //print(bootStart);
         return bootStart;
       }
       return 0;
     } catch (e){
       //final key2 = Registry.openPath(RegistryHive.localMachine,
          // path: r'SYSTEM\CurrentControlSet\Policies\');
       var shell = PRS.Shell();
           await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Policies\\EarlyLaunch /v DriverLoadPolicy /t Reg_Dword /d 8
       
         ''');
           return -1;
     }


   }

   static Future changeMaxPwAge() async {
         // This works on Windows/Linux/Mac
         var shell = PRS.Shell();
         await shell.run('''
    
            net accounts /maxpwage:90

       ''');
       }
   static Future changeMinPwLen() async {
     // This works on Windows/Linux/Mac
     var shell = PRS.Shell();
     await shell.run('''
    
            net accounts /minpwlen:8

       ''');
   }

   static Future changePwHist() async {
     // This works on Windows/Linux/Mac
     var shell = PRS.Shell();
     await shell.run('''
    
            net accounts /uniquepw:10

       ''');
   }
}