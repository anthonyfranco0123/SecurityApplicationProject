import 'dart:io';

class DownloadRestrictionsSystemInfo {
  static String userPath = '';
  static String userDownloadsPath = '';
  static List<String> initialFilesList = [];
  static List<String> filesList = [];
  static List<String> filesSizeList = [];
  static String targetPath = '';
  static bool exists = false;

  String getHomeDirectory() {
    switch (Platform.operatingSystem) {
      case 'linux':
      case 'macos':
        return Platform.environment['HOME']!;
      case 'windows':
        return Platform.environment['USERPROFILE']!;
      case 'android':
        return '/storage/sdcard0';
      case 'ios':
      // iOS doesn't really have a home directory.
      case 'fuchsia':
      // I have no idea.
      default:
        return '';
    }
  }

  Future<void> futureStringListToStringList(Future<List<String>> fsl) async {
    filesList = await fsl;
  }

  Future<void> futureStringToStringList(Future<String> fsl) async {
    String awaitedString = await fsl;
    filesSizeList.add(awaitedString);
  }
}
