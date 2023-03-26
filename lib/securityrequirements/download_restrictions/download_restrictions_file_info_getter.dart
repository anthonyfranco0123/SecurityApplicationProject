import 'dart:io';
import 'dart:math';

import 'download_restrictions_system_info.dart';
// import 'package:path/path.dart' as p;

class DownloadRestrictionsFileInfoGetter {
  // String pattern = r"\.(txt|jar|pdf)$";
  RegExp regExp = RegExp(r"\.(txt|jar|pdf)$");
  // String filesPath = '';
  // int filesPathLength = -1;

  Future<List<String>> getAllFilesWithExtension(
      String? pathToDownloads, String platformOperatingSystem) async {
    DownloadRestrictionsSystemInfo.filesList = [];
    // DownloadRestrictionsSystemInfo.filesSizeList = [];
    final List<FileSystemEntity> filesFromDownloads =
        await Directory('$pathToDownloads').list().toList();
    for (int i = 0; i < filesFromDownloads.length; i++) {
      String fileExtension = (filesFromDownloads.elementAt(i) as File)
          .path.substring((filesFromDownloads.elementAt(i) as File)
          .path.lastIndexOf('.'));
      if(regExp.hasMatch(fileExtension)) {
        DownloadRestrictionsSystemInfo.filesList.add(
            (filesFromDownloads.elementAt(i) as File)
                .path
                .split(Platform.pathSeparator)
                .last);
        // DownloadRestrictionsSystemInfo().futureStringToStringList(getFileSize((filesFromDownloads.elementAt(i) as File)
        //     .path, 2));
      }
    }
    // print('Before');
    // print(DownloadRestrictionsSystemInfo.filesSizeList);
    return DownloadRestrictionsSystemInfo.filesList;
  }

  Future<String> getFileSize(String filepath, int decimals) async {
    var file = File(filepath);
    int bytes = await file.length();
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
    var i = (log(bytes) / log(1024)).floor();
    return '${(bytes / pow(1024, i)).toStringAsFixed(decimals)} ${suffixes[i]}';
  }
}
