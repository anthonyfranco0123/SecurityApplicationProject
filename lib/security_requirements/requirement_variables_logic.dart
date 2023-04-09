import 'package:flutter_security_application/security_requirements/password/password_reset_initial_states.dart';
import 'package:flutter_security_application/security_requirements/password/password_restrictions_initial_states.dart';
import 'package:flutter_security_application/security_requirements/system_privileges/system_privileges_initial_state.dart';

import '../requirement_variables.dart';
import 'auto_updates/auto_updates_state.dart';
import 'download_restrictions/download_restrictions_system_info.dart';
import 'event_logs/event_logs_initial_state.dart';
import 'firewall/firewall_initial_state.dart';
import 'initialization_policies/initialization_policies_state.dart';

class RequirementVariablesLogic {
  setInitialPasswordReset() {
    if ((PasswordResetInitialStates.initialMaxAge == 90) &&
        (PasswordResetInitialStates.initialPwHist == 10)) {
      RequirementVariables.initialPasswordReset = 1;
    } else {
      RequirementVariables.initialPasswordReset = 3;
    }
  }

  setInitialPasswordRestrictions() {
    if ((PasswordRestrictionsInitialStates.initialMinPwLen == 8) &&
        (PasswordRestrictionsInitialStates.initialMaxPwLen == 32) &&
        (PasswordRestrictionsInitialStates.initialUpper == 1) &&
        (PasswordRestrictionsInitialStates.initialLower == 1) &&
        (PasswordRestrictionsInitialStates.initialSpecial == 1)) {
      RequirementVariables.initialPasswordRestrictions = 1;
    } else {
      RequirementVariables.initialPasswordRestrictions = 3;
    }
  }

  setInitialEventLogs() {
    if (EventLogsInitialState.initialEventLogsState) {
      RequirementVariables.initialEventLogs = 1;
    } else {
      RequirementVariables.initialEventLogs = 3;
    }
  }

  setInitialInitializationPolicies() {
    if (InitializationPoliciesState.bootStart == 8) {
      RequirementVariables.initialInitializationPolicies = 1;
    } else {
      RequirementVariables.initialInitializationPolicies = 3;
    }
  }

  setInitialAutoUpdates() {
    if (AutoUpdatesState.privateSUpdates == 0) {
      RequirementVariables.initialAutoUpdates = 1;
    } else {
      RequirementVariables.initialAutoUpdates = 3;
    }
  }

  setInitialSystemPrivileges() {
    if (SystemPrivilegesInitialState.initialSystemPrivilegesState == 1) {
      RequirementVariables.initialSystemPrivileges = 1;
    } else {
      RequirementVariables.initialSystemPrivileges = 3;
    }
  }

  setInitialInstallationRestrictions() {
    if (DownloadRestrictionsSystemInfo.initialFilesList.isEmpty) {
      RequirementVariables.initialInstallationRestrictions = 1;
    } else {
      RequirementVariables.initialInstallationRestrictions = 3;
    }
  }

  setInitialFirewallState() {
    if (FirewallInitialState.initialFirewallStates == 9) {
      RequirementVariables.initialFirewallState = 1;
    } else {
      RequirementVariables.initialFirewallState = 3;
    }
  }

  //Finish setting up the logic below
  setCurrentPasswordReset() {
    if ((PasswordResetInitialStates.initialMaxAge == 90) &&
        (PasswordResetInitialStates.initialPwHist == 10)) {
      RequirementVariables.currentPasswordReset = 1;
    } else {
      RequirementVariables.currentPasswordReset = 3;
    }
  }

  setCurrentPasswordRestrictions() {
    if ((PasswordRestrictionsInitialStates.initialMinPwLen == 8) &&
        (PasswordRestrictionsInitialStates.initialMaxPwLen == 32) &&
        (PasswordRestrictionsInitialStates.initialUpper == 1) &&
        (PasswordRestrictionsInitialStates.initialLower == 1) &&
        (PasswordRestrictionsInitialStates.initialSpecial == 1)) {
      RequirementVariables.currentPasswordRestrictions = 1;
    } else {
      RequirementVariables.currentPasswordRestrictions = 3;
    }
  }

  setCurrentEventLogs() {
    if (RequirementVariables.eventLogs) {
      RequirementVariables.currentEventLogs = 1;
    } else {
      RequirementVariables.currentEventLogs = 3;
    }
  }

  setCurrentInitializationPolicies() {
    if (RequirementVariables.initializationPolicies == 8) {
      RequirementVariables.currentInitializationPolicies = 1;
    } else {
      RequirementVariables.currentInitializationPolicies = 3;
    }
  }

  setCurrentAutoUpdates() {
    if (RequirementVariables.autoUpdates == 0) {
      RequirementVariables.currentAutoUpdates = 1;
    } else {
      RequirementVariables.currentAutoUpdates = 3;
    }
  }

  setCurrentSystemPrivileges() {
    if (RequirementVariables.systemPrivileges == 1) {
      RequirementVariables.currentSystemPrivileges = 1;
    } else {
      RequirementVariables.currentSystemPrivileges = 3;
    }
  }

  setCurrentInstallationRestrictions() {
    if (DownloadRestrictionsSystemInfo.filesList.isEmpty) {
      RequirementVariables.currentInstallationRestrictions = 1;
    } else {
      RequirementVariables.currentInstallationRestrictions = 3;
    }
  }

  setCurrentFirewallState() {
    if (RequirementVariables.firewallStates == 9) {
      RequirementVariables.currentFirewallState = 1;
    } else {
      RequirementVariables.currentFirewallState = 3;
    }
  }
}
