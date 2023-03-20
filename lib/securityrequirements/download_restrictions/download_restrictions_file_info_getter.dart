import 'dart:io';
import 'dart:math';

import 'download_restrictions_system_info.dart';
// import 'package:path/path.dart' as p;

class DownloadRestrictionsFileInfoGetter {
  String pattern = r"\.(txt|jar|pdf)$";
  String filesPath = '';
  int filesPathLength = -1;

  Future<List<String>> getAllFilesWithExtension(
      String? pathToDownloads, String platformOperatingSystem) async {
    // setDownloadsPathInfo(pathToDownloads, platformOperatingSystem);
    final List<FileSystemEntity> filesFromDownloads =
        await Directory('$pathToDownloads').list().toList();
    for (int i = 1; i < filesFromDownloads.length; i++) {
      DownloadRestrictionsSystemInfo.filesList.add(
          (filesFromDownloads.elementAt(i) as File)
              .path
              .split(Platform.pathSeparator)
              .last);
    }
    print(DownloadRestrictionsSystemInfo.filesList);
    return DownloadRestrictionsSystemInfo.filesList;
  }

  getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
