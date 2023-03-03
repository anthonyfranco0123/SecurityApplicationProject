import 'dart:io';
// import 'dart:io' show Platform, stdout;

class DownloadsGetter {
  String pattern = r"\.(txt|jar|pdf)$";

  List<FileSystemEntity> listFiles = [];
  _fetchFiles(Directory dir) {
    dir.list().forEach((element) {
      RegExp regExp =
      RegExp("\.(gif|jpe?g|tiff?|png|webp|bmp|txt)", caseSensitive: false);
      // Only add in List if file in path is supported
      if (regExp.hasMatch('$element')) {
        listFiles.add(element);
        print(listFiles);
      }
    });
  }

  Future<List<FileSystemEntity>>? downloadsList(String? pathToDownloads, String platformOperatingSystem) {
    switch(platformOperatingSystem){
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
}