import '../requirment_variables.dart';
import 'mysql.dart';

class RequirementsDataSender {
  Future<void> sendRequirementData(
  ) async {
    var db = Mysql();
    await db.getConnection().then((conn) async {
      await conn.query(
        'insert into user_compliances_test (password_reset, password_restrictions, event_logs, initialization_policies, auto_updates, system_privileges, download_restrictions, firewall_states) values (?, ?, ?, ?, ?, ?, ?, ?)',
        [
          //RequirementVariables.passwordReset,
          //RequirementVariables.passwordRestrictions,
          RequirementVariables.eventLogs,
          RequirementVariables.initializationPolicies,
          RequirementVariables.autoUpdates,
          RequirementVariables.systemPrivileges,
          RequirementVariables.downloadRestrictions,
          RequirementVariables.firewallStates,
        ],
      );
      conn.close();
    });
  }
}
