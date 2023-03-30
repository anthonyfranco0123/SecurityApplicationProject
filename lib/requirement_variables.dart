class RequirementVariables {
  static int timeStamp = -1;
  static String deviceName = '';
  static String macAddress = '';
  static int maxPasswordAge = -1; //how old
  static int passwordHistory = -1; //how often password can be reused
  static int minPasswordLength = -1;
  static int maxPasswordLength = -1;
  static bool uppercaseChars = false; //if password requires upper
  static bool lowercaseChars = false;
  static bool specialChars = false;
  static bool eventLogs = false; //'check if logging is on'
  static int initializationPolicies = -1; //if driver can boot and doesn't have malware
  static int autoUpdates = -1; //windows is set to auto-update
  static int systemPrivileges = -1; //if download prevention is on
  static bool downloadRestrictions = false; //if restricted file is detected
  static int firewallStates = -1; //if all three firewalls are on
}