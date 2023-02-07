import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:win32_registry/win32_registry.dart';
import 'dart:async';
import 'package:system_info2/system_info2.dart';
import 'package:process_run/shell.dart';
import 'package:flutter_security_application/navbar/easy_sidemenu.dart';
import 'package:flutter_security_application/requirements/requirement_one.dart';
import 'package:flutter_security_application/requirements/requirement_two.dart';
/*import 'package:flutter_security_application/requirements/requirement_three.dart';
import 'package:flutter_security_application/requirements/requirement_four.dart';
import 'package:flutter_security_application/requirements/requirement_five.dart';
import 'package:flutter_security_application/requirements/requirement_six.dart';
import 'package:flutter_security_application/requirements/requirement_seven.dart';
import 'package:flutter_security_application/requirements/requirement_eight.dart';
import 'package:flutter_security_application/requirements/requirement_nine.dart';
import 'package:flutter_security_application/requirements/requirement_ten.dart';
*/

class VerticalNavigationBar extends StatefulWidget {
  const VerticalNavigationBar({Key? key, required this.title})
      : super(key: key);

  final String title;

  @override
  State<VerticalNavigationBar> createState() => _VerticalNavigationBarState();
}

class _VerticalNavigationBarState extends State<VerticalNavigationBar> {

  void firewallState() {
    final key1 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\StandardProfile');
    final privateFirewall = key1.getValueAsInt('EnableFirewall');
    if (privateFirewall != null) {
      if (privateFirewall == 1) {
        print('Private firewall state: on');
      }
      else {
        print('Private firewall state: off');
      }
    }

    final key2 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\PublicProfile');
    final publicFirewall = key2.getValueAsInt('EnableFirewall');
    if (publicFirewall != null) {
      if (publicFirewall == 1) {
        print('Public firewall state: on');
      }
      else {
        print('Public firewall state: off');
      }
    }

    final key3 = Registry.openPath(RegistryHive.localMachine,
        path: r'SYSTEM\CurrentControlSet\Services\SharedAccess\Parameters\FirewallPolicy\DomainProfile');
    final domainFirewall = key3.getValueAsInt('EnableFirewall');
    if (domainFirewall != null) {
      if (domainFirewall == 1) {
        print('Domain firewall state: on');
      }
      else {
        print('Domain firewall state: off');
      }
    }
  }
  PageController page = PageController();
  SideMenuController sideMenu = SideMenuController();
  @override
  void initState() {
    sideMenu.addListener((p0) {
      page.jumpToPage(p0);
    });
    super.initState();
  }

  List<Widget> _buildScreens() {
    return [
      const RequirementOneWidget(),
      // MainScreen(
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
      // ObjectDetectionWidget(
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
      // MainScreen(
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
      // MainScreen(
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
      // MainScreen(
      //   hideStatus: _hideNavBar,
      //   onScreenHideButtonPressed: () {
      //     setState(() {
      //       _hideNavBar = !_hideNavBar;
      //     });
      //   },
      // ),
    ];
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
            controller: sideMenu,
            style: SideMenuStyle(
              // showTooltip: false,
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
              // backgroundColor: Color.fromARGB(255, 79, 117, 134),
              // backgroundColor: Colors.deepPurple[800],
              backgroundColor: const Color(0xFF0f0530),
            ),
            // title: Image.asset('assets/Application_Logo.png')
            title: Container(
              margin: const EdgeInsets.only(top: 14),
              alignment: Alignment.center,
              height: sh * 0.15,
              width: sw * 0.15,
              child: Column(
                children: <Widget>[
                  SvgPicture.asset('assets/Chip_Shield.svg',
                  colorBlendMode: BlendMode.softLight,),
                  if(sw>sh) const Text(
                    "IPRO Security Application",
                    style: TextStyle(
                        color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // footer: const Padding(
            //   padding: EdgeInsets.all(8.0),
            //   child: Text(
            //     'mohada',
            //     style: TextStyle(fontSize: 15),
            //   ),
            // ),
            items: [
              SideMenuItem(
                priority: 0,
                title: 'Password Resets',
                onTap: (page, _) {
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.home),
                badgeContent: const Text(
                  '3',
                  style: TextStyle(color: Colors.white),
                ),
                tooltipContent: "This is a tooltip for Dashboard item",
              ),
              SideMenuItem(
                priority: 1,
                title: 'Password Restrictions',
                onTap: (page, _) {
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.supervisor_account),
              ),
              SideMenuItem(
                priority: 2,
                title: 'Event Logs',
                onTap: (page, _) {
                  sideMenu.changePage(page);
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
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.download),
              ),
              SideMenuItem(
                priority: 4,
                title: 'Initialization Policies',
                onTap: (page, _) {
                  sideMenu.changePage(page);
                },
                icon: const Icon(Icons.settings),
              ),
              SideMenuItem(
                priority: 5,
                title: 'Auto Updates',
                onTap:(page, _){
                  sideMenu.changePage(5);
                },
                icon: const Icon(Icons.image_rounded),
              ),
              SideMenuItem(
                priority: 6,
                title: 'Removable Devices',
                onTap:(page, _){
                  sideMenu.changePage(6);
                },
              ),
              SideMenuItem(
                priority: 7,
                title: 'System Privileges',
                onTap:(page, _){
                  sideMenu.changePage(7);
                },
              ),
              SideMenuItem(
                priority: 8,
                title: 'Installation Restrictions',
                onTap:(page, _){
                  sideMenu.changePage(8);
                },
              ),
              SideMenuItem(
                priority: 9,
                title: 'Firewall State',
                onTap:(page, _){
                  firewallState();
                  sideMenu.changePage(9);
                },
              ),
              const SideMenuItem(
                priority: 10,
                title: 'Exit',
                icon: Icon(Icons.exit_to_app),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: page,
              children: const [
                RequirementOneWidget(),
                RequirementTwoWidget(),
                /*RequirementThreeWidget(),
                RequirementFourWidget(),
                RequirementFiveWidget(),
                RequirementSixWidget(),
                RequirementSevenWidget(),
                RequirementEightWidget(),
                RequirementNineWidget(),
                RequirementTenWidget(),*/
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Dashboard',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Users',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Files',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Download',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Settings',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Only Title',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
                // Container(
                //   color: Colors.white,
                //   child: const Center(
                //     child: Text(
                //       'Only Icon',
                //       style: TextStyle(fontSize: 35),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
