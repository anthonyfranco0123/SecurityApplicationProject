import 'package:shell/shell.dart';
import 'package:process_run/shell.dart' as PRS;
import 'package:win32_registry/win32_registry.dart';
class EventLogsAccess {
  String output = '';
  bool state = false;

  // Future<String> _runShellCommand() async {
  //   final shell = Shell();
  //   return await shell
  //       .startAndReadAsString('sc', arguments: ['query', "eventlog"]);
  // }

  /*Future<String> futureStringToString() async {
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
*/
  /*static Future<int> disableSecurityLog()  async {
    var shell = PRS.Shell();
    try {
      await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v LowercaseLetters /t Reg_Dword /d 1 /f
       
         ''');
    }
    catch(e){
      print(e);
      print("\n");
    }
  }
*/
  static int getSecurityLog() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SYSTEM\CurrentControlSet\Control\\MiniNT');

      if (key1.values.length>0) {
        delSecurityLog();
        return 1;
      }
      //delSecurityLog();
      return 1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      //setMinPwLen(8);
      return 0;
    }
  }

  static void delSecurityLog() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg delete HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\MiniNT /f
       
         ''');

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
