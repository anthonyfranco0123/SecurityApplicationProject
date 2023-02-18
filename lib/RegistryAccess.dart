// import 'package:flutter/foundation.dart';
// import 'dart:async';
// import 'package:system_info2/system_info2.dart';
// import 'dart:developer';
import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class RegistryAccess {
  //  static  getFirewallStates()  {
  //    int firewallStates = 0;
  //   final key1 = Registry.openPath(RegistryHive.localMachine,
  //       path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile');
  //   final privateFirewall = key1.getValueAsInt('EnableFirewall');
  //   if (privateFirewall != null) {
  //     if (privateFirewall == 1) {
  //       print('Private firewall state: on');
  //       firewallStates+=1;
  //     }
  //     else {
  //       print('Private firewall state: off');
  //     }
  //   }
  //
  //   final key2 = Registry.openPath(RegistryHive.localMachine,
  //       path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile');
  //   final publicFirewall = key2.getValueAsInt('EnableFirewall');
  //   if (publicFirewall != null) {
  //     if (publicFirewall == 1) {
  //       print('Public firewall state: on');
  //       firewallStates+=3;
  //     }
  //     else {
  //       print('Public firewall state: off');
  //     }
  //   }
  //
  //   final key3 = Registry.openPath(RegistryHive.localMachine,
  //       path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile');
  //   final domainFirewall = key3.getValueAsInt('EnableFirewall');
  //   if (domainFirewall != null) {
  //     if (domainFirewall == 1) {
  //       print('Domain firewall state: on');
  //       firewallStates+=5;
  //     }
  //     else {
  //       print('Domain firewall state: off');
  //     }
  //     return firewallStates;
  //   }
  // }
  //
  //  //Getter Method static getState
  //  static Future turnOnFirewall() async {
  //    // This works on Windows/Linux/Mac
  //    var shell = PRS.Shell();
  //    await shell.run('''
  //      #enable password expiry
  //      #wmic UserAccount where "Name='${SysInfo.userName.toString()}'" set PasswordExpires=True
  //
  //     netsh advfirewall set allprofiles state on
  //
  //      #net accounts /maxpwage:90
  //      #net accounts /minpwage:10
  //      #net accounts /minpwlen:8
  //      #net accounts
  //  ''');
  //  }

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
       print("In here");
       var shell = PRS.Shell();
           await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Policies\\EarlyLaunch /v DriverLoadPolicy /t Reg_Dword /d 8
       
         ''');
           return -1;
     }

     return 0;
   }
}