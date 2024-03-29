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


  static int getLowerCaseSetting() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final lowerCaseSetting = key1.getValueAsInt("LowerCaseLetters");
      if (lowerCaseSetting != null) {
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


  static int getUpperCaseSetting() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final upperCaseSetting = key1.getValueAsInt("UpperCaseLetters");
      if (upperCaseSetting != null) {
        return upperCaseSetting;
      }

      setUpperCaseSetting();
      return -1;
    } catch (e) {
      setUpperCaseSetting();
      return -1;
    }
  }

  static void setUpperCaseSetting() async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v UppercaseLetters /t Reg_Dword /d 1 /f
       
         ''');

  }


  static int getSpecialCharSetting() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final specialCharSetting = key1.getValueAsInt("SpecialCharacters");
      if (specialCharSetting != null) {
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

  static int getMinPwLen() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final minLen = key1.getValueAsInt("MinimumPINLength");
      if (minLen != null) {
        return minLen;
      }
      setMinPwLen(8);
      return -1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setMinPwLen(8);
      return -2;
    }
  }

  static void setMinPwLen(int len) async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v MinimumPINLength /t Reg_Dword /d $len /f
       
         ''');

  }


  static int getMaxPwLen() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final maxLen = key1.getValueAsInt("MaximumPINLength");
      if (maxLen != null) {
        return maxLen;
      }
      setMaxPwLen(32);
      return -1;
    } catch (e) {
      //final key2 = Registry.openPath(RegistryHive.localMachine,
      // path: r'SYSTEM\CurrentControlSet\Policies\');
      setMaxPwLen(32);
      return -2;
    }
  }

  static void setMaxPwLen(int len) async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v MaximumPINLength /t Reg_Dword /d $len /f
       
         ''');

  }


  static int getPwAge() {
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final pwAge = key1.getValueAsInt("Expiration");
      if (pwAge != null) {
        return pwAge;
      }

      setPwAge(90);
      return -1;
    } catch (e) {
      setPwAge(90);
      return -2;
    }
  }

  static void setPwAge(int age) async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v Expiration /t Reg_Dword /d $age /f
       
         ''');

  }

  static int getPwHist(){
    try {
      final key1 = Registry.openPath(RegistryHive.localMachine,
          path: r'SOFTWARE\Policies\Microsoft\PassportForWork\PINComplexity');

      final pwHist = key1.getValueAsInt("History");
      if (pwHist  != null) {
        return pwHist ;
      }

      setPwHist(10);
      return -1;
    } catch (e) {
      setPwHist(10);
      return -2;
    }
  }

  static void setPwHist(int history) async {
    var shell = PRS.Shell();
    await shell.run('''
       
       reg add HKEY_LOCAL_MACHINE\\SOFTWARE\\Policies\\Microsoft\\PassportForWork\\PINComplexity /v History /t Reg_Dword /d $history /f
       
         ''');

  }

}