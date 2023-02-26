import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_security_application/admin/privilege_level_button.dart';
import 'package:flutter_security_application/navbar/easy_sidemenu.dart';
import 'package:flutter_security_application/securityrequirements/firewall/firewall_access.dart';
import 'package:flutter_security_application/securityrequirements/firewall/firewall_state_changer.dart';
import 'package:flutter_security_application/securityrequirements/requirement_one.dart';
import 'package:flutter_security_application/securityrequirements/requirement_two.dart';
import 'package:flutter_security_application/securityrequirements/requirement_three.dart';
import 'package:flutter_security_application/securityrequirements/requirement_four.dart';
import 'package:flutter_security_application/securityrequirements/requirement_five.dart';
import 'package:flutter_security_application/securityrequirements/requirement_six.dart';
import 'package:flutter_security_application/securityrequirements/requirement_seven.dart';
import 'package:flutter_security_application/securityrequirements/requirement_eight.dart';
import 'package:flutter_security_application/securityrequirements/requirement_nine.dart';
import 'package:flutter_security_application/securityrequirements/firewall_states_requirement.dart';
import 'package:flutter_security_application/securityrequirements/firewall/firewall_initial_state.dart';

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
    super.initState();
  }

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
                      child: const PrivilegeLevelButton(),
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
                RequirementOneWidget(),
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
