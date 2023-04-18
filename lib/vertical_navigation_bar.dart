import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import 'package:flutter_security_application/security_requirements/auto_updates/auto_updates_state.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions/download_restrictions_system_info.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions/download_restrictions_file_info_getter.dart';
import 'package:flutter_security_application/security_requirements/event_logs/event_logs_access.dart';
import 'package:flutter_security_application/security_requirements/event_logs/event_logs_initial_state.dart';
import 'package:flutter_security_application/security_requirements/initialization_policies/initialization_policies_state.dart';
import 'package:flutter_security_application/security_requirements/password/password_reset_initial_states.dart';
import 'package:flutter_security_application/security_requirements/password/password_restrictions_initial_states.dart';
import 'package:flutter_security_application/security_requirements/password/registry_access.dart';
import 'package:flutter_security_application/security_requirements/password_reset.dart';
import 'package:flutter_security_application/security_requirements/requirement_variables_logic.dart';
import 'package:flutter_security_application/security_requirements/system_privileges/system_privileges_initial_state.dart';
import 'package:flutter_security_application/security_requirements/system_privileges/system_privileges_state.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_security_application/navbar/easy_sidemenu.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_access.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_state_changer.dart';
import 'package:flutter_security_application/security_requirements/password_restrictions.dart';
import 'package:flutter_security_application/security_requirements/event_logs.dart';
// import 'package:flutter_security_application/security_requirements/logging_tests.dart';
import 'package:flutter_security_application/security_requirements/initialization_policies.dart';
import 'package:flutter_security_application/security_requirements/auto_updates.dart';
// import 'package:flutter_security_application/security_requirements/removable_devices.dart';
import 'package:flutter_security_application/security_requirements/system_privileges.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions_requirement.dart';
import 'package:flutter_security_application/security_requirements/firewall_states_requirement.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_initial_state.dart';
import 'package:local_notifier/local_notifier.dart';
import 'package:windows_system_info/windows_system_info.dart';
import 'admin/admin_state.dart';
import 'admin/privilege_level_changer.dart';
import 'database/requirements_data_sender.dart';
import 'hover_builder.dart';

class VerticalNavigationBar extends StatefulWidget {
  const VerticalNavigationBar({super.key});

  @override
  State<VerticalNavigationBar> createState() => _VerticalNavigationBarState();
}

class _VerticalNavigationBarState extends State<VerticalNavigationBar> {
  final PageController _page = PageController();
  final SideMenuController _sideMenu = SideMenuController();
  final player = AudioPlayer();
  LocalNotification notification = LocalNotification(title: '');
  String stringCurrentState = '';

  @override
  void initState() {
    initInfo();
    setUpNotifier();
    _sideMenu.addListener((p0) {
      _page.jumpToPage(p0);
    });
    FirewallInitialState.initialFirewallStates =
        FirewallAccess().getFirewallStates();
    if (_sideMenu.currentPage != 7) {
      _periodicallyUpdateCurrentFirewallStatus();
    }
    DownloadRestrictionsSystemInfo.userPath =
        DownloadRestrictionsSystemInfo().getHomeDirectory();
    DownloadRestrictionsSystemInfo.userDownloadsPath =
        '${DownloadRestrictionsSystemInfo.userPath}' '\\Downloads\\';
    if (_sideMenu.currentPage != 6) {
      DownloadRestrictionsSystemInfo().futureStringListToStringList(
          DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
              DownloadRestrictionsSystemInfo.userDownloadsPath,
              Platform.operatingSystem));
      DownloadRestrictionsSystemInfo.initialFilesList = DownloadRestrictionsSystemInfo.filesList;
    }
    // if (_sideMenu.currentPage != 6) {
      // _periodicallyUpdateDownloadRestrictions();
    // }
    InitializationPoliciesState().setBootStartState();
    RequirementVariables.initializationPolicies = InitializationPoliciesState.bootStart;
    //AutoUpdatesState().setInitialAutoUpdatesState();
    //RequirementVariables.autoUpdates = AutoUpdatesState.privateSUpdates;
    SystemPrivilegesInitialState.initialSystemPrivilegesState = SystemPrivilegesState().getSystemPrivilegeKey();
    PasswordResetInitialStates.initialMaxAge = RegistryAccess.getPwAge();
    PasswordResetInitialStates.initialPwHist = RegistryAccess.getPwHist();
    PasswordRestrictionsInitialStates.initialMinPwLen = RegistryAccess.getMinPwLen();
    PasswordRestrictionsInitialStates.initialMaxPwLen = RegistryAccess.getMaxPwLen();
    PasswordRestrictionsInitialStates.initialUpper = RegistryAccess.getUpperCaseSetting();
    PasswordRestrictionsInitialStates.initialLower = RegistryAccess.getLowerCaseSetting();
    PasswordRestrictionsInitialStates.initialSpecial = RegistryAccess.getSpecialCharSetting();
    eventLogsStringOutput();
    setSound();
    notificationCreation();
    _periodicallyUpdateDatabase();
    DownloadRestrictionsSystemInfo.targetPath = '${DownloadRestrictionsSystemInfo.userPath}' '\\Desktop\\Potential_Threats\\';
    DownloadRestrictionsFileInfoGetter().directoryExists(DownloadRestrictionsSystemInfo.targetPath);
    if(DownloadRestrictionsSystemInfo.exists) {
      DownloadRestrictionsFileInfoGetter().createDirectory();
      DownloadRestrictionsSystemInfo.exists = true;
    }
    //Comment
    // RawKeyboardListener(
    //   focusNode: FocusNode(),
    //   onKey: (event) {
    //     if (event.logicalKey.keyLabel == 'Arrow Down') {
    //       playSound();
    //     }
    //   },
    //   child: const Text(''),
    // );
    setInitialVariablesForComplianceCheck();
    super.initState();
  }

  eventLogsStringOutput() async {
    EventLogsAccess().futureStringToString().then((value){ setState(() {
      stringCurrentState=value;
      eventLogsState();
    });});
  }

  eventLogsState() {
    if (stringCurrentState.contains("STOPPED")) {
      EventLogsInitialState.initialEventLogsState = false;
    } else if (stringCurrentState.contains("RUNNING")) {
      EventLogsInitialState.initialEventLogsState = true;
    }
    // else {
    //   EventLogsInitialState.initialEventLogsState = false;
    // }
  }

  Future<void> setUpNotifier() async {
    // Add in main method.
    await localNotifier.setup(
      appName: 'local_notifier_example',
      // The parameter shortcutPolicy only works on Windows
      shortcutPolicy: ShortcutPolicy.requireCreate,
    );
  }

  void notificationCreation() {
    notification = LocalNotification(
      title: "local_notifier_example",
      body: "hello flutter!",
    );
    notification.onShow = () {
    };
  }

  void onCloseReason() {
    notification.onClose = (closeReason) {
      // Only supported on windows, other platforms closeReason is always unknown.
      switch (closeReason) {
        case LocalNotificationCloseReason.userCanceled:
        // do something
          break;
        case LocalNotificationCloseReason.timedOut:
        // do something
          break;
        default:
      }
    };
    notification.onClick = () {
      print('onClick ${notification.identifier}');
    };
    notification.onClickAction = (actionIndex) {
      print('onClickAction ${notification.identifier} - $actionIndex');
    };
  }

  Future<void> setSound() async {
    await player.setSource(AssetSource('Goose_Honk.mp3'));
  }

  void playSound() {
    player.play(AssetSource('Goose_Honk.mp3'));
  }

  Future<void> initInfo() async {
    await WindowsSystemInfo.initWindowsInfo();
    if (await WindowsSystemInfo.isInitilized) {
      setState(() {
        RequirementVariables.deviceName = WindowsSystemInfo.deviceName;
        RequirementVariables.macAddress = WindowsSystemInfo.network[1].mac;
      });
    }
  }

  void _periodicallyUpdateDatabase() {
    // RequirementVariables.timeStamp = DateTime.now().toString();
    Timer.periodic(const Duration(seconds: 20), (timer) {
      setCurrentVariablesForComplianceCheck();
      // print('***');
      // print(RequirementVariables.timeStamp);
      // print(RequirementVariables.deviceName);
      // print(RequirementVariables.macAddress);
      // print(RequirementVariables.maxPasswordAge);
      // print(RequirementVariables.passwordHistory);
      // print(RequirementVariables.minPasswordLength);
      // print(RequirementVariables.maxPasswordLength);
      // print(RequirementVariables.uppercaseChars);
      // print(RequirementVariables.lowercaseChars);
      // print(RequirementVariables.specialChars);
      // print(RequirementVariables.eventLogs);
      // print(RequirementVariables.initializationPolicies);
      // print(RequirementVariables.autoUpdates);
      // print(RequirementVariables.systemPrivileges);
      // print(RequirementVariables.downloadRestrictions);
      // print(RequirementVariables.firewallStates);
      // print('----');
      var rng = Random();
      int num = rng.nextInt(10);
      if(num%2 == 0) {
        playSound();
      }
      onCloseReason();
      // notification.show();
      // print('+++');
      // print(RequirementVariables.deviceName);
      // print(RequirementVariables.macAddress);
      // print(DateTime.now().toString());
      // print(passwordReset());
      // print(passwordRestrictions());
      // print(eventLogs());
      // print(initializationPolicies());
      // print(autoUpdates());
      // print(systemPrivileges());
      // print(installationRestrictions());
      // print(firewallState());
      // print('///');
      setState(() {
        // RequirementsDataSender().sendRequirementData();
        RequirementsDataSender().sendRequirementComplianceData(RequirementVariables.deviceName, RequirementVariables.macAddress, DateTime.now().toString(), passwordReset(), passwordRestrictions(), eventLogs(), initializationPolicies(), autoUpdates(), systemPrivileges(), installationRestrictions(), firewallState());
      });
    });
  }

  setInitialVariablesForComplianceCheck() {
    RequirementVariablesLogic().setInitialPasswordReset();
    RequirementVariablesLogic().setInitialPasswordRestrictions();
    RequirementVariablesLogic().setInitialEventLogs();
    RequirementVariablesLogic().setInitialInitializationPolicies();
    RequirementVariablesLogic().setInitialAutoUpdates();
    RequirementVariablesLogic().setInitialSystemPrivileges();
    RequirementVariablesLogic().setInitialInstallationRestrictions();
    RequirementVariablesLogic().setInitialFirewallState();
  }

  setCurrentVariablesForComplianceCheck() {
    RequirementVariablesLogic().setCurrentPasswordReset();
    RequirementVariablesLogic().setCurrentPasswordRestrictions();
    RequirementVariablesLogic().setCurrentEventLogs();
    RequirementVariablesLogic().setCurrentInitializationPolicies();
    RequirementVariablesLogic().setCurrentAutoUpdates();
    RequirementVariablesLogic().setCurrentSystemPrivileges();
    RequirementVariablesLogic().setCurrentInstallationRestrictions();
    RequirementVariablesLogic().setCurrentFirewallState();
  }

  passwordReset() {
    if((RequirementVariables.initialPasswordReset == 1) && (RequirementVariables.currentPasswordReset == 1)) {
      return 1;
    } else if((RequirementVariables.initialPasswordReset == 3) && (RequirementVariables.currentPasswordReset == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  passwordRestrictions() {
    if((RequirementVariables.initialPasswordRestrictions == 1) && (RequirementVariables.currentPasswordRestrictions == 1)) {
      return 1;
    } else if((RequirementVariables.initialPasswordRestrictions == 3) && (RequirementVariables.currentPasswordRestrictions == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  eventLogs() {
    if((RequirementVariables.initialEventLogs == 1) && (RequirementVariables.currentEventLogs == 1)) {
      return 1;
    } else if((RequirementVariables.initialEventLogs == 3) && (RequirementVariables.currentEventLogs == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  initializationPolicies() {
    if((RequirementVariables.initialInitializationPolicies == 1) && (RequirementVariables.currentInitializationPolicies == 1)) {
      return 1;
    } else if((RequirementVariables.initialInitializationPolicies == 3) && (RequirementVariables.currentInitializationPolicies == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  autoUpdates() {
    if((RequirementVariables.initialAutoUpdates == 1) && (RequirementVariables.currentAutoUpdates == 1)) {
      return 1;
    } else if((RequirementVariables.initialAutoUpdates == 3) && (RequirementVariables.currentAutoUpdates == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  systemPrivileges() {
    if((RequirementVariables.initialSystemPrivileges == 1) && (RequirementVariables.currentSystemPrivileges == 1)) {
      return 1;
    } else if((RequirementVariables.initialSystemPrivileges == 3) && (RequirementVariables.currentSystemPrivileges == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  installationRestrictions() {
    if((RequirementVariables.initialInstallationRestrictions == 1) && (RequirementVariables.currentInstallationRestrictions == 1)) {
      return 1;
    } else if((RequirementVariables.initialInstallationRestrictions == 3) && (RequirementVariables.currentInstallationRestrictions == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  firewallState() {
    if((RequirementVariables.initialFirewallState == 1) && (RequirementVariables.currentFirewallState == 1)) {
      return 1;
    } else if((RequirementVariables.initialFirewallState == 3) && (RequirementVariables.currentFirewallState == 1)) {
      return 2;
    } else {
      return 0;
    }
  }

  // void _periodicallyUpdateDownloadRestrictions() {
  //     Timer.periodic(const Duration(seconds: 4, milliseconds: 3), (timer) {
  //       setState(() {
  //         if (DownloadRestrictionsSystemInfo.filesList.isNotEmpty) {
  //           DownloadRestrictionsSystemInfo().futureStringListToStringList(
  //               DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
  //                   DownloadRestrictionsSystemInfo.userDownloadsPath,
  //                   Platform.operatingSystem));
  //         }
  //       });
  //     });
  // }

  void _periodicallyUpdateCurrentFirewallStatus() {
    int currentFirewallStates = FirewallAccess().getFirewallStates();
    Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (currentFirewallStates != 9) {
          FirewallStateChanger().allFirewallStatesOn();
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SideMenu(
            controller: _sideMenu,
            style: SideMenuStyle(
              displayMode: SideMenuDisplayMode.auto,
              hoverColor: Colors.black12,
              selectedColor: Colors.black,
              selectedTitleTextStyle: const TextStyle(color: Colors.white),
              unselectedTitleTextStyle: const TextStyle(color: Colors.white),
              selectedIconColor: Colors.white,
              unselectedIconColor: Colors.white,
              decoration: const BoxDecoration(
                  // borderRadius: BorderRadius.all(Radius.circular(8)),
                  boxShadow: [
                    BoxShadow(
                      color: Color.fromARGB(255, 79, 117, 134),
                      spreadRadius: 1,
                      blurRadius: 10,
                      offset: Offset(0, 0), // changes position of shadow
                    ),
                  ]),
              backgroundColor: const Color(0xFF0f0530),
            ),
            title: Container(
              margin: const EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              height: sh * 0.15,
              width: sw * 0.15,
              child: Column(
                children: <Widget>[
                  Expanded(
                    child: SvgPicture.asset(
                      'assets/sgicon.svg',
                    ),
                  ),
                  if (sh > 720 && sw > 720)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "CyberGoose",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.all(2),
                      child: HoverBuilder(builder: (isHovering) {
                        return InkWell(
                          onTap: () {
                            PrivilegeLevelChanger()
                                .displayTextInputDialog(context);
                          },
                          child: AdminState.adminState
                              ? Container(
                                  decoration: BoxDecoration(
                                    color: isHovering ? Colors.black12 : null,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 2, right: 8, bottom: 2),
                                  child: const Text(
                                    "CyberGoose Admin",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              : Container(
                                  decoration: BoxDecoration(
                                    color: isHovering ? Colors.black12 : null,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  padding: const EdgeInsets.only(
                                      left: 8, top: 2, right: 8, bottom: 2),
                                  child: const Text(
                                    "CyberGoose",
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                        );
                      }),
                    ),
                  ),
                ],
              ),
            ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Password Reset',
                onTap: (page, _) {
                  //RegistryAccess.getPasswordPolicy();
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.password),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              SideMenuItem(
                priority: 1,
                title: 'Password Restrictions',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Event Logs',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.file_copy_rounded),
                trailing: Container(
                    decoration: const BoxDecoration(
                        color: Colors.amber,
                        borderRadius: BorderRadius.all(Radius.circular(6))),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 6.0, vertical: 3),
                      child: Text(
                        'New',
                        style: TextStyle(fontSize: 11, color: Colors.grey[800]),
                      ),
                    )),
              ),
              // SideMenuItem(
              //   priority: 3,
              //   title: 'Logging Tests',
              //   onTap: (page, _) {
              //     _sideMenu.changePage(page);
              //   },
              //   icon: const Icon(Icons.download),
              // ),
              SideMenuItem(
                priority: 3,
                title: 'Initialization Policies',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Auto Updates',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.autorenew),
              ),
              // SideMenuItem(
              //   priority: 6,
              //   title: 'Removable Devices',
              //   onTap: (page, _) {
              //     _sideMenu.changePage(6);
              //   },
              //   icon: const Icon(Icons.add_circle),
              // ),
              SideMenuItem(
                priority: 5,
                title: 'System Privileges',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.wallet),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Installation Restrictions',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.zoom_in),
              ),
              SideMenuItem(
                priority: 7,
                title: 'Firewall State',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.qr_code),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _page,
              children: const [
                RequirementOneWidget(),
                RequirementTwoWidget(),
                RequirementThreeWidget(),
                // RequirementFourWidget(),
                RequirementFiveWidget(),
                RequirementSixWidget(),
                // RequirementSevenWidget(),
                RequirementEightWidget(),
                RequirementNineWidget(),
                FirewallStatesRequirementWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
