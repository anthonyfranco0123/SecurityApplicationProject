import 'package:flutter/material.dart';
import 'navbar/vertical_navigation_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

final pageController = PageController(
    initialPage: 0,
    keepPage: true
);


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

//This line is for a minor change to reflect
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
            itemSelected: (index){
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
              itemBuilder: (context, index){
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