import '../requirement_variables.dart';
import 'mysql.dart';

class RequirementsDataSender {
  Future<void> sendRequirementData(
  ) async {
    var db = Mysql();
    await db.getConnection().then((conn) async {
      await conn.query(
        'insert into user_compliances_test (time_stamp, device_name, mac_address, max_password_age, password_history, min_password_length, max_password_length, uppercase_chars, lowercase_chars, special_chars, event_logs, initialization_policies, auto_updates, system_privileges, download_restrictions, firewall_states) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          RequirementVariables.timeStamp,
          RequirementVariables.deviceName,
          RequirementVariables.macAddress,
          RequirementVariables.maxPasswordAge,
          RequirementVariables.passwordHistory,
          RequirementVariables.minPasswordLength,
          RequirementVariables.maxPasswordLength,
          RequirementVariables.uppercaseChars,
          RequirementVariables.lowercaseChars,
          RequirementVariables.specialChars,
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
