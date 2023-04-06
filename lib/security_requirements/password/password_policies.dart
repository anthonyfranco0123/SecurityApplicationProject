import 'registry_access.dart';

class PasswordPolicies {
  static int pwHist = -1;
  static int maxPwAge = -1;
  static int minLength = -1;
  static int maxLength = -1;
  static int upperCase = -1;
  static int lowerCase = -1;
  static int special = -1;

  static void getPwHist() {
    pwHist = RegistryAccess.getPwHist();
  }
  static void getMaxPwAge() {
    pwHist = RegistryAccess.getPwAge();
  }
  static Future<void> getPwMinLen() async {
    pwHist = await RegistryAccess.getMinPwLen();
  }
  static Future<void> getPwMaxLen() async {
    pwHist = await RegistryAccess.getMaxPwLen();
  }
  static Future<void> getUpperCase() async {
    pwHist = await RegistryAccess.getUpperCaseSetting();
  }
  static Future<void> getLowerCase() async {
    pwHist = await RegistryAccess.getLowerCaseSetting();
  }
  static Future<void> getSpecial() async {
    pwHist = await RegistryAccess.getSpecialCharSetting();
  }

}