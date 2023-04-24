import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;


class FirewallAccess {
  getFirewallStates() {
    int firewallStates = 0;
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile');
      final privateFirewall = key1.getValueAsInt('EnableFirewall');
      if (privateFirewall == 1) {
        firewallStates += 1;
      }

      final key2 = Registry.openPath(RegistryHive.localMachine,
          path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile');
      final publicFirewall = key2.getValueAsInt('EnableFirewall');
      if (publicFirewall == 1) {
        firewallStates += 3;
      }

      final key3 = Registry.openPath(RegistryHive.localMachine,
          path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile');
      final domainFirewall = key3.getValueAsInt('EnableFirewall');
      if (domainFirewall == 1) {
        firewallStates += 5;
      }
    } catch (e) {
      print('error within firewall files');
      print(e);
    }
    return firewallStates;
  }

  static int getRealTimeProtection() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\Windows Defender\Real-Time Protection');
      final disable = key1.getValueAsInt('DisableRealtimeMonitoring');
      if (disable!=null) {
        delRealTimeProtection();
        return 0;
      }
      //delSecurityLog();
      //createRealTimeProtection();
      return 1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      //setMinPwLen(8);
      createRealTimeProtection();
      return 1;
    }
  }

  static void delRealTimeProtection() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg delete "HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection" /f
       
         ''');
  }
  static void createRealTimeProtection() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add "HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\Windows Defender\\Real-Time Protection" /f
       
         ''');
  }
  static void turnOnRealTimeProtection() async {
    var shell = PRS.Shell();
    await shell.run('''
       Powershell set-mppreference -disablerealtimemonitoring 0
         ''');
  }
}