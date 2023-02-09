import 'package:flutter/foundation.dart';
import 'package:win32_registry/win32_registry.dart';
import 'dart:async';
import 'package:system_info2/system_info2.dart';
import 'package:process_run/shell.dart';
import 'dart:developer';
class RegistryAccess {

   static  firewallState()  {
     int pri, public, domain;
    final key1 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile');
    final key2 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile');
    final key3 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile');

    final privateFirewall = key1.getValueAsInt('EnableFirewall');
    final publicFirewall = key2.getValueAsInt('EnableFirewall');
    final domainFirewall = key3.getValueAsInt('EnableFirewall');

    if (privateFirewall != null && publicFirewall != null && domainFirewall != null) {
      if (privateFirewall == 1 && publicFirewall == 1 && domainFirewall == 1) {
        pri = 1;
        print('Private, Public, and Domain firewall state: on');
        return 'Private, Public, and Domain firewall state: on';
      }
      else {
        pri = 0;
        print('Private firewall state: off');
        return 'Private firewall state: off';
      }
    }

    if (publicFirewall != null) {
      if (publicFirewall == 1) {
        public = 1;
        print('Public firewall state: on');
        return 'Public firewall state: on';
      }
      else {
        public = 0;
        print('Public firewall state: off');
        return 'Public firewall state: off';
      }
    }

    if (domainFirewall != null) {
      if (domainFirewall == 1) {
        domain = 1;
        print('Domain firewall state: on');
        return'Domain firewall state: on';
      }
      else {
        domain = 0;
        print('Domain firewall state: off');
        return'Domain firewall state: off';
      }
    }


  }

  //Getter Method static getState

  static Future shellTest() async {
    // This works on Windows/Linux/Mac

    var shell = Shell();

    print(SysInfo.userName.toString());
    await shell.run('''
      #enable password expiry
      wmic UserAccount where "Name='${SysInfo.userName.toString()}'" set PasswordExpires=True
      
      #The commands below will change certain password settings
      #However, it will require admin privilege, which I dont know how to enable
      
      #net accounts /maxpwage:90
      #net accounts /minpwage:10
      #net accounts /minpwlen:8
      net accounts


  ''');
  }
}