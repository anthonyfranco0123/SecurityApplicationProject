import 'dart:io';
// import 'dart:io' show Platform, stdout;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path/path.dart' as p;

class DownloadsGetter {
  String pattern = r"\.(txt|jar|pdf)$";
  // List<FileSystemEntity> filesList = [];
  List<String> filesListAsString = [];
  List<File> filesList = [];
  String userPath = '';
  final platformOperatingSystem = Platform.operatingSystem;

  // Get the home directory or null if unknown.
  void getHomeDirectory() {
    switch (platformOperatingSystem) {
      case 'linux':
      case 'macos':
        userPath = Platform.environment['HOME']!;
        break;
      case 'windows':
        userPath = Platform.environment['USERPROFILE']!;
        break;
      case 'android':
        userPath = '/storage/sdcard0';
        break;
      case 'ios':
        // iOS doesn't really have a home directory.
      case 'fuchsia':
        // I have no idea.
      default:
        userPath = '';
    }
  }

  void getPathName() {
  // File file = File("/abc.txt");
  // Path path = Path(file.path);
  // print(path.filename); // abc.txt
  // print(path.directoryPath); // /
}

  Future<String> getFileData(String path) async {
    return await rootBundle.loadString(path);
  }

  // String text = await getFileData("assets/textfile.txt");

  List<String> convertFilesListAsString() {
    for (int i = 0; i < filesList.length; i++) {
      filesListAsString[i] = filesList[i] as String;
    }
    // print(filesListAsString);
    return filesListAsString;
  }

  // _fetchFiles(Directory dir) {
  //   dir.list().forEach((element) {
  //     RegExp regExp = RegExp("\.(jar|pdf|txt)", caseSensitive: false);
  //     // Only add in List if file in path is supported
  //     if (regExp.hasMatch('$element')) {
  //       filesList.add(element);
  //       print(filesList);
  //     }
  //   });
  // }

  Future<List<FileSystemEntity>>? downloadsList(
      String? pathToDownloads, String platformOperatingSystem) {
    switch (platformOperatingSystem) {
      case 'windows':
        // Directory dir = Directory("$pathToDownloads\\Downloads");

        // List contents = dir.listSync();
        // _fetchFiles(Directory("$pathToDownloads\\Downloads"));
        // print(contents);
        // for (var fileOrDir in contents) {
        //   if (fileOrDir is File) {
        //   } else if (fileOrDir is Directory) {
        //     print(fileOrDir.path);
        //   }
        // }

//         dir.list(recursive: false).forEach((f) {
//           print(f);
//         });

        // convertFilesListAsString();
        print('---');
        return Directory("$pathToDownloads\\Downloads").list().toList();
    }
    return null;
  }

  Future<List<File>> getAllFilesWithExtension(String? pathToDownloads, String platformOperatingSystem) async {
    final List<FileSystemEntity> entities = await Directory("$pathToDownloads\\Downloads").list().toList();
    filesList = entities.whereType<File>().where((element) => p.extension(element.path) == pattern).toList();
    // print(filesList);
    print("$pathToDownloads\\Downloads");
    return filesList;
  }
}
