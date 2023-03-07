import 'dart:io';
// import 'dart:io' show Platform, stdout;
import 'package:path/path.dart' as p;

class DownloadsGetter {
  String pattern = r"\.(txt|jar|pdf)$";
  List<FileSystemEntity> filesList = [];

  List<FileSystemEntity> getFilesList() {
    return filesList;
  }

  _fetchFiles(Directory dir) {
    dir.list().forEach((element) {
      RegExp regExp = RegExp("\.(jar|pdf|txt)", caseSensitive: false);
      // Only add in List if file in path is supported
      if (regExp.hasMatch('$element')) {
        filesList.add(element);
        print(filesList);
      }
    });
  }

  Future<List<FileSystemEntity>>? downloadsList(
      String? pathToDownloads, String platformOperatingSystem) {
    switch (platformOperatingSystem) {
      case 'windows':
        // Directory dir = Directory("$pathToDownloads\\Downloads");

        // List contents = dir.listSync();
        _fetchFiles(Directory("$pathToDownloads\\Downloads"));
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

        return Directory("$pathToDownloads\\Downloads").list().toList();
    }
    return null;
  }

  Future<List<File>> getAllFilesWithExtension(String? pathToDownloads, String platformOperatingSystem) async {
    final List<FileSystemEntity> entities = await Directory("$pathToDownloads\\Downloads").list().toList();
    return entities.whereType<File>().where((element) => p.extension(element.path) == pattern).toList();
  }
}
