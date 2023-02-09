// import 'package:flutter/foundation.dart';
// import 'dart:async';
// import 'package:system_info2/system_info2.dart';
// import 'package:process_run/shell.dart';
// import 'dart:developer';
import 'package:win32_registry/win32_registry.dart';

class RegistryAccess {
   static  getFirewallStates()  {
     // int pri, public, domain;
     int firewallStates = 0;
    final key1 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile');
    final privateFirewall = key1.getValueAsInt('EnableFirewall');
    if (privateFirewall != null) {
      if (privateFirewall == 1) {
        // pri = 1;
        print('Private firewall state: on');
        // return 'Private firewall state: on';
        firewallStates+=1;
      }
      else {
        // pri = 0;
        print('Private firewall state: off');
        // return 'Private firewall state: off';
      }
    }

    final key2 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile');
    final publicFirewall = key2.getValueAsInt('EnableFirewall');
    if (publicFirewall != null) {
      if (publicFirewall == 1) {
        // public = 1;
        print('Public firewall state: on');
        // return 'Public firewall state: on';
        firewallStates+=3;
      }
      else {
        // public = 0;
        print('Public firewall state: off');
        // return 'Public firewall state: off';
      }
    }

    final key3 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile');
    final domainFirewall = key3.getValueAsInt('EnableFirewall');
    if (domainFirewall != null) {
      if (domainFirewall == 1) {
        // domain = 1;
        print('Domain firewall state: on');
        // return'Domain firewall state: on';
        firewallStates+=5;
      }
      else {
        // domain = 0;
        print('Domain firewall state: off');
        // return'Domain firewall state: off';
      }
      return firewallStates;
    }

   // if (domain == 1){

    //}
  }

  //Getter Method static getState

  // static Future shellTest() async {
  //   // This works on Windows/Linux/Mac
  //
  //   var shell = Shell();
  //
  //   print(SysInfo.userName.toString());
  //   await shell.run('''
  //     #enable password expiry
  //     wmic UserAccount where "Name='${SysInfo.userName.toString()}'" set PasswordExpires=True
  //
  //     #The commands below will change certain password settings
  //     #However, it will require admin privilege, which I dont know how to enable
  //
  //     #net accounts /maxpwage:90
  //     #net accounts /minpwage:10
  //     #net accounts /minpwlen:8
  //     net accounts
  //
  //
  // ''');
  // }
}