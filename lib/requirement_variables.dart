class RequirementVariables {
  static String timeStamp = '';
  static String deviceName = '';
  static String macAddress = '';
  static int maxPasswordAge = -1; //how old
  static int passwordHistory = -1; //how often password can be reused
  static int minPasswordLength = -1;
  static int maxPasswordLength = -1;
  static int uppercaseChars = -1; //if password requires upper
  static int lowercaseChars = -1;
  static int specialChars = -1;
  static int eventLogs = -1; //'check if logging is on'
  static int initializationPolicies = -1; //if driver can boot and doesn't have malware
  static int autoUpdates = -1; //windows is set to auto-update
  static int systemPrivileges = -1; //if download prevention is on
  static int downloadRestrictions = -1; //if restricted file is detected
  static int firewallStates = -1; //if all three firewalls are on

  static int currentPasswordReset = -1;
  static int currentPasswordRestrictions = -1;
  static int currentEventLogs = 1;
  static int currentInitializationPolicies = -1;
  static int currentAutoUpdates = -1;
  static int currentSystemPrivileges = -1;
  static int currentInstallationRestrictions = -1;
  static int currentFirewallState = -1;

  static int initialPasswordReset = -1;
  static int initialPasswordRestrictions = -1;
  static int initialEventLogs = 1;
  static int initialInitializationPolicies = -1;
  static int initialAutoUpdates = -1;
  static int initialSystemPrivileges = -1;
  static int initialInstallationRestrictions = -1;
  static int initialFirewallState = -1;
}