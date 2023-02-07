import 'package:win32_registry/win32_registry.dart';
import 'dart:async';
import 'package:system_info2/system_info2.dart';
import 'package:process_run/shell.dart';
class RegistryAccess {

  void firewallState() {
    final key1 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile');
    final privateFirewall = key1.getValueAsInt('EnableFirewall');
    if (privateFirewall != null) {
      if (privateFirewall == 1) {
        print('Private firewall state: on');
      }
      else {
        print('Private firewall state: off');
      }
    }

    final key2 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile');
    final publicFirewall = key2.getValueAsInt('EnableFirewall');
    if (publicFirewall != null) {
      if (publicFirewall == 1) {
        print('Public firewall state: on');
      }
      else {
        print('Public firewall state: off');
      }
    }

    final key3 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile');
    final domainFirewall = key3.getValueAsInt('EnableFirewall');
    if (domainFirewall != null) {
      if (domainFirewall == 1) {
        print('Domain firewall state: on');
      }
      else {
        print('Domain firewall state: off');
      }
    }
  }

  Future shellTest() async {
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