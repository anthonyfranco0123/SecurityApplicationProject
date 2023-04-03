import 'dart:async';
import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_security_application/requirement_variables.dart';
import 'package:flutter_security_application/security_requirements/auto_updates/auto_updates_state.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions/download_restrictions_system_info.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions/download_restrictions_file_info_getter.dart';
import 'package:flutter_security_application/security_requirements/initialization_policies/intialization_policies_state.dart';
import 'package:flutter_security_application/security_requirements/password_reset.dart';
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
import 'package:mac_address/mac_address.dart';
import 'package:windows_system_info/windows_system_info.dart';

import 'admin/admin_state.dart';
import 'admin/privilege_level_changer.dart';
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

  @override
  void initState() {
    initInfo();
    _sideMenu.addListener((p0) {
      _page.jumpToPage(p0);
    });
    FirewallInitialState.initialFirewallStates =
        FirewallAccess().getFirewallStates();
    if (_sideMenu.currentPage != 10) {
      _periodicallyUpdateCurrentFirewallStatus();
    }
    DownloadRestrictionsSystemInfo.userPath =
        DownloadRestrictionsSystemInfo().getHomeDirectory();
    DownloadRestrictionsSystemInfo.userDownloadsPath =
        '${DownloadRestrictionsSystemInfo.userPath}' '\\Downloads\\';
    if (_sideMenu.currentPage != 9) {
      DownloadRestrictionsSystemInfo().futureStringListToStringList(
          DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
              DownloadRestrictionsSystemInfo.userDownloadsPath,
              Platform.operatingSystem));
    }
    if (_sideMenu.currentPage != 6) {
      // _periodicallyUpdateDownloadRestrictions();
    }
    AutoUpdatesState().futureIntToInt();
    InitializationPoliciesState().futureIntToInt();
    setSound();
    _periodicallyUpdateDatabase();
    super.initState();
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
        // print(RequirementVariables.deviceName);
        // print(RequirementVariables.macAddress);
      });
    }
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await GetMac.macAddress;
    } on PlatformException {
      platformVersion = 'Failed to get Device MAC Address.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      RequirementVariables.macAddress = platformVersion;
      print(RequirementVariables.macAddress);
    });
  }

  void _periodicallyUpdateDatabase() {
    // int currentFirewallStates = FirewallAccess().getFirewallStates();
    RequirementVariables.timeStamp = DateTime.now().millisecondsSinceEpoch;
    Timer.periodic(const Duration(seconds: 10), (timer) {
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
      playSound();
      setState(() {
        // RequirementsDataSender().sendRequirementData();
      });
    });
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
