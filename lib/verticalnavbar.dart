import 'package:flutter/material.dart';
import 'navbar/vertical_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VerticalNavBar extends StatefulWidget {
  const VerticalNavBar({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<VerticalNavBar> createState() => _VerticalNavBarState();
}

final pageController = PageController(
    initialPage: 0,
    keepPage: true
);

class _VerticalNavBarState extends State<VerticalNavBar> {
  final navItems = [
    SideNavigationItem(icon: FontAwesomeIcons.calendarCheck, title: "New task"),
    SideNavigationItem(icon: FontAwesomeIcons.calendarDays, title: "Personal task"),
    SideNavigationItem(icon: FontAwesomeIcons.fileLines, title: "Personal document"),
    SideNavigationItem(icon: FontAwesomeIcons.calendar, title: "Company task"),
    SideNavigationItem(icon: FontAwesomeIcons.circleArrowRight, title: "Options")
  ];
  final initialTab = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: <Widget>[
          SideNavigation(
            navItems: this.navItems,
            itemSelected: (index) {
              pageController.animateToPage(
                  index,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.linear
              );
            },
            initialIndex: 0,
            actions: <Widget>[
              //add some action button here
            ],
          ),
          Expanded(
            child: PageView.builder(
              itemCount: 5,
              controller: pageController,
              scrollDirection: Axis.vertical,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                    color: Colors.blueGrey.withOpacity(0.1),
                    child: Center(
                      child: Text("Page " + index.toString()),
                    )
                );
              },
            ),
          )
        ],
      ),
    );
  }
}