import 'package:win32_registry/win32_registry.dart';
import 'package:process_run/shell.dart' as PRS;

class RegistryAccess {
  static Future changeMaxPwAge() async {
    // This works on Windows/Linux/Mac
    var shell = PRS.Shell();
    await shell.run('''
    
            net accounts /maxpwage:90

       ''');
  }
  static Future changeMinPwLen() async {
    // This works on Windows/Linux/Mac
    var shell = PRS.Shell();
    await shell.run('''
    
            net accounts /minpwlen:8

       ''');
  }

  static Future changePwHist() async {
    // This works on Windows/Linux/Mac
    var shell = PRS.Shell();
    await shell.run('''
    
            net accounts /uniquepw:10

       ''');
  }


  static Future<int> getLowerCaseSetting() async {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final lowerCaseSetting = key1.getValueAsInt("LowerCaseLetters");
      if (lowerCaseSetting != null) {
        //print(bootStart);
        return lowerCaseSetting;
      }
      setLowerCaseSetting();
      return -1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setLowerCaseSetting();
      return -2;
    }
  }

  static void setLowerCaseSetting() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v LowercaseLetters /t Reg_Dword /d 1 /f
       
         ''');

  }


  static Future<int> getUpperCaseSetting() async {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final upperCaseSetting = key1.getValueAsInt("UpperCaseLetters");
      if (upperCaseSetting != null) {
        //print(bootStart);
        return upperCaseSetting;
      }

      setUpperCaseSetting();
      return -1;
    } catch (e) {
      setUpperCaseSetting();
      return -2;
    }
  }

  static void setUpperCaseSetting() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v UppercaseLetters /t Reg_Dword /d 1 /f
       
         ''');

  }


  static Future<int> getSpecialCharSetting() async {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final specialCharSetting = key1.getValueAsInt("SpecialCharacters");
      if (specialCharSetting != null) {
        //print(bootStart);
        return specialCharSetting;
      }
      setSpecialCharSetting();
      return -1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setSpecialCharSetting();
      return -2;
    }
  }

  static void setSpecialCharSetting() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v SpecialCharacters /t Reg_Dword /d 1 /f
       
         ''');

  }

  static Future<int> getMinPwLen() async {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final minLen = key1.getValueAsInt("MinimumPINLength");
      if (minLen != null) {
        //print(bootStart);
        return minLen;
      }
      setMinPwLen();
      return -1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setMinPwLen();
      return -2;
    }
  }

  static void setMinPwLen() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v MinimumPINLength /t Reg_Dword /d 8 /f
       
         ''');

  }


  static Future<int> getMaxPwLen() async {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final maxLen = key1.getValueAsInt("MaximumPINLength");
      if (maxLen != null) {
        //print(bootStart);
        return maxLen;
      }
      setMaxPwLen();
      return -1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setMaxPwLen();
      return -2;
    }
  }

  static void setMaxPwLen() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v MaximumPINLength /t Reg_Dword /d 32 /f
       
         ''');

  }
}