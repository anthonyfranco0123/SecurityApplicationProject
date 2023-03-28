import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';

// import '../database/sqltest.dart';
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
  late Timer timer;
  @override
  bool get wantKeepAlive => true;
  // bool firstInitialization = false;
  String deviceName= "Test Device";
  String macAddress= "AA:BB:CC:DD:EE:FF";
  String timestamp= "2023-04-01 12:34:56";
  String password= "test_password";
  int passwordRestriction= 1;
  int passwordExpiration= 1;
  int autoUpdates= 1;
  String systemPrivilege= "user";
  int firewall= 1;

  @override
  void initState() {
    // userPath = _getHomeDirectory();
    // DownloadsGetter().setDownloadsPathInfo(_getHomeDirectory(), platformOperatingSystem);
    // SQLTest().getmySQLData();
    // SQLTest().setMySQLData(deviceName, macAddress, timestamp, password, passwordRestriction, passwordExpiration, autoUpdates, systemPrivilege, firewall);
    // DownloadRestrictionsSystemInfo().futureStringListToStringList(
    //     DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
    //         DownloadRestrictionsSystemInfo.userDownloadsPath,
    //         platformOperatingSystem));
    super.initState();
  }

  @override
  void dispose() {
    timer.cancel();
    super.dispose();
  }

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
    _periodicallyUpdateDownloadRestrictions();
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
      overflow: TextOverflow.fade,
    );
  }

  void _periodicallyUpdateDownloadRestrictions() {
    // DownloadRestrictionsSystemInfo.filesList = [];
    // DownloadRestrictionsSystemInfo().futureStringListToStringList(
    //     DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
    //         DownloadRestrictionsSystemInfo.userDownloadsPath,
    //         Platform.operatingSystem));
    // if(firstInitialization!) {
    //   firstInitialization = true;
    //   DownloadRestrictionsSystemInfo().futureStringListToStringList(
    //       DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
    //           DownloadRestrictionsSystemInfo.userDownloadsPath,
    //           Platform.operatingSystem));
    // }
      Timer.periodic(const Duration(seconds: 4), (timer) {
        setState(() {
          // if (DownloadRestrictionsSystemInfo.filesList.isNotEmpty) {
          // DownloadRestrictionsSystemInfo.filesList = [];
          DownloadRestrictionsSystemInfo().futureStringListToStringList(
              DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
                  DownloadRestrictionsSystemInfo.userDownloadsPath,
                  Platform.operatingSystem));
          // }
        });
      });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    // DownloadRestrictionsSystemInfo().futureStringListToStringList(
    //     DownloadRestrictionsFileInfoGetter().getAllFilesWithExtension(
    //         DownloadRestrictionsSystemInfo.userDownloadsPath,
    //         platformOperatingSystem));
    // print(DownloadRestrictionsSystemInfo.filesList);
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
                  if (sh > 240 && sw > 240)
                  SizedBox(
                    width: sw * 0.4,
                    height: sh * 0.4,
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
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
