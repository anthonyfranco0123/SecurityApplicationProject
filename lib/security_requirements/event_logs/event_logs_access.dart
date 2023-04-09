import 'package:shell/shell.dart';

class EventLogsAccess {
  String output = '';
  bool state = false;

  // Future<String> _runShellCommand() async {
  //   final shell = Shell();
  //   return await shell
  //       .startAndReadAsString('sc', arguments: ['query', "eventlog"]);
  // }

  Future<String> futureStringToString() async {
    final shell = Shell();
    return output = await shell
        .startAndReadAsString('sc', arguments: ['query', "eventlog"]);
  }

  // int eventLogsState() {
  //   _futureStringToString(_runShellCommand());
  //   if(state) {
  //   }
  //   if (output.contains("STOPPED")) {
  //     return 0;
  //   } else if (output.contains("RUNNING")) {
  //     return 1;
  //   } else {
  //     return -1;
  //   }
  // }
}
