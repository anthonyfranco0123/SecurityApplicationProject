import 'dart:io';

import 'package:flutter/material.dart';

import 'download_restrictions/downloads_getter.dart';

class RequirementNineWidget extends StatefulWidget {
  const RequirementNineWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementNineWidget> createState() => RequirementNineWidgetState();
}

class RequirementNineWidgetState extends State<RequirementNineWidget> {
  @override
  void initState() {
    super.initState();
  }

  Widget getDownloadsAsTextWidgets(List<String> strings) {
    return Row(children: strings.map((item) => Text(item)).toList());
  }

  @override
  Widget build(BuildContext context) {
    // DownloadsGetter()
    //     .downloadsList(getHomeDirectory(), platformOperatingSystem);
    // DownloadsGetter().getAllFilesWithExtension(getHomeDirectory(), platformOperatingSystem);
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.1, 0.5, 0.9],
            colors: [
              Color(0xFF0f0530),
              Color(0xFF5e48ab),
              Color(0xFF0f0530),
            ],
          ),
        ),
        child: Column(
          children: const [
            Text(
              'Req nine',
              style: TextStyle(
                fontSize: 35,
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            // getDownloadsAsTextWidgets(DownloadsGetter.getFilesList()),
          ],
        ),
      ),
    );
  }
}
