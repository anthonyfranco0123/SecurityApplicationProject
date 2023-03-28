import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions/download_restrictions_system_info.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions/download_restrictions_file_info_getter.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_security_application/navbar/easy_sidemenu.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_access.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_state_changer.dart';
import 'package:flutter_security_application/security_requirements/password_reset.dart';
import 'package:flutter_security_application/security_requirements/password_restrictions.dart';
import 'package:flutter_security_application/security_requirements/event_logs.dart';
import 'package:flutter_security_application/security_requirements/logging_tests.dart';
import 'package:flutter_security_application/security_requirements/initialization_policies.dart';
import 'package:flutter_security_application/security_requirements/auto_updates.dart';
import 'package:flutter_security_application/security_requirements/removable_devices.dart';
import 'package:flutter_security_application/security_requirements/system_privileges.dart';
import 'package:flutter_security_application/security_requirements/download_restrictions_requirement.dart';
import 'package:flutter_security_application/security_requirements/firewall_states_requirement.dart';
import 'package:flutter_security_application/security_requirements/firewall/firewall_initial_state.dart';
import 'package:mac_address/mac_address.dart';

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


  @override
  void initState() {
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
    if(_sideMenu.currentPage != 9) {
      DownloadRestrictionsSystemInfo().futureStringListToStringList(
          DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
              DownloadRestrictionsSystemInfo.userDownloadsPath,
              Platform.operatingSystem));
    }
    // if (_sideMenu.currentPage != 9) {
    //   _periodicallyUpdateDownloadRestrictions();
    // }
    _periodicallyUpdateDatabase();
    super.initState();
  }



  void _periodicallyUpdateDatabase() {
    // int currentFirewallStates = FirewallAccess().getFirewallStates();
    Timer.periodic(const Duration(seconds: 10), (timer) {
      setState(() {
        RequirementsDataSender().sendRequirementData();
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
    // bool isHovering = false;
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
                      'assets/Chip_Shield.svg',
                    ),
                  ),
                  if (sh > 720 && sw > 720)
                    Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: const Text(
                        "IPRO Security Application",
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
                                    "Admin Mode",
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
                                    "User Mode",
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
              SideMenuItem(
                priority: 3,
                title: 'Logging Tests',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.download),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Initialization Policies',
                onTap: (page, _) {
                  _sideMenu.changePage(page);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Auto Updates',
                onTap: (page, _) {
                  _sideMenu.changePage(5);
                },
                icon: const Icon(Icons.autorenew),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Removable Devices',
                onTap: (page, _) {
                  _sideMenu.changePage(6);
                },
                icon: const Icon(Icons.add_circle),
              ),
              SideMenuItem(
                priority: 7,
                title: 'System Privileges',
                onTap: (page, _) {
                  _sideMenu.changePage(7);
                },
                icon: const Icon(Icons.wallet),
              ),
              SideMenuItem(
                priority: 8,
                title: 'Installation Restrictions',
                onTap: (page, _) {
                  _sideMenu.changePage(8);
                },
                icon: const Icon(Icons.zoom_in),
              ),
              SideMenuItem(
                priority: 9,
                title: 'Firewall State',
                onTap: (page, _) {
                  _sideMenu.changePage(9);
                },
                icon: const Icon(Icons.qr_code),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _page,
              children: const [
                RequirementTwoWidget(),
                RequirementTwoWidget(),
                RequirementThreeWidget(),
                RequirementFourWidget(),
                RequirementFiveWidget(),
                RequirementSixWidget(),
                RequirementSevenWidget(),
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



