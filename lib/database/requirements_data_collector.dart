class RequirementsDataCollector {
  String _passwordReset = '';
  String _passwordRestrictions = '';
  bool _eventLogs = false;
  String _initializationPolicies = '';
  int _autoUpdates = -1;
  String _systemPrivileges = '';
  String _downloadRestrictions = '';
  int _firewallStates = -1;

  // String deviceName,
  //     String macAddress,
  // String timestamp,
  //     String password,
  // int passwordRestriction,
  //     int passwordExpiration,
  // int autoUpdates,
  //     String systemPrivilege,
  // int firewall

  set passwordReset(String passwordReset) {
    _passwordReset = passwordReset;
  }

  set passwordRestrictions(String passwordRestrictions) {
    _passwordRestrictions = passwordRestrictions;
  }

  set eventLogs(bool eventLogs) {
    _eventLogs = eventLogs;
  }

  set initializationPolicies(String initializationPolicies) {
    _initializationPolicies = initializationPolicies;
  }

  set autoUpdates(int autoUpdates) {
    _autoUpdates = autoUpdates;
  }

  set systemPrivileges(String systemPrivileges) {
    _systemPrivileges = systemPrivileges;
  }

  set downloadRestrictions(String downloadRestrictions) {
    _downloadRestrictions = downloadRestrictions;
  }

  set firewallStates(int firewallStates) {
    _firewallStates = firewallStates;
  }
}