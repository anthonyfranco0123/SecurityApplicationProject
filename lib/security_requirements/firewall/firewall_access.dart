import 'package:win32_registry/win32_registry.dart';

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
}