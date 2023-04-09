import 'dart:io';
import 'dart:math';

import 'package:process_run/shell.dart';

import 'download_restrictions_system_info.dart';
// import 'package:path/path.dart' as p;

class DownloadRestrictionsFileInfoGetter {
  // String pattern = r"\.(txt|jar|pdf)$";
  RegExp regExp = RegExp(r"\.(txt|jar|pdf)$");
  // String filesPath = '';
  // int filesPathLength = -1;
  final _shell = Shell();

  Future<List<String>> getAllFilesWithExtension(
      String? pathToDownloads, String platformOperatingSystem) async {
    DownloadRestrictionsSystemInfo.filesList = [];
    // DownloadRestrictionsSystemInfo.filesSizeList = [];
    final List<FileSystemEntity> filesFromDownloads =
        await Directory('$pathToDownloads').list().toList();
    for (int i = 0; i < filesFromDownloads.length; i++) {
      try {
        String fileExtension = (filesFromDownloads.elementAt(i) as File)
            .path.substring((filesFromDownloads.elementAt(i) as File)
            .path.lastIndexOf('.'));
        if(regExp.hasMatch(fileExtension)) {
          String fileNameWithExtension = (filesFromDownloads.elementAt(i) as File)
              .path
              .split(Platform.pathSeparator)
              .last;
          DownloadRestrictionsSystemInfo.filesList.add(
              // (filesFromDownloads.elementAt(i) as File)
              //     .path
              //     .split(Platform.pathSeparator)
              //     .last);
              fileNameWithExtension);
          // DownloadRestrictionsSystemInfo().futureStringToStringList(getFileSize((filesFromDownloads.elementAt(i) as File)
          //     .path, 2));
          if(DownloadRestrictionsSystemInfo.exists) {
            // String targetPath = '${DownloadRestrictionsSystemInfo.userPath}''\\Desktop\\Potential_Threats\\';
            // await moveFile(filesFromDownloads.elementAt(i) as File, targetPath);
            _shell.run('''
            move "${DownloadRestrictionsSystemInfo.userPath}\\Downloads\\$fileNameWithExtension" "${DownloadRestrictionsSystemInfo.userPath}\\Desktop\\Potential_Threats\\"
            ''');
          }
        }
      } catch (e) {
        // Error cuz its not a file and probably a folder or zip
      }
    }
    return DownloadRestrictionsSystemInfo.filesList;
  }

  Future<File> moveFile(File originalFile, String targetPath) async {
    try {
      // This will try first to just rename the file if they are on the same directory,
      return await originalFile.rename(targetPath);

    } on FileSystemException catch (e) {
      print(e);
      // if the rename method fails, it will copy the original file to the new directory and then delete the original file
      final newFileInTargetPath = await originalFile.copy(targetPath);
      await originalFile.delete();
      return newFileInTargetPath;
    }
  }

  Future<void> directoryExists(String targetPath) async {
    DownloadRestrictionsSystemInfo.exists = await Directory(targetPath).exists();
  }

  createDirectory() {
    _shell.run('''
    cd "${DownloadRestrictionsSystemInfo.userPath}\\Desktop\\" && mkdir Potential_Threats
    ''');
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
