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
    try {
      // await shell.start('reg.exe delete HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\MiniNT /f');
      // await shell.start('Remove-Item Registry::HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\MiniNT -Recurse  -Force');
      // await shell.start('Remove-Item -Path HKLM:\SYSTEM\CurrentControlSet\Control\MiniNT -Force -Verbose');
      //TO DO
      await shell.start('Get-Item HKLM:\SYSTEM\CurrentControlSet\Control\MiniNT | Remove-Item -Force -Verbose');
      print('Success');
    } catch(e) {
      print('Error: E-Log');
      print(e);
    }
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
