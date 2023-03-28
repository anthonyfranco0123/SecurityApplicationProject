import 'package:flutter_security_application/database/requirements_data_collector.dart';

import 'mysql.dart';

class RequirementsDataSender {
  Future<void> sendRequirementData(
  ) async {
    var db = Mysql();
    await db.getConnection().then((conn) async {
      await conn.query(
        'insert into user_compliances_test (password_reset, password_restrictions, event_logs, initialization_policies, auto_updates, system_privileges, download_restrictions, firewall_states) values (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          RequirementsDataCollector().getPasswordReset,
          RequirementsDataCollector().getPasswordRestrictions,
          RequirementsDataCollector().getEventLogs,
          RequirementsDataCollector().getInitializationPolicies,
          RequirementsDataCollector().getAutoUpdates,
          RequirementsDataCollector().getSystemPrivileges,
          RequirementsDataCollector().getDownloadRestrictions,
          RequirementsDataCollector().getFirewallStates,
        ],
      );
      conn.close();
    });
  }
}
