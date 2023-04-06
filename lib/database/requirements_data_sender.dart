import '../requirement_variables.dart';
import 'mysql.dart';

class RequirementsDataSender {
  Future<void> sendRequirementData(
      ) async {
    var db = Mysql();
    try {
      var conn = await db.getConnection();
      await conn.query(
        'insert into user_compliances (device_name, mac_address, timestamp, password_restriction, password_expiration, event_logs, auto_updates, system_privilege, installation_restrictions, firewall) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)',
        [
          RequirementVariables.deviceName,
          RequirementVariables.macAddress,
          RequirementVariables.timeStamp,
          RequirementVariables.maxPasswordAge,
          RequirementVariables.passwordHistory,
          RequirementVariables.eventLogs,
          RequirementVariables.autoUpdates,
          RequirementVariables.systemPrivileges,
          RequirementVariables.downloadRestrictions,
          RequirementVariables.firewallStates,
        ],
      );
      conn.close();
    } catch (e) {
      print('Error: $e');
    }
  }
}