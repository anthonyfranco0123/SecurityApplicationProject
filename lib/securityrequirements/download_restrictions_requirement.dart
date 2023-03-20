import 'dart:io';

import 'package:flutter/material.dart';

import 'download_restrictions/download_restrictions_file_info_getter.dart';
import 'download_restrictions/download_restrictions_system_info.dart';

class RequirementNineWidget extends StatefulWidget {
  const RequirementNineWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<RequirementNineWidget> createState() => RequirementNineWidgetState();
}

class RequirementNineWidgetState extends State<RequirementNineWidget>
    with AutomaticKeepAliveClientMixin {
  final platformOperatingSystem = Platform.operatingSystem;
  // List<String> filesList = [];
  // String userPath = '';
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // userPath = _getHomeDirectory();
    // DownloadsGetter().setDownloadsPathInfo(_getHomeDirectory(), platformOperatingSystem);
    super.initState();
  }

  @override
  void dispose() {
    // timer.cancel();
    super.dispose();
  }

  // String _getHomeDirectory() {
  //   switch (platformOperatingSystem) {
  //     case 'linux':
  //     case 'macos':
  //       return Platform.environment['HOME']!;
  //     case 'windows':
  //       return Platform.environment['USERPROFILE']!;
  //     case 'android':
  //       return '/storage/sdcard0';
  //     case 'ios':
  //     // iOS doesn't really have a home directory.
  //     case 'fuchsia':
  //     // I have no idea.
  //     default:
  //       return '';
  //   }
  // }

  // Future<void> _futureStringListToStringList(Future<List<String>> fsl) async {
  //   filesList = await fsl;
  // }

  String _restrictedFilesInfoText() {
    String restrictedFilesInfoText = '';
    if (DownloadRestrictionsSystemInfo.filesList.isEmpty) {
      restrictedFilesInfoText = 'No Risky Files Found In Your Downloads!';
    } else if (DownloadRestrictionsSystemInfo.filesList.isNotEmpty) {
      restrictedFilesInfoText =
          'Found ${DownloadRestrictionsSystemInfo.filesList.length} Risky Files In Your Downloads:';
    } else {
      restrictedFilesInfoText =
          'Error: Unable to determine filesList current state';
    }
    return restrictedFilesInfoText;
  }

  Text _textToDisplayForRestrictedFilesInfo() {
    Color c = Colors.yellow;
    // _periodicallyUpdateCurrentFirewallStatus();
    if (DownloadRestrictionsSystemInfo.filesList.isNotEmpty) {
      c = Colors.red;
    } else {
      c = Colors.white;
    }
    return Text(
      _restrictedFilesInfoText(),
      style: TextStyle(
        color: c,
        fontSize: 35,
      ),
      textAlign: TextAlign.center,
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    DownloadRestrictionsSystemInfo().futureStringListToStringList(
        DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
            DownloadRestrictionsSystemInfo.userDownloadsPath,
            platformOperatingSystem));
    print(DownloadRestrictionsSystemInfo.filesList);
    final sh = MediaQuery.of(context).size.height;
    final sw = MediaQuery.of(context).size.width;
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
        child: Center(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black38,
              borderRadius: BorderRadius.circular(4),
            ),
            padding: const EdgeInsets.all(4),
            // color: Colors.black38,
            width: sw * 0.6,
            height: sh * 0.6,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _textToDisplayForRestrictedFilesInfo(),
                  const Padding(padding: EdgeInsets.all(8.0)),
                  SizedBox(
                    width: sw * 0.4,
                    height: sh * 0.4,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          itemCount:
                              DownloadRestrictionsSystemInfo.filesList.length,
                          itemBuilder: (context, index) {
                            return Card(
                              // color: Colors.transparent,
                              shadowColor: Colors.transparent,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(2.75)),
                              child: ListTile(
                                leading: const Icon(
                                  Icons.file_present_rounded,
                                  color: Colors.red,
                                ),
                                title: Text(
                                  DownloadRestrictionsSystemInfo
                                      .filesList[index],
                                  style: const TextStyle(
                                      color: Colors.red, fontSize: 16),
                                  textAlign: TextAlign.left,
                                ),
                                minLeadingWidth: 20,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
